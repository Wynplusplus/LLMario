#!/usr/bin/env python3
"""Translate the Super Mario Bros. PRG into portable C.

The code map (which addresses are code) comes from the same recursive-traversal
analysis used for the matching assembly (ghidra_map.txt + in-line jump-table
resolution). Every decoded 6502 instruction becomes a C function operating on
the `Cpu` state in cpu.h; bytes that are not code stay in the embedded ROM
image and are never dispatched. A NULL dispatch entry marks data, so execution
halts rather than running garbage.
"""
import os
C_DIR = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(C_DIR)
ROM = os.path.join(ROOT, "out/prg.bin")
ASM = os.path.join(ROOT, "out/smb.asm")
OUT = os.path.join(C_DIR, "out/smb_prg.c")
BASE = 0x8000

MATRIX = [
 ["BRK:imp","ORA:izx","---","---","---","ORA:zp","ASL:zp","---","PHP:imp","ORA:imm","ASL:acc","---","---","ORA:abs","ASL:abs","---"],
 ["BPL:rel","ORA:izy","---","---","---","ORA:zpx","ASL:zpx","---","CLC:imp","ORA:aby","---","---","---","ORA:abx","ASL:abx","---"],
 ["JSR:abs","AND:izx","---","---","BIT:zp","AND:zp","ROL:zp","---","PLP:imp","AND:imm","ROL:acc","---","BIT:abs","AND:abs","ROL:abs","---"],
 ["BMI:rel","AND:izy","---","---","---","AND:zpx","ROL:zpx","---","SEC:imp","AND:aby","---","---","---","AND:abx","ROL:abx","---"],
 ["RTI:imp","EOR:izx","---","---","---","EOR:zp","LSR:zp","---","PHA:imp","EOR:imm","LSR:acc","---","JMP:abs","EOR:abs","LSR:abs","---"],
 ["BVC:rel","EOR:izy","---","---","---","EOR:zpx","LSR:zpx","---","CLI:imp","EOR:aby","---","---","---","EOR:abx","LSR:abx","---"],
 ["RTS:imp","ADC:izx","---","---","---","ADC:zp","ROR:zp","---","PLA:imp","ADC:imm","ROR:acc","---","JMP:ind","ADC:abs","ROR:abs","---"],
 ["BVS:rel","ADC:izy","---","---","---","ADC:zpx","ROR:zpx","---","SEI:imp","ADC:aby","---","---","---","ADC:abx","ROR:abx","---"],
 ["---","STA:izx","---","---","STY:zp","STA:zp","STX:zp","---","DEY:imp","---","TXA:imp","---","STY:abs","STA:abs","STX:abs","---"],
 ["BCC:rel","STA:izy","---","---","STY:zpx","STA:zpx","STX:zpy","---","TYA:imp","STA:aby","TXS:imp","---","---","STA:abx","---","---"],
 ["LDY:imm","LDA:izx","LDX:imm","---","LDY:zp","LDA:zp","LDX:zp","---","TAY:imp","LDA:imm","TAX:imp","---","LDY:abs","LDA:abs","LDX:abs","---"],
 ["BCS:rel","LDA:izy","---","---","LDY:zpx","LDA:zpx","LDX:zpy","---","CLV:imp","LDA:aby","TSX:imp","---","LDY:abx","LDA:abx","LDX:aby","---"],
 ["CPY:imm","CMP:izx","---","---","CPY:zp","CMP:zp","DEC:zp","---","INY:imp","CMP:imm","DEX:imp","---","CPY:abs","CMP:abs","DEC:abs","---"],
 ["BNE:rel","CMP:izy","---","---","---","CMP:zpx","DEC:zpx","---","CLD:imp","CMP:aby","---","---","---","CMP:abx","DEC:abx","---"],
 ["CPX:imm","SBC:izx","---","---","CPX:zp","SBC:zp","INC:zp","---","INX:imp","SBC:imm","NOP:imp","---","CPX:abs","SBC:abs","INC:abs","---"],
 ["BEQ:rel","SBC:izy","---","---","---","SBC:zpx","INC:zpx","---","SED:imp","SBC:aby","---","---","---","SBC:abx","INC:abx","---"],
]
LEN = {"imp":1,"acc":1,"imm":2,"zp":2,"zpx":2,"zpy":2,"abs":3,"abx":3,"aby":3,"ind":3,"izx":2,"izy":2,"rel":2}
OPS = {}
for hi, row in enumerate(MATRIX):
    for lo, cell in enumerate(row):
        if cell != "---":
            mn, mode = cell.split(":")
            OPS[(hi << 4) | lo] = (mn, mode)

