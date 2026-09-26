# Super Mario Bros. (World) — decompilation to C

An instruction-level **C decompilation** of the Super Mario Bros. PRG ROM. It
compiles for **x86-64** and **aarch64** (ARM64) and preserves the exact
semantics of every translated 6502 instruction, as checked by differential
testing against an independent 6502 interpreter.

## What this is

The matching disassembly (`../out/smb.asm`, 10,255 instruction streams) is
translated into portable C. A further 65 alternate entry points that the linear
disassembly missed (the `BIT abs` operand-as-entry idiom) are decoded directly
from the ROM, giving **10,320 translated instruction addresses**:

* Every decoded 6502 instruction becomes a C function `I_XXXX(Cpu *)`.
* Registers and flags live in `Cpu` (`cpu.h`); memory is a 64 KiB array.
* Jump/subroutine/branch control flow is preserved through `c->pc`, pushes and
  pulls on the emulated stack.
* `optab[0x10000]` maps each code address to its function; data addresses have
  no entry, so execution halts rather than running garbage.
* The 32 KiB PRG image is not built into the source: `smb_cpu_init` takes a
  pointer to it, so you supply it from your own ROM (`../extract_rom.sh`). This
  keeps the repository free of ROM data while preserving exact semantics.

## Files

| File | Purpose |
| --- | --- |
| `cpu.h` | `Cpu` state and flag bits (freestanding, no libc) |
| `gen_c.py` | Generates `out/smb_prg.c` from the verified `smb.asm` |
| `out/smb_prg.c` | Generated C (10,320 instruction functions, 22,762 lines) |
| `ref6502.c` | Independent 6502 interpreter (differential-test reference) |
| `difftest.c` | Runs the C and the reference on identical states and compares |
| `build_c.sh` | Builds both architectures and runs the differential test |

## Build and verify

First extract the PRG from your own ROM (this repo ships **no** ROM data):

```sh
../extract_rom.sh "/path/to/Super Mario Bros. (World).nes"
```

Then:

```sh
./build_c.sh
```

Expected output ends with:

```
translated=10320  trials=10910 steps=78629 mismatches=0 gaps=0
out/smb_prg_x64.o:   ELF 64-bit LSB relocatable, x86-64 ...
out/smb_prg_arm64.o: ELF 64-bit LSB relocatable, ARM aarch64 ...
OK
```

`build_c.sh` uses host `gcc` for x86-64 and
[Zig](https://ziglang.org) (`zig cc -target aarch64-linux-gnu`) for ARM64; set
`ZIG=/path/to/zig` if it is not at the default location. No target libc or
sysroot is needed because the generated code is freestanding.

## How the differential test works

`difftest.c` initialises the decompiled CPU and the independent interpreter to
*identical* states, steps them, and compares `pc,a,x,y,s,p` and all 64 KiB of
memory after each step.

* **Phase 0** runs traces from the RESET/NMI/IRQ vectors.
* **Phase 1** starts at every one of the 10,320 translated instruction
  addresses with a randomised CPU/memory state and executes one instruction:
  this checks each instruction occurrence's addressing mode and flag effects.
* **Phase 1b** asserts every translated address has a dispatch entry.
* **Phase 2** runs 500 random traces of 50–450 instructions.
* **Gap detection** reports a *gap* (not a silent stop) when execution reaches
  a static control-flow target in `$8000-$FFFF` that holds a valid 6502
  instruction but has no C function. Removing any translated function makes the
  test fail.
* Result: **10,910 trials / 78,629 steps / 0 state mismatches / 0 gaps.**

## Scope and limitations

* This is an **instruction-level (lifted) decompilation**, not a structured
  high-level C rewrite. It faithfully preserves the machine semantics but does
  not attempt to recover original function/variable names.
* Only the CPU is modelled. NES hardware (PPU, APU, controllers) is not
  emulated, so this code is a faithful translation of the ROM's program, not a
  playable game on its own.
* Decimal mode (`SED`) is not implemented; a decimal ADC/SBC behaves as
  binary. Super Mario Bros. does not use decimal mode. The reference treats it
  the same way.
* Code reachable only through runtime-computed pointers may remain embedded as
  data rather than translated to C; such bytes are still present in memory.
* No game content beyond the structure of the ROM you supplied is included.
