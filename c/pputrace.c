/* Run the decompiled CPU through the PPU model and print the command stream.
 *
 *   pputrace [prg.bin]
 *
 * The CPU's reset routine runs until it reaches the NMI wait loop, then one
 * NMI frame is executed. Every PPU register write (and OAM DMA) is logged, so
 * this is the game's "GPU program" as seen at the register level.
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "cpu.h"
#include "ppu.h"

extern CpuOp optab[0x10000];
extern void smb_cpu_init(Cpu *c, const u8 *prg);
extern int smb_cpu_step(Cpu *c);

static u8 PRG[0x8000];
static Ppu ppu;

static const char *kind_name(u8 k) {
    switch (k) {
    case PPU_CTRL: return "PPUCTRL   ";
    case PPU_MASK: return "PPUMASK   ";
    case PPU_SCROLL: return "PPUSCROLL ";
    case PPU_ADDR: return "PPUADDR   ";
    case PPU_OAMADDR: return "OAMADDR   ";
    case PPU_OAMDMA: return "OAMDMA    ";
    case PPU_DATA_W: return "PPUDATA<- ";
    case PPU_DATA_R: return "PPUDATA-> ";
    default: return "PPUSTATUS ";
    }
}

static int load_prg(const char *path) {
    FILE *f = fopen(path, "rb");
    size_t n;
    if (!f) return 0;
    n = fread(PRG, 1, 0x8000, f);
    fclose(f);
    return n == 0x8000;
}

int main(int argc, char **argv) {
    Cpu c;
    const char *path = (argc > 1) ? argv[1] : getenv("SMB_PRG");
    long steps = 0;
    int reset_log = 0;
    int i;

    if (!path) path = "../out/prg.bin";
    if (!load_prg(path)) {
        fprintf(stderr, "pputrace: cannot read PRG from '%s' (see README)\n", path);
        return 2;
    }

    smb_cpu_init(&c, PRG);
    ppu_init(&ppu);
    ppu_attach(&ppu);
    c.pc = 0x8000;

    /* Reset: run until the program settles into the `JMP $8057` NMI wait. */
    while (steps < 500000 && optab[c.pc] && c.pc != 0x8057) {
        smb_cpu_step(&c);
        steps++;
    }
    printf("reset ran %ld steps, reached $%04X\n", steps, c.pc);
    reset_log = ppu.log_n;

    /* One NMI frame. */
    c.pc = 0x8082;
    for (i = 0; i < 300000 && optab[c.pc]; i++)
        smb_cpu_step(&c);
    printf("NMI ran %d steps\n\n", i);

    printf("=== PPU command stream (in order) ===\n");
    printf("  --- reset ---\n");
    for (i = 0; i < ppu.log_n; i++) {
        if (i == reset_log) printf("  --- NMI frame ---\n");
        u8 k = ppu.log[i].kind;
        u16 a = ppu.log[i].addr;
        u8 v = ppu.log[i].val;
        int n = ppu.log[i].count;
        if (k == PPU_DATA_W) {
            printf("  %s[$%04X] <- $%02X", kind_name(k), a, v);
            if (n > 1) printf("  (x%d)", n);
            printf("\n");
        } else if (k == PPU_DATA_R)
            printf("  %s[$%04X] -> $%02X\n", kind_name(k), a, v);
        else if (k == PPU_OAMDMA)
            printf("  %s page $%04X (256 bytes)\n", kind_name(k), a);
        else if (k == PPU_ADDR)
            printf("  %s = $%04X\n", kind_name(k), a);
        else
            printf("  %s = $%02X\n", kind_name(k), v);
    }
    printf("\ncommands logged: %d\n", ppu.log_n);
    return 0;
}