prg = open(ROM, "rb").read()
assert len(prg) == 32768


def fields(a):
    op = prg[a - BASE]
    mn, mode = OPS[op]
    ln = LEN[mode]
    b = prg[a - BASE:a - BASE + ln]
    val = None
    if mode in ("imm", "zp", "zpx", "zpy", "izx", "izy"):
        val = b[1]
    elif mode in ("abs", "abx", "aby", "ind"):
        val = b[1] | (b[2] << 8)
    elif mode == "rel":
        r = b[1] - 0x100 if b[1] >= 0x80 else b[1]
        val = (a + 2 + r) & 0xFFFF
    return mn, mode, ln, val


import re
instr = {}
covered = set()
# Parse the verified matching disassembly so the C corresponds one-to-one with
# the instruction set the assembly verifier already confirmed.
for line in open(ASM):
    m = re.match(r"^\s+([A-Z]{3})(?:\s|$)", line)
    if not m:
        continue
    mm = re.search(r";\s*\$([0-9A-F]{4}):", line)
    if not mm:
        continue
    a = int(mm.group(1), 16)
    mn, mode, ln, val = fields(a)
    if mn != m.group(1):
        raise SystemExit(f"mismatch at {a:04X}: asm {m.group(1)} vs decoded {mn}")
    instr[a] = (mn, mode, ln, val)
    for k in range(ln):
        covered.add(a + k)


def successors(mn, mode, a, ln, val):
    """Static successor addresses of an instruction."""
    if mn == "JSR":
        return [val, a + ln]              # call target + return site
    if mn == "JMP":
        return [val] if mode == "abs" else []
    if mn in ("RTS", "RTI", "BRK"):
        return []
    if mode == "rel":
        return [val, a + ln]              # branch target + fall-through
    return [a + ln]


# Expand the map with static control-flow targets the disassembly missed --
# notably alternate entry points that live inside another instruction's operand
# (the `BIT abs` skip idiom, e.g. $8223 inside `BIT $04A0` at $8222). Overlap is
# fine: one C function is emitted per address and dispatch selects by pc.
work = []
for a, (mn, mode, ln, val) in list(instr.items()):
    work += successors(mn, mode, a, ln, val)
work += [0x8000, 0x8082, 0xFFF0]
added = 0
while work and added < 20000:
    a = work.pop()
    if a in instr or not (BASE <= a <= 0xFFFF):
        continue
    if prg[a - BASE] not in OPS:
        continue
    mn, mode, ln, val = fields(a)
    if a + ln > 0x10000:
        continue
    instr[a] = (mn, mode, ln, val)
    added += 1
    work += successors(mn, mode, a, ln, val)
print(f"asm instructions: 10255  added entry points: {added}  total: {len(instr)}")

# --- C emission -------------------------------------------------------------
BRANCHES = {"BPL", "BMI", "BVC", "BVS", "BCC", "BCS", "BNE", "BEQ"}
BCOND = {
    "BPL": "!(c->p & F_N)", "BMI": "(c->p & F_N)",
    "BVC": "!(c->p & F_V)", "BVS": "(c->p & F_V)",
    "BCC": "!(c->p & F_C)", "BCS": "(c->p & F_C)",
    "BNE": "!(c->p & F_Z)", "BEQ": "(c->p & F_Z)",
}


