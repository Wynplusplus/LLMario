/* Differential test: the decompiled C vs the independent interpreter.
 *
 * Phase 0: traces from the RESET/NMI/IRQ vectors.
 * Phase 1: every translated instruction, one step, randomised state.
 * Phase 1b: dispatch-table coverage (no gaps for translated addresses).
 * Phase 2: random multi-step traces.
 *
 * Gap detection: if execution reaches an address that has no translated
 * function but IS a static control-flow target, that is reported as a
 * translation gap rather than silently ending the trace.
 */
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "cpu.h"
#include "out/xlt.h"
#include "out/ref_optable.h"

extern CpuOp optab[0x10000];
extern void smb_cpu_init(Cpu *c, const u8 *prg);
extern int smb_cpu_step(Cpu *c);
extern int ref_step(Cpu *c);
extern int ref_successors(Cpu *c, unsigned *out);

static u8 PRG[0x8000];

static int load_prg(const char *path) {
    FILE *f = fopen(path, "rb");
    size_t n;
    if (!f) return 0;
    n = fread(PRG, 1, 0x8000, f);
    fclose(f);
    return n == 0x8000;
}

static unsigned long long rng_state = 0x123456789abcdefULL;
static unsigned rnd(void) {
    rng_state ^= rng_state << 13;
    rng_state ^= rng_state >> 7;
    rng_state ^= rng_state << 17;
    return (unsigned)(rng_state >> 32);
}

static int memdiff(Cpu *x, Cpu *y, unsigned *where) {
    unsigned i;
    for (i = 0; i < 0x10000; i++)
        if (x->mem[i] != y->mem[i]) { *where = i; return 1; }
    return 0;
}

static unsigned long trials = 0, steps = 0, mismatches = 0, gaps = 0;
static unsigned char targetbit[0x10000];
static Cpu g_base;

static void report(const char *tag, Cpu *a, Cpu *b, unsigned addr, unsigned step) {
    unsigned md = 0;
    mismatches++;
    printf("MISMATCH [%s] start=$%04X step=%u\n", tag, addr, step);
    printf("  C  : pc=%04X a=%02X x=%02X y=%02X s=%02X p=%02X\n", a->pc, a->a, a->x, a->y, a->s, a->p);
    printf("  ref: pc=%04X a=%02X x=%02X y=%02X s=%02X p=%02X\n", b->pc, b->a, b->x, b->y, b->s, b->p);
    if (memdiff(a, b, &md))
        printf("  mem first diff at $%04X: C=%02X ref=%02X\n", md, a->mem[md], b->mem[md]);
}

static void randomize(Cpu *c, unsigned seed) {
    unsigned i;
    rng_state ^= seed * 0x9E3779B97F4A7C15ULL + 0x1234;
    c->a = (u8)rnd(); c->x = (u8)rnd(); c->y = (u8)rnd();
    c->s = (u8)(0x80 + (rnd() & 0x7f));
    c->p = (u8)(rnd() | F_U);
    for (i = 0; i < 0x8000; i++) c->mem[i] = (u8)rnd();
}

/* Mark every static successor of every translated instruction. */
static void build_targets(void) {
    unsigned i;
    int t;
    for (i = 0; i < XLT_COUNT; i++) {
        Cpu c = g_base;
        unsigned out[3];
        int n;
        c.pc = (u16)XLT_ADDRS[i];
        n = ref_successors(&c, out);
        for (t = 0; t < n; t++)
            /* Only ROM addresses can be translated code. A target below $8000
             * is RAM (e.g. an indirect jump or a mis-decoded data byte), not a
             * translation gap. Illegal opcodes are data, not gaps either. */
            if (out[t] >= 0x8000 && out[t] < 0x10000 &&
                REF_MN[g_base.mem[out[t]]] != 0xFF)
                targetbit[out[t]] = 1;
    }
}

/* Step both once, comparing. Returns 0 to stop. */
static int one_step(Cpu *c1, Cpu *c2, const char *tag, unsigned start, unsigned step) {
    unsigned md = 0;
    if (!optab[c1->pc]) {
        if (targetbit[c1->pc]) {
            gaps++;
            printf("GAP [%s] start=$%04X step=%u: $%04X is a translated target but optab is NULL\n",
                   tag, start, step, c1->pc);
        }
        return 0;
    }
    smb_cpu_step(c1);
    if (ref_step(c2) != 0) return 0;
    if (c1->pc != c2->pc || c1->a != c2->a || c1->x != c2->x || c1->y != c2->y ||
        c1->s != c2->s || c1->p != c2->p || memdiff(c1, c2, &md)) {
        report(tag, c1, c2, start, step);
        return 0;
    }
    steps++;
    return 1;
}

int main(int argc, char **argv) {
    Cpu base, c1, c2;
    unsigned addr, i;
    const char *prg_path = (argc > 1) ? argv[1] : getenv("SMB_PRG");

    if (!prg_path) prg_path = "../out/prg.bin";
    if (!load_prg(prg_path)) {
        fprintf(stderr, "difftest: cannot read 32768-byte PRG image from '%s'\n",
                prg_path);
        fprintf(stderr, "Pass the path as an argument or set SMB_PRG. Extract\n");
        fprintf(stderr, "it from your own ROM with ../extract_rom.sh.\n");
        return 2;
    }

    smb_cpu_init(&base, PRG);
    g_base = base;
    build_targets();

    /* Phase 1b: every translated address must have a function. */
    for (i = 0; i < XLT_COUNT; i++) {
        if (!optab[XLT_ADDRS[i]]) {
            printf("GAP: translated address $%04X has no function\n", XLT_ADDRS[i]);
            gaps++;
        }
    }

    /* Phase 0: vectors (NMI/IRQ/RESET), with PPU status set so polls pass. */
    {
        static const unsigned vecs[3] = { 0x8000, 0x8082, 0xFFF0 };
        int v;
        for (v = 0; v < 3; v++) {
            int t;
            for (t = 0; t < 30; t++) {
                unsigned s;
                smb_cpu_init(&base, PRG);
                base.pc = (u16)vecs[v];
                randomize(&base, (unsigned)(0x5EED00 + v * 100 + t));
                base.mem[0x2002] = 0x80;
                base.p = F_U;
                c1 = base; c2 = base;
                for (s = 0; s < 500; s++)
                    if (!one_step(&c1, &c2, "vector", vecs[v], s + 1)) break;
                trials++;
            }
        }
    }

    /* Phase 1: every translated instruction, one step. */
    for (addr = 0; addr < 0x10000; addr++) {
        if (!optab[addr]) continue;
        smb_cpu_init(&base, PRG);
        base.pc = (u16)addr;
        randomize(&base, addr);
        c1 = base; c2 = base;
        one_step(&c1, &c2, "single", addr, 1);
        trials++;
    }

    /* Phase 2: random multi-step traces. */
    {
        int t;
        for (t = 0; t < 500; t++) {
            unsigned start, n, s;
            smb_cpu_init(&base, PRG);
            do { start = 0x8000 + (rnd() % 0x8000); } while (!optab[start]);
            base.pc = (u16)start;
            randomize(&base, (unsigned)(0xABC000 + t));
            c1 = base; c2 = base;
            n = 50 + (rnd() % 400);
            for (s = 0; s < n; s++)
                if (!one_step(&c1, &c2, "trace", start, s + 1)) break;
            trials++;
        }
    }

    printf("translated=%u  trials=%lu steps=%lu mismatches=%lu gaps=%lu\n",
           (unsigned)XLT_COUNT, trials, steps, mismatches, gaps);
    return (mismatches || gaps) ? 1 : 0;
}
