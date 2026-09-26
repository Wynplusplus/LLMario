/* Shared CPU state for the decompiled Super Mario Bros. PRG.
 *
 * Deliberately freestanding: only built-in types are used so the generated
 * code can be compiled for x86-64 and aarch64 without a target libc/sysroot.
 */
#ifndef SMB_CPU_H
#define SMB_CPU_H

typedef unsigned char u8;
typedef unsigned short u16;
typedef unsigned int u32;

/* 6502 status register bits. */
#define F_C 0x01
#define F_Z 0x02
#define F_I 0x04
#define F_D 0x08
#define F_B 0x10
#define F_U 0x20
#define F_V 0x40
#define F_N 0x80

typedef struct {
    u8 a, x, y, s, p;   /* accumulator, X, Y, stack pointer, status */
    u16 pc;             /* program counter */
    u8 mem[0x10000];    /* 64 KiB address space */
} Cpu;

/* Instruction dispatch table: non-NULL for every address translated to C.
 * A NULL entry means the address holds data, not code. */
typedef void (*CpuOp)(Cpu *);

#endif /* SMB_CPU_H */