def addr_expr(mode, val):
    if mode == "zp":
        return f"0x{val:04X}"
    if mode == "zpx":
        return f"(u16)((0x{val:02X} + c->x) & 0xFF)"
    if mode == "zpy":
        return f"(u16)((0x{val:02X} + c->y) & 0xFF)"
    if mode == "abs":
        return f"0x{val:04X}"
    if mode == "abx":
        return f"(u16)(0x{val:04X} + c->x)"
    if mode == "aby":
        return f"(u16)(0x{val:04X} + c->y)"
    if mode == "izx":
        return (f"(u16)(c->mem[(0x{val:02X} + c->x) & 0xFF] | "
                f"(c->mem[(0x{val:02X} + c->x + 1) & 0xFF] << 8))")
    if mode == "izy":
        return (f"(u16)((c->mem[0x{val:02X}] | "
                f"(c->mem[(0x{val:02X} + 1) & 0xFF] << 8)) + c->y)")
    raise ValueError(mode)


def emit_fn(a, mn, mode, ln, val):
    npc = a + ln
    b = []
    sets_pc = False

    def load_m():
        if mode == "imm":
            b.append(f"u8 m = 0x{val:02X};")
        else:
            b.append(f"u16 ad = {addr_expr(mode, val)};")
            b.append("u8 m = rd8(c, ad);")

    if mn in ("LDA", "LDX", "LDY"):
        load_m()
        reg = {"LDA": "a", "LDX": "x", "LDY": "y"}[mn]
        b.append(f"c->{reg} = m; setnz(c, m);")
    elif mn in ("STA", "STX", "STY"):
        b.append(f"u16 ad = {addr_expr(mode, val)};")
        reg = {"STA": "a", "STX": "x", "STY": "y"}[mn]
        b.append(f"wr8(c, ad, c->{reg});")
    elif mn in ("AND", "ORA", "EOR"):
        load_m()
        op = {"AND": "&", "ORA": "|", "EOR": "^"}[mn]
        b.append(f"c->a = (u8)(c->a {op} m); setnz(c, c->a);")
    elif mn == "ADC":
        load_m()
        b.append("do_adc(c, m);")
    elif mn == "SBC":
        load_m()
        b.append("do_sbc(c, m);")
    elif mn in ("CMP", "CPX", "CPY"):
        load_m()
        reg = {"CMP": "a", "CPX": "x", "CPY": "y"}[mn]
        b.append(f"do_cmp(c, c->{reg}, m);")
    elif mn == "BIT":
        load_m()
        b.append("do_bit(c, m);")
    elif mn in ("ASL", "LSR", "ROL", "ROR"):
        fn = {"ASL": "do_asl", "LSR": "do_lsr", "ROL": "do_rol", "ROR": "do_ror"}[mn]
        if mode == "acc":
            b.append(f"{fn}(c, &c->a);")
        else:
            b.append(f"u16 ad = {addr_expr(mode, val)};")
            b.append("u8 m = rd8(c, ad);")
            b.append(f"{fn}(c, &m);")
            b.append("wr8(c, ad, m);")
    elif mn in ("INC", "DEC"):
        fn = "do_inc" if mn == "INC" else "do_dec"
        b.append(f"u16 ad = {addr_expr(mode, val)};")
        b.append("u8 m = rd8(c, ad);")
        b.append(f"{fn}(c, &m);")
        b.append("wr8(c, ad, m);")
    elif mn in ("INX", "INY", "DEX", "DEY"):
        reg = "x" if mn in ("INX", "DEX") else "y"
        op = "+" if mn in ("INX", "INY") else "-"
        b.append(f"c->{reg} = (u8)(c->{reg} {op} 1); setnz(c, c->{reg});")
    elif mn in ("TAX", "TAY", "TXA", "TYA", "TSX"):
        src, dst = {"TAX": ("a", "x"), "TAY": ("a", "y"), "TXA": ("x", "a"),
                    "TYA": ("y", "a"), "TSX": ("s", "x")}[mn]
        b.append(f"c->{dst} = c->{src}; setnz(c, c->{dst});")
    elif mn == "TXS":
        b.append("c->s = c->x;")
    elif mn == "PHA":
        b.append("push(c, c->a);")
    elif mn == "PHP":
        b.append("push(c, (u8)(c->p | F_B | F_U));")
    elif mn == "PLA":
        b.append("c->a = pop(c); setnz(c, c->a);")
    elif mn == "PLP":
        b.append("c->p = (u8)((pop(c) & (u8)~F_B) | F_U);")
    elif mn == "JMP":
        sets_pc = True
        if mode == "abs":
            b.append(f"c->pc = 0x{val:04X};")
        else:
            b.append(f"u16 p = 0x{val:04X};")
            b.append("u8 lo = c->mem[p];")
            b.append("u8 hi = c->mem[(u16)((p & 0xFF00) | ((p + 1) & 0xFF))];")
            b.append("c->pc = (u16)(lo | (hi << 8));")
    elif mn == "JSR":
        sets_pc = True
        b.append(f"push16(c, 0x{npc - 1:04X});")
        b.append(f"c->pc = 0x{val:04X};")
    elif mn == "RTS":
        sets_pc = True
        b.append("c->pc = (u16)(pop16(c) + 1);")
    elif mn == "RTI":
        sets_pc = True
        b.append("c->p = (u8)(pop(c) | F_U);")
        b.append("c->pc = pop16(c);")
    elif mn == "BRK":
        sets_pc = True
        b.append(f"push16(c, 0x{a + 2:04X});")
        b.append("push(c, (u8)(c->p | F_B | F_U));")
        b.append("c->p |= F_I;")
        b.append("c->pc = (u16)(c->mem[0xFFFE] | (c->mem[0xFFFF] << 8));")
    elif mn in BRANCHES:
        sets_pc = True
        b.append(f"if ({BCOND[mn]}) c->pc = 0x{val:04X}; else c->pc = 0x{npc:04X};")
    elif mn in ("SEC", "CLC", "SED", "CLD", "SEI", "CLI", "CLV"):
        flag = {"SEC": "F_C", "CLC": "F_C", "SED": "F_D", "CLD": "F_D",
                "SEI": "F_I", "CLI": "F_I", "CLV": "F_V"}[mn]
        setc = mn in ("SEC", "SED", "SEI")
        if mn == "CLV":
            b.append("c->p &= (u8)~F_V;")
        elif setc:
            b.append(f"c->p |= {flag};")
        else:
            b.append(f"c->p &= (u8)~{flag};")
    elif mn == "NOP":
        pass
    else:
        raise ValueError(mn)

    if not sets_pc:
        b.append(f"c->pc = 0x{npc:04X};")
    return f"static void I_{a:04X}(Cpu *c){{ " + " ".join(b) + " }"


