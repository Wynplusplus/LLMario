#!/usr/bin/env python3
"""Generate a ca65 assembly source for the Super Mario Bros. PRG ROM.

Code regions come from a recursive-traversal 6502 disassembler seeded at the
RESET/NMI/IRQ vectors (and Ghidra's independent analysis). The game's in-line
jump tables (`JSR $8E04`) are resolved so the handlers they dispatch to are
decoded too. Everything not proven to be code is emitted as `.byte`, so the
reassembly is byte-exact.
"""
import os
ROOT = os.path.dirname(os.path.abspath(__file__))
ROM = os.path.join(ROOT, "out/prg.bin")
MAP = os.path.join(ROOT, "out/ghidra_map.txt")
OUT = os.path.join(ROOT, "out/smb.asm")
BASE = 0x8000

# --- 6502 opcode matrix (mode: imp acc imm zp zpx zpy abs abx aby ind izx izy rel)
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


def decode(a):
    off = a - BASE
    op = prg[off]
    mn, mode = OPS[op]
    ln = LEN[mode]
    b = prg[off:off + ln]
    if mode == "imp":
        return mn, ln, None
    if mode == "acc":
        return mn + " a", ln, None
    if mode == "imm":
        return f"{mn} #${b[1]:02X}", ln, None
    if mode == "zp":
        return f"{mn} z:${b[1]:02X}", ln, None
    if mode == "zpx":
        return f"{mn} z:${b[1]:02X},x", ln, None
    if mode == "zpy":
        return f"{mn} z:${b[1]:02X},y", ln, None
    if mode == "abs":
        t = b[1] | (b[2] << 8)
        return f"{mn} a:${t:04X}", ln, t
    if mode == "abx":
        t = b[1] | (b[2] << 8)
        return f"{mn} a:${t:04X},x", ln, None
    if mode == "aby":
        t = b[1] | (b[2] << 8)
        return f"{mn} a:${t:04X},y", ln, None
    if mode == "ind":
        t = b[1] | (b[2] << 8)
        return f"{mn} (${t:04X})", ln, None
    if mode == "izx":
        return f"{mn} (${b[1]:02X},x)", ln, None
    if mode == "izy":
        return f"{mn} (${b[1]:02X}),y", ln, None
    if mode == "rel":
        rel = b[1]
        if rel >= 0x80:
            rel -= 0x100
        t = (a + 2 + rel) & 0xFFFF
        return f"{mn} L{t:04X}", ln, t
    raise AssertionError(mode)


instr = {}
covered = set()
JUMPENGINE = 0x8E04
hi = []   # explicit targets (high priority)
lo = []   # fall-through (low priority)

for line in open(MAP):
    p = line.split()
    if p and p[0] == "I":
        hi.append(int(p[1], 16))
hi += [0x8000, 0x8082, 0xFFF0]


def dispatch_targets(base):
    for i in range(0, 64, 2):
        o = base + i - BASE
        if o + 1 >= len(prg):
            break
        v = prg[o] | (prg[o + 1] << 8)
        if 0x8000 <= v <= 0xFFFF:
            hi.append(v)


while hi or lo:
    a = hi.pop() if hi else lo.pop()
    if not (BASE <= a <= 0xFFFF) or a in covered:
        continue
    op = prg[a - BASE]
    if op not in OPS:
        continue
    text, ln, target = decode(a)
    if a + ln > 0x10000 or any((a + k) in covered for k in range(ln)):
        continue
    instr[a] = (text, ln, target)
    for k in range(ln):
        covered.add(a + k)
    mn = text.split()[0]
    if mn == "JSR" and target == JUMPENGINE:
        dispatch_targets(a + 3)
        continue
    if mn == "JMP":
        if target is not None:
            hi.append(target)
        continue
    if mn in ("RTS", "RTI", "BRK"):
        continue
    if target is not None:          # conditional branch
        hi.append(target)
    lo.append(a + ln)               # fall-through

# --- emit -------------------------------------------------------------------
BRANCHES = {"BPL", "BMI", "BVC", "BVS", "BCC", "BCS", "BNE", "BEQ"}
branch_targets = {t for _, (text, ln, t) in instr.items()
                  if t is not None and text.split()[0] in BRANCHES}
valid_labels = {t for t in branch_targets if (t in instr) or (t not in covered)}

out = []
out.append("; Super Mario Bros. (World) PRG disassembly")
out.append("; 32 KiB PRG mapped at $8000-$FFFF. Code from recursive traversal")
out.append("; (RESET/NMI/IRQ + in-line jump tables); other bytes are data.")
out.append("; Each line is commented with its address and raw opcode bytes.")
out.append('.setcpu "6502"')
out.append('.segment "PRG"')
out.append("")

addr = BASE
while addr < 0x10000:
    if addr in valid_labels:
        out.append(f"L{addr:04X}:")
    if addr in instr:
        text, ln, target = instr[addr]
        mn = text.split()[0]
        raw = prg[addr - BASE:addr - BASE + ln]
        hexb = " ".join(f"{b:02X}" for b in raw)
        if mn in BRANCHES and target not in valid_labels:
            out.append(f"        .byte " + ",".join(f"${b:02X}" for b in raw) + f"   ; ${addr:04X} (branch, see note)")
            addr += ln
        else:
            out.append(f"        {text:<26} ; ${addr:04X}: {hexb}")
            addr += ln
    else:
        run = []
        start = addr
        while addr < 0x10000 and addr not in instr and len(run) < 16:
            if addr in valid_labels and run:
                break
            run.append(prg[addr - BASE])
            addr += 1
        out.append("        .byte " + ",".join(f"${b:02X}" for b in run) + f"   ; ${start:04X}")

open(OUT, "w").write("\n".join(out) + "\n")

n_bytes = sum(l for _, l, _ in instr.values())
print(f"instructions: {len(instr)}  code bytes: {n_bytes} ({100*n_bytes/32768:.1f}%)  data bytes: {32768-n_bytes}")
print(f"branch labels: {len(valid_labels)}/{len(branch_targets)}")
print(f"wrote {OUT}")
