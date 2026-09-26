#!/usr/bin/env python3
"""Independent verifier for out/smb.asm vs out/prg.bin.

Builds its OWN 6502 opcode table (not imported from gen.py), parses the asm,
re-encodes every instruction from mnemonic+operand, and checks:
  * comment raw bytes == ROM bytes at the stated address
  * re-encoded opcode+operands == comment raw bytes
  * coverage: every PRG byte covered exactly once, no gaps/overlaps
"""
import re, sys

ASM = "/home/wyn/smb_decomp/out/smb.asm"
PRG = "/home/wyn/smb_decomp/out/prg.bin"
BASE = 0x8000
rom = open(PRG, "rb").read()
assert len(rom) == 32768

# ---- independent opcode matrix (row=hi nibble, col=lo nibble) ----
# modes: imp acc imm zp zpx zpy abs abx aby ind izx izy rel
M = [
 "BRK:imp ORA:izx ---   ---   ---   ORA:zp  ASL:zp  ---   PHP:imp ORA:imm ASL:acc ---   ---   ORA:abs ASL:abs ---".split(),
 "BPL:rel ORA:izy ---   ---   ---   ORA:zpx ASL:zpx ---   CLC:imp ORA:aby ---   ---   ---   ORA:abx ASL:abx ---".split(),
 "JSR:abs AND:izx ---   ---   BIT:zp  AND:zp  ROL:zp  ---   PLP:imp AND:imm ROL:acc ---   BIT:abs AND:abs ROL:abs ---".split(),
 "BMI:rel AND:izy ---   ---   ---   AND:zpx ROL:zpx ---   SEC:imp AND:aby ---   ---   ---   AND:abx ROL:abx ---".split(),
 "RTI:imp EOR:izx ---   ---   ---   EOR:zp  LSR:zp  ---   PHA:imp EOR:imm LSR:acc ---   JMP:abs EOR:abs LSR:abs ---".split(),
 "BVC:rel EOR:izy ---   ---   ---   EOR:zpx LSR:zpx ---   CLI:imp EOR:aby ---   ---   ---   EOR:abx LSR:abx ---".split(),
 "RTS:imp ADC:izx ---   ---   ---   ADC:zp  ROR:zp  ---   PLA:imp ADC:imm ROR:acc ---   JMP:ind ADC:abs ROR:abs ---".split(),
 "BVS:rel ADC:izy ---   ---   ---   ADC:zpx ROR:zpx ---   SEI:imp ADC:aby ---   ---   ---   ADC:abx ROR:abx ---".split(),
 "---   STA:izx ---   ---   STY:zp  STA:zp  STX:zp  ---   DEY:imp ---   TXA:imp ---   STY:abs STA:abs STX:abs ---".split(),
 "BCC:rel STA:izy ---   ---   STY:zpx STA:zpx STX:zpy ---   TYA:imp STA:aby TXS:imp ---   ---   STA:abx ---   ---".split(),
 "LDY:imm LDA:izx LDX:imm ---   LDY:zp  LDA:zp  LDX:zp  ---   TAY:imp LDA:imm TAX:imp ---   LDY:abs LDA:abs LDX:abs ---".split(),
 "BCS:rel LDA:izy ---   ---   LDY:zpx LDA:zpx LDX:zpy ---   CLV:imp LDA:aby TSX:imp ---   LDY:abx LDA:abx LDX:aby ---".split(),
 "CPY:imm CMP:izx ---   ---   CPY:zp  CMP:zp  DEC:zp  ---   INY:imp CMP:imm DEX:imp ---   CPY:abs CMP:abs DEC:abs ---".split(),
 "BNE:rel CMP:izy ---   ---   ---   CMP:zpx DEC:zpx ---   CLD:imp CMP:aby ---   ---   ---   CMP:abx DEC:abx ---".split(),
 "CPX:imm SBC:izx ---   ---   CPX:zp  SBC:zp  INC:zp  ---   INX:imp SBC:imm NOP:imp ---   CPX:abs SBC:abs INC:abs ---".split(),
 "BEQ:rel SBC:izy ---   ---   ---   SBC:zpx INC:zpx ---   SED:imp SBC:aby ---   ---   ---   SBC:abx INC:abx ---".split(),
]
OP2 = {}   # (mn,mode) -> opcode
OPBY = {}  # opcode -> (mn,mode)
for hi, row in enumerate(M):
    assert len(row) == 16, (hi, len(row))
    for lo, cell in enumerate(row):
        if cell != "---":
            mn, mode = cell.split(":")
            OP2[(mn, mode)] = (hi << 4) | lo
            OPBY[(hi << 4) | lo] = (mn, mode)