PRELUDE = r"""
/* I/O hooks: when set, accesses to the PPU registers ($2000-$3FFF mirrors)
 * and OAM DMA ($4014) are routed to the device model instead of plain memory.
 * Other I/O (APU, controllers) stays in memory. NULL (the default) keeps the
 * pure CPU/memory behaviour used by the differential test. */
void (*g_io_write)(Cpu *, u16, u8) = 0;
u8 (*g_io_read)(Cpu *, u16) = 0;
#define IO_HOOKED(a) (((a) >= 0x2000 && (a) < 0x4000) || (a) == 0x4014)
static u8 rd8(Cpu *c, u16 a) {
    if (g_io_read && IO_HOOKED(a)) return g_io_read(c, a);
    return c->mem[a];
}
static void wr8(Cpu *c, u16 a, u8 v) {
    if (g_io_write && IO_HOOKED(a)) { g_io_write(c, a, v); return; }
    c->mem[a] = v;
}
static void setnz(Cpu *c, u8 v) {
    if (v == 0) c->p |= F_Z; else c->p &= (u8)~F_Z;
    if (v & 0x80) c->p |= F_N; else c->p &= (u8)~F_N;
}
static void push(Cpu *c, u8 v) { c->mem[0x100 + c->s] = v; c->s = (u8)(c->s - 1); }
static u8 pop(Cpu *c) { c->s = (u8)(c->s + 1); return c->mem[0x100 + c->s]; }
static void push16(Cpu *c, u16 v) { push(c, (u8)(v >> 8)); push(c, (u8)v); }
static u16 pop16(Cpu *c) { u8 lo = pop(c); u8 hi = pop(c); return (u16)(lo | (hi << 8)); }
static void do_adc(Cpu *c, u8 m) {
    u16 r = (u16)c->a + m + ((c->p & F_C) ? 1 : 0);
    u8 res = (u8)r;
    if (r > 0xFF) c->p |= F_C; else c->p &= (u8)~F_C;
    if ((~(c->a ^ m) & (c->a ^ res)) & 0x80) c->p |= F_V; else c->p &= (u8)~F_V;
    c->a = res; setnz(c, res);
}
static void do_sbc(Cpu *c, u8 m) {
    u16 r = (u16)((u16)c->a - m - ((c->p & F_C) ? 0 : 1));
    u8 res = (u8)r;
    if (r < 0x100) c->p |= F_C; else c->p &= (u8)~F_C;
    if (((c->a ^ m) & (c->a ^ res)) & 0x80) c->p |= F_V; else c->p &= (u8)~F_V;
    c->a = res; setnz(c, res);
}
static void do_cmp(Cpu *c, u8 r, u8 m) {
    u16 t = (u16)r - m;
    if (t < 0x100) c->p |= F_C; else c->p &= (u8)~F_C;
    setnz(c, (u8)t);
}
static void do_asl(Cpu *c, u8 *v) { u8 m = *v; if (m & 0x80) c->p |= F_C; else c->p &= (u8)~F_C; m = (u8)(m << 1); *v = m; setnz(c, m); }
static void do_lsr(Cpu *c, u8 *v) { u8 m = *v; if (m & 1) c->p |= F_C; else c->p &= (u8)~F_C; m = (u8)(m >> 1); *v = m; setnz(c, m); }
static void do_rol(Cpu *c, u8 *v) { u8 m = *v; u8 cy = (c->p & F_C) ? 1 : 0; if (m & 0x80) c->p |= F_C; else c->p &= (u8)~F_C; m = (u8)((m << 1) | cy); *v = m; setnz(c, m); }
static void do_ror(Cpu *c, u8 *v) { u8 m = *v; u8 cy = (c->p & F_C) ? 0x80 : 0; if (m & 1) c->p |= F_C; else c->p &= (u8)~F_C; m = (u8)((m >> 1) | cy); *v = m; setnz(c, m); }
static void do_inc(Cpu *c, u8 *v) { u8 m = (u8)(*v + 1); *v = m; setnz(c, m); }
static void do_dec(Cpu *c, u8 *v) { u8 m = (u8)(*v - 1); *v = m; setnz(c, m); }
static void do_bit(Cpu *c, u8 m) { if ((c->a & m) == 0) c->p |= F_Z; else c->p &= (u8)~F_Z; c->p = (u8)((c->p & (u8)~(F_N | F_V)) | (m & 0xC0)); }
"""

