/* A fixed-function NES PPU register model.
 *
 * The NES PPU has no instruction set: the CPU programs it by writing eight
 * memory-mapped registers ($2000-$2007) and $4014 (OAM DMA). This model
 * implements that interface (address latch, auto-increment, buffered data
 * reads, OAM DMA, palette/VRAM mirroring) and records the command stream the
 * decompiled CPU issues, so the game's "GPU program" can be inspected.
 */
#ifndef PPU_H
#define PPU_H

#include "cpu.h"

enum {
    PPU_CTRL, PPU_MASK, PPU_SCROLL, PPU_ADDR, PPU_OAMADDR, PPU_OAMDMA,
    PPU_DATA_W, PPU_DATA_R, PPU_STATUS_R
};

#define PPU_LOG_MAX 40000

typedef struct { u8 kind; u16 addr; u8 val; int count; } PpuLogEntry;

typedef struct {
    u8 ctrl, mask, status, oam_addr;
    u8 oam[256];
    u8 vram[0x800];     /* 2 KiB nametables */
    u8 palette[0x20];
    u16 v;              /* current VRAM address (14-bit) */
    u8 w;               /* first/second write toggle */
    u8 read_buf;
    /* command log */
    int log_n;
    PpuLogEntry log[PPU_LOG_MAX];
} Ppu;

void ppu_init(Ppu *p);
/* Install this PPU into the generated CPU's I/O hooks. */
void ppu_attach(Ppu *p);
u8 ppu_read(Ppu *p, Cpu *c, u16 addr);
void ppu_write(Ppu *p, Cpu *c, u16 addr, u8 val);

#endif
