/* Independent 6502 interpreter used as the differential-test reference for the
 * decompiled C. Written separately from the generated code: it decodes from
 * memory each step and updates flags with explicit inline arithmetic, so a bug
 * in the generated translation shows up as a state divergence.
 *
 * Only the documented instruction set the ROM uses is implemented.
 */
#include "cpu.h"
#include "out/ref_optable.h"

static const int MODE_LEN[REF_MODE_COUNT] = {
    1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 2, 2, 2
};

static void psh(Cpu *c, u8 v) { c->mem[0x100 + c->s] = v; c->s = (u8)(c->s - 1); }
static u8 pul(Cpu *c) { c->s = (u8)(c->s + 1); return c->mem[0x100 + c->s]; }
static void psh16(Cpu *c, u16 v) { psh(c, (u8)(v >> 8)); psh(c, (u8)v); }
static u16 pul16(Cpu *c) { u8 lo = pul(c); u8 hi = pul(c); return (u16)(lo | (hi << 8)); }
static void nz(Cpu *c, u8 v) {
    c->p = (u8)((c->p & (u8)~(F_Z | F_N)) | (v == 0 ? F_Z : 0) | (v & 0x80));
}

int ref_step(Cpu *c) {
    u16 base = c->pc;
    u8 op = c->mem[base];
    unsigned mn = REF_MN[op];
    unsigned mode = REF_MODE[op];
    if (mn == 0xFF || mode == 0xFF) return -1;
    u16 npc = (u16)(base + MODE_LEN[mode]);
    u16 ea = 0;
    u8 m = 0, hi, lo;
    int olc;

    switch (mode) {
    case MODE_IMM: m = c->mem[base + 1]; break;
    case MODE_ZP: ea = c->mem[base + 1]; m = c->mem[ea]; break;
    case MODE_ZPX: ea = (u8)(c->mem[base + 1] + c->x); m = c->mem[ea]; break;
    case MODE_ZPY: ea = (u8)(c->mem[base + 1] + c->y); m = c->mem[ea]; break;
    case MODE_ABS: ea = (u16)(c->mem[base + 1] | (c->mem[base + 2] << 8)); m = c->mem[ea]; break;
    case MODE_ABX: ea = (u16)((c->mem[base + 1] | (c->mem[base + 2] << 8)) + c->x); m = c->mem[ea]; break;
    case MODE_ABY: ea = (u16)((c->mem[base + 1] | (c->mem[base + 2] << 8)) + c->y); m = c->mem[ea]; break;
    case MODE_IND: ea = (u16)(c->mem[base + 1] | (c->mem[base + 2] << 8)); break;
    case MODE_IZX: {
        u8 z = (u8)(c->mem[base + 1] + c->x);
        ea = (u16)(c->mem[z] | (c->mem[(u8)(z + 1)] << 8));
        m = c->mem[ea];
        break;
    }
    case MODE_IZY: {
        u8 z = c->mem[base + 1];
        u16 t = (u16)(c->mem[z] | (c->mem[(u8)(z + 1)] << 8));
        ea = (u16)(t + c->y);
        m = c->mem[ea];
        break;
    }
    case MODE_REL:
        ea = (u16)(base + 2 + (int)(signed char)c->mem[base + 1]);
        break;
    default: break; /* imp / acc */
    }

    switch (mn) {
    case MN_LDA: c->a = m; nz(c, c->a); break;
    case MN_LDX: c->x = m; nz(c, c->x); break;
    case MN_LDY: c->y = m; nz(c, c->y); break;
    case MN_STA: c->mem[ea] = c->a; break;
    case MN_STX: c->mem[ea] = c->x; break;
    case MN_STY: c->mem[ea] = c->y; break;
    case MN_TAX: c->x = c->a; nz(c, c->x); break;
    case MN_TAY: c->y = c->a; nz(c, c->y); break;
    case MN_TXA: c->a = c->x; nz(c, c->a); break;
    case MN_TYA: c->a = c->y; nz(c, c->a); break;
    case MN_TSX: c->x = c->s; nz(c, c->x); break;
    case MN_TXS: c->s = c->x; break;
    case MN_PHA: psh(c, c->a); break;
    case MN_PHP: psh(c, (u8)(c->p | F_B | F_U)); break;
    case MN_PLA: c->a = pul(c); nz(c, c->a); break;
    case MN_PLP: c->p = (u8)((pul(c) & (u8)~F_B) | F_U); break;
    case MN_AND: c->a = (u8)(c->a & m); nz(c, c->a); break;
    case MN_ORA: c->a = (u8)(c->a | m); nz(c, c->a); break;
    case MN_EOR: c->a = (u8)(c->a ^ m); nz(c, c->a); break;
    case MN_ADC: {
        u8 carry = (c->p & F_C) ? 1 : 0;
        u8 a = c->a;
        int t = a + m + carry;
        u8 r = (u8)t;
        c->p = (u8)((c->p & (u8)~(F_C | F_V | F_Z | F_N)) |
                    (t > 0xFF ? F_C : 0) |
                    ((((~(a ^ m) & (a ^ r)) & 0x80)) ? F_V : 0) |
                    (r == 0 ? F_Z : 0) | (r & 0x80));
        c->a = r;
        break;
    }
    case MN_SBC: {
        u8 borrow = (c->p & F_C) ? 0 : 1;
        u8 a = c->a;
        int t = (int)a - m - borrow;
        u8 r = (u8)t;
        c->p = (u8)((c->p & (u8)~(F_C | F_V | F_Z | F_N)) |
                    (t >= 0 ? F_C : 0) |
                    ((((a ^ m) & (a ^ r)) & 0x80) ? F_V : 0) |
                    (r == 0 ? F_Z : 0) | (r & 0x80));
        c->a = r;
        break;
    }
    case MN_CMP: {
        int t = (int)c->a - m; u8 r = (u8)t;
        c->p = (u8)((c->p & (u8)~(F_C | F_Z | F_N)) | (t >= 0 ? F_C : 0) |
                    (r == 0 ? F_Z : 0) | (r & 0x80));
        break;
    }
    case MN_CPX: {
        int t = (int)c->x - m; u8 r = (u8)t;
        c->p = (u8)((c->p & (u8)~(F_C | F_Z | F_N)) | (t >= 0 ? F_C : 0) |
                    (r == 0 ? F_Z : 0) | (r & 0x80));
        break;
    }
    case MN_CPY: {
        int t = (int)c->y - m; u8 r = (u8)t;
        c->p = (u8)((c->p & (u8)~(F_C | F_Z | F_N)) | (t >= 0 ? F_C : 0) |
                    (r == 0 ? F_Z : 0) | (r & 0x80));
        break;
    }
    case MN_BIT:
        c->p = (u8)((c->p & (u8)~(F_Z | F_V | F_N)) | (((c->a & m) == 0) ? F_Z : 0) | (m & 0xC0));
        break;
    case MN_ASL: {
        u8 *v = (mode == MODE_ACC) ? &c->a : &c->mem[ea];
        olc = (*v & 0x80) ? 1 : 0;
        *v = (u8)(*v << 1);
        c->p = (u8)((c->p & (u8)~F_C) | (olc ? F_C : 0));
        nz(c, *v);
        break;
    }
    case MN_LSR: {
        u8 *v = (mode == MODE_ACC) ? &c->a : &c->mem[ea];
        olc = (*v & 1) ? 1 : 0;
        *v = (u8)(*v >> 1);
        c->p = (u8)((c->p & (u8)~F_C) | (olc ? F_C : 0));
        nz(c, *v);
        break;
    }
    case MN_ROL: {
        u8 *v = (mode == MODE_ACC) ? &c->a : &c->mem[ea];
        olc = (c->p & F_C) ? 1 : 0;
        int c7 = (*v & 0x80) ? 1 : 0;
        *v = (u8)((*v << 1) | olc);
        c->p = (u8)((c->p & (u8)~F_C) | (c7 ? F_C : 0));
        nz(c, *v);
        break;
    }
    case MN_ROR: {
        u8 *v = (mode == MODE_ACC) ? &c->a : &c->mem[ea];
        olc = (c->p & F_C) ? 0x80 : 0;
        int b0 = (*v & 1) ? 1 : 0;
        *v = (u8)((*v >> 1) | olc);
        c->p = (u8)((c->p & (u8)~F_C) | (b0 ? F_C : 0));
        nz(c, *v);
        break;
    }
    case MN_INC: { u8 *v = &c->mem[ea]; *v = (u8)(*v + 1); nz(c, *v); break; }
    case MN_DEC: { u8 *v = &c->mem[ea]; *v = (u8)(*v - 1); nz(c, *v); break; }
    case MN_INX: c->x = (u8)(c->x + 1); nz(c, c->x); break;
    case MN_INY: c->y = (u8)(c->y + 1); nz(c, c->y); break;
    case MN_DEX: c->x = (u8)(c->x - 1); nz(c, c->x); break;
    case MN_DEY: c->y = (u8)(c->y - 1); nz(c, c->y); break;
    case MN_JMP:
        if (mode == MODE_IND) {
            u8 l = c->mem[ea];
            u8 h = c->mem[(u16)((ea & 0xFF00) | ((ea + 1) & 0xFF))];
            c->pc = (u16)(l | (h << 8));
        } else {
            c->pc = ea;
        }
        return 0;
    case MN_JSR:
        psh16(c, (u16)(npc - 1));
        c->pc = ea;
        return 0;
    case MN_RTS: c->pc = (u16)(pul16(c) + 1); return 0;
    case MN_RTI: c->p = (u8)(pul(c) | F_U); c->pc = pul16(c); return 0;
    case MN_BRK:
        psh16(c, (u16)(base + 2));
        psh(c, (u8)(c->p | F_B | F_U));
        c->p |= F_I;
        c->pc = (u16)(c->mem[0xFFFE] | (c->mem[0xFFFF] << 8));
        return 0;
    case MN_BPL: c->pc = (!(c->p & F_N)) ? ea : npc; return 0;
    case MN_BMI: c->pc = (c->p & F_N) ? ea : npc; return 0;
    case MN_BVC: c->pc = (!(c->p & F_V)) ? ea : npc; return 0;
    case MN_BVS: c->pc = (c->p & F_V) ? ea : npc; return 0;
    case MN_BCC: c->pc = (!(c->p & F_C)) ? ea : npc; return 0;
    case MN_BCS: c->pc = (c->p & F_C) ? ea : npc; return 0;
    case MN_BNE: c->pc = (!(c->p & F_Z)) ? ea : npc; return 0;
    case MN_BEQ: c->pc = (c->p & F_Z) ? ea : npc; return 0;
    case MN_SEC: c->p |= F_C; break;
    case MN_CLC: c->p &= (u8)~F_C; break;
    case MN_SED: c->p |= F_D; break;
    case MN_CLD: c->p &= (u8)~F_D; break;
    case MN_SEI: c->p |= F_I; break;
    case MN_CLI: c->p &= (u8)~F_I; break;
    case MN_CLV: c->p &= (u8)~F_V; break;
    case MN_NOP: break;
    default: return -1;
    }
    c->pc = npc;
    return 0;
}

/* Static successor addresses of the instruction at c->pc (for gap detection).
 * Returns the number of successors written to `out`. */
int ref_successors(Cpu *c, unsigned *out) {
    u16 base = c->pc;
    u8 op = c->mem[base];
    unsigned mn = REF_MN[op], mode = REF_MODE[op];
    int len, n = 0;
    if (mn == 0xFF || mode == 0xFF) return 0;
    len = MODE_LEN[mode];
    if (mn == MN_JSR) {
        out[n++] = (unsigned)(c->mem[base + 1] | (c->mem[base + 2] << 8));
        out[n++] = (unsigned)(base + len);
    } else if (mn == MN_JMP) {
        if (mode == MODE_ABS)
            out[n++] = (unsigned)(c->mem[base + 1] | (c->mem[base + 2] << 8));
    } else if (mn == MN_RTS || mn == MN_RTI || mn == MN_BRK) {
        /* no static successor */
    } else if (mode == MODE_REL) {
        out[n++] = (unsigned)(base + 2 + (int)(signed char)c->mem[base + 1]);
        out[n++] = (unsigned)(base + len);
    } else {
        out[n++] = (unsigned)(base + len);
    }
    return n;
}