# Emit.
out = []
out.append("/* Decompiled Super Mario Bros. (World) PRG to portable C.")
out.append(" * Generated by gen_c.py from the matching disassembly analysis.")
out.append(" * Code addresses are translated to C functions dispatched via optab;")
out.append(" * data addresses have no entry and halt execution when reached.")
out.append(" * The 32 KiB PRG image is retained so reads of data (and of code bytes")
out.append(" * used as data) return the original values. Compiled freestanding for")
out.append(" * x86-64 and aarch64; see build_c.sh. */")
out.append('#include "cpu.h"')
out.append("")
out.append(PRELUDE)

out.append("")

fns = []
for a in sorted(instr):
    mn, mode, ln, val = instr[a]
    fns.append(emit_fn(a, mn, mode, ln, val))
out.append("\n".join(fns))
out.append("")

out.append("CpuOp optab[0x10000];")
out.append("static void smb_init_table(void) {")
for a in sorted(instr):
    out.append(f"    optab[0x{a:04X}] = I_{a:04X};")
out.append("}")
out.append("")

out.append("""void smb_cpu_init(Cpu *c, const u8 *prg) {
    u32 i;
    for (i = 0; i < 0x10000; i++) c->mem[i] = 0;
    /* The 32 KiB PRG image is supplied by the caller (extracted from the
     * user's own ROM), so no ROM data is built into this source. */
    for (i = 0; i < 0x8000; i++) c->mem[0x8000 + i] = prg[i];
    smb_init_table();
    c->a = c->x = c->y = 0;
    c->s = 0xFD;
    c->p = F_U | F_I;
    c->pc = 0x8000;
}""")
out.append("")
out.append("""int smb_cpu_step(Cpu *c) {
    CpuOp f = optab[c->pc];
    if (!f) return 0;
    f(c);
    return 1;
}""")
out.append("")
out.append("""void smb_cpu_run(Cpu *c, u32 n) {
    while (n--) { if (!smb_cpu_step(c)) return; }
}""")

