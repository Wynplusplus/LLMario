/* NES PPU register model + command logger. See ppu.h. */
#include "ppu.h"

extern void (*g_io_write)(Cpu *, u16, u8);
extern u8 (*g_io_read)(Cpu *, u16);

static Ppu *g_ppu;

static void log_add(Ppu *p, u8 kind, u16 addr, u8 val) {
    if (p->log_n > 0) {
        PpuLogEntry *last = &p->log[p->log_n - 1];
        if (kind == PPU_DATA_W && last->kind == PPU_DATA_W &&
            last->val == val && (u16)(last->addr + last->count) == addr) {
            last->count++;
            return;
        }
    }
    if (p->log_n < PPU_LOG_MAX) {
        p->log[p->log_n].kind = kind;
        p->log[p->log_n].addr = addr;
        p->log[p->log_n].val = val;
        p->log[p->log_n].count = 1;
        p->log_n++;
    }
}

void ppu_init(Ppu *p) {
    int i;
    for (i = 0; i < (int)sizeof(*p); i++) ((u8 *)p)[i] = 0;
    p->v = 0;
    p->w = 0;
}

static u8 io_read_hook(Cpu *c, u16 addr) {
    return ppu_read(g_ppu, c, addr);
}
static void io_write_hook(Cpu *c, u16 addr, u8 val) {
    ppu_write(g_ppu, c, addr, val);
}

void ppu_attach(Ppu *p) {
    g_ppu = p;
    g_io_read = io_read_hook;
    g_io_write = io_write_hook;
}

static u8 pal_index(u16 a) {
    /* $3F10/$3F14/$3F18/$3F1C mirror $3F00/$3F04/$3F08/$3F0C. */
    u8 i = (u8)((a - 0x3F00) & 0x1F);
    if ((i & 0x13) == 0x10) i = (u8)(i - 0x10);
    return i;
}

static void ppu_write_data(Ppu *p, u8 val) {
    u16 a = p->v & 0x3FFF;
    if (a >= 0x3F00) {
        p->palette[pal_index(a)] = val;
    } else {
        p->vram[a & 0x07FF] = val;
    }
    log_add(p, PPU_DATA_W, a, val);
    p->v = (u16)(p->v + ((p->ctrl & 0x04) ? 32 : 1));
}

u8 ppu_read(Ppu *p, Cpu *c, u16 addr) {
    (void)c;
    switch (addr & 0x2007) {
    case 0x2002: {
        /* VBlank is reported set so the game's frame polling makes progress;
         * reading it clears the write toggle, as on hardware. */
        u8 s = (u8)(p->status | 0x80);
        p->w = 0;
        log_add(p, PPU_STATUS_R, 0x2002, s);
        return s;
    }
    case 0x2007: {
        u16 a = p->v & 0x3FFF;
        u8 r;
        if (a >= 0x3F00) {
            /* Palette reads return immediately and reload the buffer from the
             * nametable byte "behind" the palette, as on hardware. */
            r = p->palette[pal_index(a)];
            p->read_buf = p->vram[a & 0x07FF];
        } else {
            r = p->read_buf;
            p->read_buf = p->vram[a & 0x07FF];
        }
        p->v = (u16)(p->v + ((p->ctrl & 0x04) ? 32 : 1));
        log_add(p, PPU_DATA_R, a, r);
        return r;
    }
    default:
        return 0xFF;
    }
}

void ppu_write(Ppu *p, Cpu *c, u16 addr, u8 val) {
    switch (addr & 0x2007) {
    case 0x2000:
        p->ctrl = val;
        log_add(p, PPU_CTRL, 0x2000, val);
        break;
    case 0x2001:
        p->mask = val;
        log_add(p, PPU_MASK, 0x2001, val);
        break;
    case 0x2003:
        p->oam_addr = val;
        log_add(p, PPU_OAMADDR, 0x2003, val);
        break;
    case 0x2004:
        p->oam[p->oam_addr++] = val;
        break;
    case 0x2005:
        log_add(p, PPU_SCROLL, 0x2005, val);
        break;
    case 0x2006:
        if (!p->w) {
            p->v = (u16)((val & 0x3F) << 8);
        } else {
            p->v = (u16)((p->v & 0x3F00) | val);
            log_add(p, PPU_ADDR, p->v, 0);
        }
        p->w = (u8)!p->w;
        break;
    case 0x2007:
        ppu_write_data(p, val);
        break;
    default:
        break;
    }
    if (addr == 0x4014) {
        /* OAM DMA: copy 256 bytes from CPU page val<<8 into OAM. */
        u16 src = (u16)(val << 8);
        int i;
        for (i = 0; i < 256; i++) p->oam[(p->oam_addr + i) & 0xFF] = c->mem[src + i];
        log_add(p, PPU_OAMDMA, src, val);
    }
}
