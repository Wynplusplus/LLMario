# The "GPU": decompiling the NES PPU interface

## There is no GPU instruction set

Unlike a modern GPU (or the microcoded coprocessors on later consoles), the NES
**PPU has no programmable instruction set**. It is a fixed-function chip: the
CPU configures and feeds it through eight memory-mapped registers. So there is
no "GPU program" to disassemble in the ROM — but there *is* a GPU **command
stream**, and that is what this directory decompiles.

Register interface (`$2000-$2007`, plus `$4014`):

| Register | Name | Function |
| --- | --- | --- |
| `$2000` | PPUCTRL | NMI enable, sprite size, background pattern table, VRAM increment |
| `$2001` | PPUMASK | background/sprite enable, left-column masking, colour emphasis |
| `$2002` | PPUSTATUS | VBlank/sprite-0 flags (read); resets the write toggle |
| `$2003` | OAMADDR | sprite memory address |
| `$2004` | OAMDATA | sprite memory data |
| `$2005` | PPUSCROLL | scroll X then Y (two writes) |
| `$2006` | PPUADDR | VRAM address high then low (two writes) |
| `$2007` | PPUDATA | VRAM/palette data; auto-increments |
| `$4014` | OAMDMA | copy 256 bytes of CPU memory to PPU sprite memory |

## What SMB's "GPU program" looks like

The static map is in `../out/ppu_map.txt` (`../ppu.py`). The interesting
routines are:

* **`$8E2D` — block fill.** Sets `PPUADDR = $2400`, then writes `PPUDATA = $24`
  960 times and `PPUDATA = $00` 64 times (optionally setting the vertical
  increment in PPUCTRL), clearing a nametable/attribute region.
* **`$8E92` — the VRAM upload interpreter.** This is SMB's display-list
  interpreter: it takes a pointer in `$00/$01`, writes the two bytes of
  `PPUADDR`, uses a control byte to choose the PPUCTRL increment (horizontal or
  vertical) and a run length, then streams that many bytes to `PPUDATA`.
  Data tables throughout the ROM are fed through this routine.
* **`$8EE6`** writes `PPUSCROLL` twice; **`$8EED`** writes `PPUCTRL`.
* **`$8E5C`** reads both controllers (strobe `$4016`, then shift in 8 reads).
* **The NMI at `$8082`** runs once per frame: it updates `PPUCTRL`, `PPUMASK`
  and `OAMADDR`, issues an `OAMDMA` from `$0200` (the shadow OAM the game
  builds in RAM), then performs scroll and VRAM updates.

## The model and the trace

`ppu.h`/`ppu.c` implement that register interface: the PPUADDR write toggle,
VRAM auto-increment, buffered `PPUDATA` reads, palette/VRAM mirroring, OAM DMA
from CPU memory, and a command log (contiguous same-value `PPUDATA` writes are
coalesced).

`pputrace.c` runs the decompiled CPU with this PPU attached. The generated C
routes accesses to `$2000-$3FFF` plus `$4014` through `g_io_write`/`g_io_read` hooks
(`gen_c.py`), so the same instruction functions drive the PPU. It executes the
reset routine to the NMI wait loop, then one NMI frame, and prints the command
stream:

```
reset ran 19317 steps, reached $8057
NMI ran 24375 steps

=== PPU command stream (in order) ===
  PPUCTRL    = $10
  PPUMASK    = $06
  PPUCTRL    = $10
  PPUADDR    = $2400
  PPUDATA<- [$2400] <- $24  (x960)
  PPUDATA<- [$27C0] <- $00  (x64)
  PPUSCROLL  = $00
  PPUSCROLL  = $00
  PPUADDR    = $2000
  PPUDATA<- [$2000] <- $24  (x960)
  ...
  OAMADDR    = $00
  OAMDMA     page $0200 (256 bytes)
  ...
```

Run it with:

```sh
./extract_rom.sh "/path/to/Super Mario Bros. (World).nes"
cd c && cc -O2 -I. -o out/pputrace pputrace.c ppu.c out/smb_prg.c && ./out/pputrace ../out/prg.bin
```

## Scope

The model captures the **register/command** semantics needed to expose the
game's GPU program; it is not a cycle-accurate PPU and does not yet render
pixels. `PPUSTATUS` reports VBlank set so the game's busy-waits terminate.
A rendering PPU (background nametable fetch + sprite compositing) would be the
next step to make the decompiled code produce an image.
