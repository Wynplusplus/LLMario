# LLMario

A matching decompilation of **Super Mario Bros. (World)** for the NES, produced
end-to-end by an LLM coding agent (DeepSeek V4.1 Flash running in OpenCode),
with independent LLM verification at each stage.

Two artifacts are included, both derived from a ROM *you* supply:

1. **A matching 6502 disassembly** that reassembles byte-for-byte to the
   original 32 KiB PRG ROM.
2. **A C decompilation** of that PRG that compiles for **x86-64** and
   **aarch64** and reproduces the exact CPU semantics of every translated
   instruction.

> **No ROM data is included.** This repository contains no `.nes`, no PRG/CHR
> images, and the generated C does not embed the ROM. You must extract the PRG
> from your own legally obtained copy of Super Mario Bros. (World). *Super
> Mario Bros.* is a trademark of Nintendo; this project is unofficial and
> unaffiliated. The disassembly and C are derived works produced for
> interoperability, study and preservation.

---

## Repository layout

```
LLMario/
├── README.md                 this file: how the decomp was made
├── extract_rom.sh            split your iNES ROM into header/PRG/CHR
├── gen.py                    disassembly generator (needs Ghidra map + PRG)
├── smb.cfg                   ld65 config: 32 KiB segment loaded at $8000
├── build.sh                  assemble the disassembly and cmp against the ROM
├── ppu.py                    static map of the ROM's PPU register programming
├── ghidra/
│   ├── SeedExec.java         mark the raw block executable + add entry points
│   ├── AnalyzeDump.java      recursive disassembly + export a code/data map
│   └── DumpMap.java          minimal listing+map exporter
├── out/
│   ├── smb.asm               the matching disassembly (committed)
│   └── ghidra_map.txt        Ghidra's instruction/data map
├── c/
│   ├── cpu.h                 CPU state: registers, flags, 64 KiB memory
│   ├── gen_c.py              C generator (reads the verified smb.asm)
│   ├── ppu.h / ppu.c         NES PPU register model + command logger
│   ├── pputrace.c            runs the CPU through the PPU, prints the stream
│   ├── ref6502.c             independent 6502 interpreter (test reference)
│   ├── difftest.c            differential test: C vs the interpreter
│   ├── build_c.sh            build x86-64 + aarch64 and run the diff test
│   ├── out/                  generated C and tables
│   ├── README.md             C-specific details
│   ├── VERIFICATION.md       summary of the verification rounds
│   └── VERIFY_*.txt          full transcripts of the verification sessions
└── docs/
    ├── disassembly.md              disassembly-specific details
    ├── disassembly_verification.md LLM verification of the disassembly
    └── verify_disasm*.{py,txt}     the disassembly verifier and transcript
```

---

## Prerequisites