LEN = {"imp":1,"acc":1,"imm":2,"zp":2,"zpx":2,"zpy":2,"abs":3,"abx":3,"aby":3,"ind":3,"izx":2,"izy":2,"rel":2}
ACC_OPS = {"ASL","LSR","ROL","ROR"}  # can be acc

instr_re = re.compile(r'^\s+([A-Z]{3})(?:\s+(.*?))?\s*;\s*\$([0-9A-Fa-f]{4}):\s*([0-9A-Fa-f ]+?)\s*$')
byte_re  = re.compile(r'^\s+\.byte\s+(.*?)\s*;\s*\$([0-9A-Fa-f]{4})')
label_re = re.compile(r'^L([0-9A-Fa-f]{4}):')

covered = {}   # addr -> (kind, length)
errors = []
instr_count = 0
code_bytes = 0
data_bytes = 0
branch_as_data = 0

def claim(a, n, kind):
    global code_bytes, data_bytes
    for k in range(n):
        x = a + k
        if x in covered:
            errors.append(f"OVERLAP at ${x:04X}: {kind} vs {covered[x][0]}")
        covered[x] = (kind, a)

lines = open(ASM).read().splitlines()
for ln, line in enumerate(lines, 1):
    if not line or line.startswith(';'):
        continue
    m = instr_re.match(line)
    if m and label_re.match(line) is None:
        mn, oper, a_s, hexb = m.groups()
        a = int(a_s, 16)
        raw = bytes(int(x, 16) for x in hexb.split())
        # comment bytes must match ROM
        if rom[a-BASE:a-BASE+len(raw)] != raw:
            errors.append(f"L{ln}: comment bytes at ${a:04X} {raw.hex()} != ROM {rom[a-BASE:a-BASE+len(raw)].hex()}")
        # determine mode + operand bytes
        oper = (oper or "").strip()
        mode = None; val = None
        if oper == "":
            mode = "acc" if mn in ACC_OPS else "imp"
        elif oper == "a":
            mode = "acc"
        elif re.fullmatch(r'#\$[0-9A-Fa-f]{2}', oper):
            mode = "imm"; val = int(oper[2:], 16)
        elif re.fullmatch(r'z:\$[0-9A-Fa-f]{2}', oper):
            mode = "zp"; val = int(oper[3:], 16)
        elif re.fullmatch(r'z:\$[0-9A-Fa-f]{2},[xX]', oper):
            mode = "zpx"; val = int(oper[3:5], 16)
        elif re.fullmatch(r'z:\$[0-9A-Fa-f]{2},[yY]', oper):
            mode = "zpy"; val = int(oper[3:5], 16)
        elif re.fullmatch(r'a:\$[0-9A-Fa-f]{4}', oper):
            mode = "abs"; val = int(oper[3:], 16)
        elif re.fullmatch(r'a:\$[0-9A-Fa-f]{4},[xX]', oper):
            mode = "abx"; val = int(oper[3:7], 16)
        elif re.fullmatch(r'a:\$[0-9A-Fa-f]{4},[yY]', oper):
            mode = "aby"; val = int(oper[3:7], 16)
        elif re.fullmatch(r'\(\$[0-9A-Fa-f]{4}\)', oper):
            mode = "ind"; val = int(oper[2:6], 16)
        elif re.fullmatch(r'\(\$[0-9A-Fa-f]{2},[xX]\)', oper):
            mode = "izx"; val = int(oper[2:4], 16)
        elif re.fullmatch(r'\(\$[0-9A-Fa-f]{2}\),[yY]', oper):
            mode = "izy"; val = int(oper[2:4], 16)
        elif re.fullmatch(r'L[0-9A-Fa-f]{4}', oper):
            mode = "rel"; val = int(oper[1:], 16)
        else:
            errors.append(f"L{ln}: unparsed operand {mn!r} {oper!r}")
            continue
        # compute expected encoding
        key = (mn, mode)
        if key not in OP2:
            errors.append(f"L{ln}: no opcode for {mn} {mode}")
            continue
        op = OP2[key]
        exp = bytearray([op])
        n = LEN[mode]
        if mode == "rel":
            rel = (val - (a + 2)) & 0xFFFF
            if rel > 0x7F and rel < 0xFF80:
                errors.append(f"L{ln}: branch out of range at ${a:04X} -> ${val:04X}")
            exp.append(rel & 0xFF)
        elif n == 2:
            exp.append(val & 0xFF)
        elif n == 3:
            exp.append(val & 0xFF); exp.append((val >> 8) & 0xFF)
        if bytes(exp) != raw:
            errors.append(f"L{ln}: ENCODE MISMATCH ${a:04X} {mn} {oper}: asm={raw.hex()} expected={bytes(exp).hex()}")
        # opcode byte from ROM must equal op
        if rom[a-BASE] != op:
            errors.append(f"L{ln}: opcode at ${a:04X} ROM={rom[a-BASE]:02X} expected={op:02X}")
        # verify ROM bytes equal expected (strongest)
        if rom[a-BASE:a-BASE+n] != bytes(exp):
            errors.append(f"L{ln}: ROM AT ADDR ${a:04X} != reencoded {bytes(exp).hex()}")
        claim(a, n, "instr")
        instr_count += 1
        code_bytes += n
        continue
    m = byte_re.match(line)
    if m:
        body, a_s = m.groups()
        a = int(a_s, 16)
        vals = [int(x, 16) for x in re.findall(r'\$([0-9A-Fa-f]{2})', body)]
        if re.search(r'\(branch', line):
            branch_as_data += 1
        if rom[a-BASE:a-BASE+len(vals)] != bytes(vals):
            errors.append(f"L{ln}: .byte at ${a:04X} != ROM")
        claim(a, len(vals), "data")
        data_bytes += len(vals)
        continue
    if label_re.match(line) or line.startswith('.'):
        continue
    # otherwise unhandled
    errors.append(f"L{ln}: UNPARSED: {line.strip()[:80]}")

# coverage
gaps = [a for a in range(BASE, BASE+32768) if a not in covered]
print(f"instructions parsed : {instr_count}")
print(f"code bytes          : {code_bytes}")
print(f"data bytes (.byte)  : {data_bytes}")
print(f"sum                 : {code_bytes + data_bytes}  (expect 32768)")
print(f"unique covered      : {len(covered)}")
print(f"gaps                : {len(gaps)}")
print(f"branch-as-.byte     : {branch_as_data}")
if gaps:
    # summarize contiguous gaps
    runs=[]; s=gaps[0]; p=gaps[0]
    for x in gaps[1:]:
        if x==p+1: p=x
        else: runs.append((s,p)); s=x; p=x
    runs.append((s,p))
    print("gap runs:", [f"${a:04X}-${b:04X}({b-a+1})" for a,b in runs[:20]])
print(f"errors              : {len(errors)}")
for e in errors[:40]:
    print("  ERROR", e)
sys.exit(1 if errors or gaps or code_bytes+data_bytes != 32768 else 0)