open(OUT, "w").write("\n".join(out) + "\n")

# Export the opcode decode table for the independent reference interpreter.
MNS = sorted({OPS[op][0] for op in OPS})
MODES = ["imp", "acc", "imm", "zp", "zpx", "zpy", "abs", "abx", "aby", "ind", "izx", "izy", "rel"]
mn_idx = {m: i for i, m in enumerate(MNS)}
mode_idx = {m: i for i, m in enumerate(MODES)}
with open(os.path.join(C_DIR, "out/ref_optable.h"), "w") as f:
    f.write("/* Opcode decode table (opcode -> mnemonic, addressing mode). */\n")
    f.write("#ifndef REF_OPTABLE_H\n#define REF_OPTABLE_H\n")
    f.write("enum { " + ", ".join(f"MN_{m}" for m in MNS) + ", MN_NONE };\n")
    f.write("enum { " + ", ".join(f"MODE_{m.upper()}" for m in MODES) + ", MODE_NONE };\n")
    f.write(f"#define REF_MN_COUNT {len(MNS)}\n#define REF_MODE_COUNT {len(MODES)}\n")
    mn_arr = [mn_idx[OPS[op][0]] if op in OPS else 0xFF for op in range(256)]
    mode_arr = [mode_idx[OPS[op][1]] if op in OPS else 0xFF for op in range(256)]
    f.write("static const unsigned char REF_MN[256] = {")
    f.write(",".join(str(v) for v in mn_arr))
    f.write("};\n")
    f.write("static const unsigned char REF_MODE[256] = {")
    f.write(",".join(str(v) for v in mode_arr))
    f.write("};\n")
    f.write("#endif\n")

# Export the translated-address list so the differential test can assert the
# dispatch table has no gaps and detect any untranslated control-flow target.
addrs = sorted(instr)
with open(os.path.join(C_DIR, "out/xlt.h"), "w") as f:
    f.write("/* Addresses translated to C by gen_c.py. */\n")
    f.write("#ifndef XLT_H\n#define XLT_H\n")
    f.write(f"#define XLT_COUNT {len(addrs)}\n")
    f.write("static const unsigned XLT_ADDRS[XLT_COUNT] = {")
    f.write(",".join(f"0x{a:04X}" for a in addrs))
    f.write("};\n#endif\n")

n_bytes = sum(ln for _, _, ln, _ in instr.values())
print(f"instructions: {len(instr)}  code bytes: {n_bytes}  data bytes: {32768 - n_bytes}")
print(f"wrote {OUT}, out/ref_optable.h and out/xlt.h")