| Tool | Used for |
| --- | --- |
| Python 3 | `gen.py`, `gen_c.py`, `extract_rom.sh` |
| [cc65](https://cc65.github.io/) (`ca65`, `ld65`) | assembling the disassembly |
| [Ghidra](https://ghidra-sre.org/) 12.x (Flatpak or standalone) | initial analysis |
| `gcc` | x86-64 C build |
| [Zig](https://ziglang.org/) | aarch64 C build (`zig cc -target aarch64-linux-gnu`) |

No game data is required to build the tooling; only the final verification steps
and `gen.py` need the PRG, which you extract yourself.

---

## Part A — the matching disassembly

### A1. Split the ROM and read the vectors

A 40,976-byte iNES file is: 16-byte header + 2×16 KiB PRG + 8 KiB CHR. The PRG
is mapped at CPU `$8000-$FFFF`. The 6502 interrupt vectors live in the last six
bytes of the PRG:

```
$FFFA/$FFFB  NMI   = $8082
$FFFC/$FFFD  RESET = $8000
$FFFE/$FFFF  IRQ   = $FFF0
```

`extract_rom.sh` writes `out/header.bin`, `out/prg.bin` and `out/chr.bin` and
prints the PRG SHA-256 (`5374abb6…d594` for the (World) revision used here).

### A2. Ghidra headless analysis

The raw PRG is imported as a flat binary with Ghidra's built-in 6502 processor:

```
flatpak run --command=/app/lib/ghidra/support/analyzeHeadless \
  org.ghidra_sre.Ghidra ghidra proj \
  -import out/prg.bin -processor 6502:LE:16:default \
  -loader BinaryLoader -loader-baseAddr 0x8000 -overwrite \
  -scriptPath ghidra -preScript SeedExec.java \
  -postScript AnalyzeDump.java out/ghidra_map.txt
```

* `SeedExec.java` runs **before** analysis: it marks the block executable and
  registers `$8000/$8082/$FFF0` as entry points, so Ghidra's recursive
  disassembler starts from the real code.
* `AnalyzeDump.java` runs after analysis and, after re-seeding a full recursive
  disassembly from the vectors (and clearing the vector table so it is not
  decoded as code), writes a per-address map: `I <addr> <len>` for instruction
  starts and `D <addr> <len>` for data/undefined units.

Ghidra on its own found only ~1,067 instructions (about 2.3 KiB), all in
`$8000-$8FFF` and `$F000-$FFFF`: the game reaches most of its code through
**indirect dispatch**, which static recursive descent cannot follow. That is
why the next step exists.

### A3. Recursive traversal with jump-table resolution (`gen.py`)

`gen.py` performs its own complete 6502 traversal, using Ghidra's instruction
starts as additional seeds:

* Seed from `$8000`, `$8082`, `$FFF0` and every Ghidra instruction start.
* Decode with a full 256-entry (documented) opcode table, following `JSR`
  (target *and* return site), `JMP abs`, branches (target *and* fall-through),
  and stopping at `RTS`/`RTI`/`BRK`.
* **Resolve the game's jump engine.** SMB dispatches handlers through an
  in-line table consumed by the routine at `$8E04`:
  ```asm
  8E04: ASL A        ; A = index*2
  8E05: TAY
  8E06: PLA / STA $04 ; return address = in-line table
  8E0A: PLA / STA $05
  8E0C: INY / LDA ($04),Y / STA $06
  8E11: INY / LDA ($04),Y / STA $07
  8E16: JMP ($06)     ; dispatch
  ```
  Every `JSR $8E04` is followed by a table of 16-bit little-endian handler
  pointers. `gen.py` finds all 18 call sites, reads the tables, and seeds the
  handlers, which unlocks the bulk of the game code.
* **Targets take priority over fall-through**, and overlapping decodes are
  rejected, so every byte is covered exactly once.
* Everything not proven to be code is emitted as `.byte`.

Coverage rose from 7% (Ghidra alone) to **66.6% of the PRG as decoded code**:
10,255 instruction streams, 21,826 code bytes, 10,942 data bytes.

### A4. Emitting ca65 source

Each instruction is emitted in ca65 syntax with forced operand sizes so the
assembler reproduces the exact addressing mode:

* `z:$xx` forces zero-page, `a:$xxxx` forces absolute (otherwise ca65 would
  silently choose the shorter form and change the bytes).
* `(zp,x)` / `(zp),y` / `($xxxx)` for the indirect forms.
* Relative branches use labels (`Lxxxx:`), because ca65 resolves branch
  displacements at assembly time; absolute jumps/calls use literal addresses.
* Each line carries a `; $ADDR: bytes` comment so the output is directly
  checkable against the ROM.

### A5. Byte-exact verification

```sh
python3 gen.py          # regenerate out/smb.asm
./build.sh              # ca65 + ld65, then cmp against out/prg.bin
```

`cmp` confirms the reassembled PRG is **byte-identical** to the original
(32,768 bytes), and concatenating header + rebuilt PRG + CHR reproduces the full
40,976-byte iNES image.

An independent OpenCode/DeepSeek session then re-verified this: it wrote its own
6502 re-encoder, confirmed all 10,255 instructions re-encode to the ROM bytes
(0 errors), confirmed 32,768/32,768 bytes are covered with no gaps or overlaps,
and showed that `da65`'s disagreements were `da65` desyncs on level data — not
errors here. See `docs/disassembly_verification.md`.

---

## Part B — decompilation to C

### B1. Source of truth

The C generator does **not** re-derive the code map; it parses the *verified*
`out/smb.asm`, so the C corresponds one-to-one with the instruction set the
assembly verifier already confirmed.

### B2. Closing the code map

A purely linear disassembly misses **alternate entry points** hidden inside
another instruction's operand — the classic `BIT abs` skip idiom. For example:

```
8222: 2C A0 04   BIT $04A0
8223:          \ A0 04   LDY #$04   <- also a JSR target, executed directly
```

`gen_c.py` therefore expands the map: it collects every static control-flow
target (branch/JMP/JSR operands plus fall-through and return sites) and decodes
new streams directly from `prg.bin` to a fixpoint, allowing overlap (one C
function per address, dispatch selects by PC). This added **65 entry points**,
including `$8223`, `$C902`, `$C905`, `$BFB7`, `$DC21`, for a total of
**10,320 translated addresses**.

### B3. Translating instructions to C

Every translated address becomes a C function over a `Cpu` struct
(`a,x,y,s,p,pc` + `mem[0x10000]`):

```c
static void I_8000(Cpu *c){ c->p |= F_I; c->pc = 0x8001; }
static void I_802B(Cpu *c){ push16(c, 0x802D); c->pc = 0x90CC; }
```

* Operand addresses are computed per addressing mode, including zero-page wrap
  for `(zp,X)`/`(zp),Y` and 16-bit wrap for indexed absolute.
* Flag effects live in small helpers (`setnz`, `do_adc`, `do_sbc`, `do_cmp`,
  `do_asl/lsr/rol/ror`, `do_inc/dec`, `do_bit`) that reproduce the 6502's carry,
  overflow, negative and zero semantics.
* `JMP (ind)` implements the NMOS page-boundary bug; `JSR`/`RTS` push and pull
  `PC-1`; `BRK` pushes `PC+2` and the status with `B|U`, sets `I`, and jumps
  through `$FFFE`; `PHA/PHP/PLA/PLP` and the flag set/clear instructions are
  modelled directly.
* `optab[0x10000]` maps each code address to its function. **Data addresses
  have no entry**, so hitting one halts instead of executing garbage.

The generated file is freestanding (only `cpu.h`, no libc), which is what lets
it compile for a bare aarch64 target without a sysroot.

### B4. No ROM in the repository

`smb_cpu_init(Cpu *, const u8 *prg)` takes the 32 KiB PRG image from the
caller. The repository therefore ships the *decompiled code* but not the ROM;
the test binary loads `out/prg.bin`, which you extract with `extract_rom.sh`.

### B5. Differential verification

`ref6502.c` is a second, independently written 6502 interpreter (a switch-based
decoder with explicit inline flag arithmetic). `difftest.c` initialises the
decompiled CPU and this reference to *identical* states, steps both, and
compares `pc,a,x,y,s,p` and **all 64 KiB of memory** after every step:

* **Phase 0** — traces from the RESET/NMI/IRQ vectors.
* **Phase 1** — every one of the 10,320 translated addresses, one step each
  with a randomised CPU/memory state, checking each instruction occurrence's
  addressing and flag effects.
* **Phase 1b** — asserts every translated address has a dispatch entry.
* **Phase 2** — 500 random multi-step traces.
* **Gap detection** — if execution reaches a static control-flow target in
  `$8000-$FFFF` that holds a valid instruction but has no C function, that is
  reported as a *gap* (a failure), not a silent stop.

Result: **10,910 trials / 78,629 steps / 0 state mismatches / 0 gaps.** Removing
any single translated function makes the test fail, so the gap check is not
vacuous.

### B6. Building for x86-64 and aarch64

```sh
./extract_rom.sh "/path/to/Super Mario Bros. (World).nes"
cd c && ./build_c.sh
```

`build_c.sh` uses host `gcc` for x86-64 and `zig cc -target aarch64-linux-gnu`
for ARM64, producing `out/smb_prg_x64.o` / `out/smb_prg_arm64.o` (and static
archives). Because the code is freestanding, Zig needs no target sysroot.

---

## Part C — the "GPU": decompiling the PPU interface

There is no GPU instruction set on the NES. The **PPU is fixed-function**; the
CPU programs it through eight registers (`$2000-$2007`) plus `$4014` (OAM DMA).
So the "GPU instructions" are a register-level **command stream**, and this part
extracts and models it.

**Static map** (`ppu.py` → `out/ppu_map.txt`) lists every PPU register access in
the disassembly and identifies the key routines:

* `$8E2D` — block fill: `PPUADDR=$2400`, then 960× `PPUDATA=$24`, 64× `=$00`.
* `$8E92` — the **VRAM upload interpreter** (SMB's display-list player): takes a
  pointer, writes `PPUADDR`, selects the `PPUCTRL` increment, and streams bytes
  to `PPUDATA` with a run length. The game's tilemap/pattern uploads go through
  it.
* `$8EE6` writes `PPUSCROLL`, `$8EED` writes `PPUCTRL`, `$8E5C` reads the
  controllers, and the NMI at `$8082` does `OAMDMA` from `$0200` each frame.

**Runtime model and trace.** `gen_c.py` routes accesses to $2000-$3FFF plus $4014
through `g_io_write`/`g_io_read` hooks (NULL by default, so the differential
test is unaffected). `ppu.c` implements the register interface — `PPUADDR`
write toggle, VRAM auto-increment, buffered `PPUDATA` reads, palette mirroring,
OAM DMA and a command log. `pputrace.c` runs the decompiled CPU's reset to the
NMI wait, then one NMI frame, and prints the captured program:

```
reset ran 19317 steps, reached $8057
NMI ran 24375 steps
  PPUCTRL = $10 ; PPUMASK = $06
  PPUADDR = $2400 ; PPUDATA[$2400] <- $24 (x960) ; PPUDATA[$27C0] <- $00 (x64)
  PPUSCROLL = $00 ; PPUSCROLL = $00
  PPUADDR = $2000 ; PPUDATA[$2000] <- $24 (x960) ...
  OAMADDR = $00 ; OAMDMA page $0200 (256 bytes) ...
```

Details in `c/PPU.md`. This is a register/command model, not yet a
cycle-accurate or rendering PPU.

---

## Verification by a second LLM (up to five rounds)

The task brief required using a separate OpenCode session running the same model
(DeepSeek V4.1 Flash) to verify the C and, on failure, to receive fix
instructions. Three rounds were needed:

| Round | Outcome |
| --- | --- |
| 1 | **FAIL.** Confirmed instruction semantics but found 5 reachable entry points missing from the C (`$8223`, `$C902`, `$C905`, `$BFB7`, `$DC21`), showed the diff test could not detect gaps, and gave precise fixes. |
| 2 | Verified the fixes; caught a false positive (gap detection flagged RAM below `$8000`). The run ended on an upstream API error before a verdict. |
| 3 | **PASS.** Builds, `mismatches=0 gaps=0`, non-vacuous gap detection, an independent traversal found 0 reachable-but-untranslated instructions, and 44 hand-computed 6502 results matched. No changes required. |

Full transcripts: `c/VERIFY_ITER1.txt`, `c/VERIFY_ITER2.txt`,
`c/VERIFY_ITER3.txt`, `c/VERIFY_ITER4.txt`; summary in `c/VERIFICATION.md`.

---

## Results

| Metric | Value |
| --- | --- |
| ROM PRG | 32,768 bytes at `$8000-$FFFF` |
| Ghidra-only code discovery | ~1,067 instructions |
| Matching disassembly | 10,255 instruction streams, 21,826 code bytes (66.6%) |
| Reassembled PRG | byte-identical to the original |
| C translation | 10,320 functions, freestanding |
| Compiles for | x86-64 (gcc) and aarch64 (zig) |
| Differential test | 10,910 trials, 78,629 steps, 0 mismatches, 0 gaps |

---

## Scope and limitations

* This is an **instruction-level (lifted) C decompilation**: faithful to the
  machine semantics, but it does not recover original function/variable names
  or produce structured high-level code.
* The **CPU is fully modelled**, and the **PPU register interface** is modelled
  (Part C) with a captured command stream. The APU (sound), controller-timing
  and a cycle-accurate *rendering* PPU are not implemented, so this is not yet
  a standalone playable game.
* Decimal mode (`SED`) is intentionally treated as binary. Super Mario Bros.
  does not use decimal mode; the reference interpreter matches.
* Code reachable only through runtime-computed pointers may remain embedded as
  data rather than translated.
* The `out/smb.asm` disassembly necessarily contains the ROM's instruction
  stream and data tables in assembly form; that is the nature of a matching
  decompilation. No ROM *image* is included.

## Credits and provenance

All source, tests and documentation were written by **DeepSeek V4.1 Flash**
running in **OpenCode**, driven by natural-language prompts from the repository
owner. Verification was performed by separate sessions of the same model. The
original game is © Nintendo; no game content is included in this repository.
