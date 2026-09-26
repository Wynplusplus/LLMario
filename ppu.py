#!/usr/bin/env python3
"""Static map of the ROM's PPU programming -- the game's "GPU program".

The NES PPU has no instruction set; the CPU programs it through the registers
$2000-$2007 and $4014. This tool lists every such access in the matching
disassembly, grouped by register, and writes out/ppu_map.txt.
"""
import os
import re
import collections

ROOT = os.path.dirname(os.path.abspath(__file__))
ASM = os.path.join(ROOT, "out/smb.asm")
OUT = os.path.join(ROOT, "out/ppu_map.txt")

REGS = {
    0x2000: "PPUCTRL", 0x2001: "PPUMASK", 0x2002: "PPUSTATUS",
    0x2003: "OAMADDR", 0x2004: "OAMDATA", 0x2005: "PPUSCROLL",
    0x2006: "PPUADDR", 0x2007: "PPUDATA", 0x4014: "OAMDMA",
}
READ_OPS = {"LDA", "LDX", "LDY", "BIT", "CMP", "ORA", "AND", "EOR", "ADC", "SBC"}
WRITE_OPS = {"STA", "STX", "STY", "INC", "DEC", "ASL", "LSR", "ROL", "ROR"}

sites = collections.defaultdict(list)   # reg -> list of (addr, mn, dir)
for line in open(ASM):
    m = re.match(r"\s+([A-Z]{3})\s+(.*?)\s*;\s*\$([0-9A-F]{4}):", line)
    if not m:
        continue
    mn, oper, addr = m.group(1), m.group(2), int(m.group(3), 16)
    mm = re.search(r"\$([0-9A-F]{4})", oper)
    if not mm:
        continue
    a = int(mm.group(1), 16)
    if a in REGS:
        if mn in WRITE_OPS:
            sites[REGS[a]].append((addr, mn, "w"))
        elif mn in READ_OPS:
            sites[REGS[a]].append((addr, mn, "r"))

lines = []
lines.append("PPU register access map (static)")
lines.append("=================================")
lines.append("")
lines.append("The NES PPU is fixed-function: there is no GPU instruction set.")
lines.append("The CPU programs it through these registers. Sites below are")
lines.append("direct absolute accesses in the matching disassembly; SMB also")
lines.append("writes PPUADDR/PPUDATA through the VRAM upload routine at $8E92.")
lines.append("")
total = 0
for reg_addr, name in REGS.items():
    rows = sorted(sites.get(name, []))
    if not rows:
        continue
    lines.append(f"{name} (${reg_addr:04X}) -- {len(rows)} site(s)")
    for addr, mn, d in rows:
        lines.append(f"    ${addr:04X}  {mn} {name}  ({'write' if d == 'w' else 'read'})")
    lines.append("")
    total += len(rows)
lines.append(f"total direct sites: {total}")
lines.append("")
lines.append("Key routines (from the disassembly):")
lines.append("  $8E2D  clear/load a VRAM block: PPUADDR=$2400, then 960x PPUDATA=$24")
lines.append("         and 64x PPUDATA=$00 (nametable/attribute fill)")
lines.append("  $8E92  VRAM upload interpreter: takes a pointer in $00/$01, sets")
lines.append("         PPUADDR, selects the PPUCTRL increment, and streams bytes to")
lines.append("         PPUDATA with a run-length count")
lines.append("  $8EE6  set PPUSCROLL from A (writes $2005 twice)")
lines.append("  $8EED  write PPUCTRL from A")
lines.append("  $8E5C  read both controllers via the $4016 strobe/shift sequence")
lines.append("  NMI at $8082: writes PPUCTRL/PPUMASK/OAMADDR, OAMDMA from $0200, then")
lines.append("         OAM/scroll/VRAM updates")

open(OUT, "w").write("\n".join(lines) + "\n")
print("\n".join(lines))
print(f"\nwrote {OUT}")
