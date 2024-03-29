// Physical memory layout

// qemu -machine virt is set up like this,
// based on qemu's hw/riscv/virt.c:

// 00001000 -- boot ROM, provided by qemu
// 02000000 -- CLINT
// 0C000000 -- PLIC
// 10000000 -- uart0
// 10001000 -- virtio disk
// 80000000 -- boot ROM jumps here in machine mode
//             -kernel loads the kernel here
// unused RAM after 80000000.

// the kernel uses physical memory thus:
// 80000000 -- entry.S, then kernel text and data
// end -- start of kernel page allocation area
// PHYSTOP -- end RAM used by the kernel

const riscv = @import("riscv.zig");
// qemu puts UART registers here in physical memory.
pub const UART0 = 0x10000000;
pub const UART0_IRQ = 10;

// virtio mmio interface
pub const VIRTIO0 = 0x10001000;
pub const VIRTIO0_IRQ = 1;

// core local interruptor (CLINT), which contains the timer.
pub const CLINT = 0x2000000;
pub fn CLINT_MTIMECMP(hartid: usize) *usize {
    return @as(*usize, @ptrFromInt(CLINT + 0x4000 + 8 * hartid));
}
// cycles since boot.
pub const CLINT_MTIME = @as(*usize, @ptrFromInt(CLINT + 0xBFF8));

// qemu puts platform-level interrupt controller (PLIC) here.
pub const PLIC = 0x0c000000;
pub const PLIC_PRIORITY = PLIC + 0x0;
pub const PLIC_PENDING = PLIC + 0x1000;
pub fn PLIC_MENABLE(hart: usize) usize {
    return PLIC + 0x2000 + hart * 0x100;
}
pub fn PLIC_SENABLE(hart: usize) usize {
    return PLIC + 0x2080 + hart * 0x100;
}
pub fn PLIC_MPRIORITY(hart: usize) usize {
    return PLIC + 0x200000 + hart * 0x2000;
}
pub fn PLIC_SPRIORITY(hart: usize) usize {
    return PLIC + 0x201000 + hart * 0x2000;
}
pub fn PLIC_MCLAIM(hart: usize) usize {
    return PLIC + 0x200004 + hart * 0x2000;
}
pub fn PLIC_SCLAIM(hart: usize) usize {
    return PLIC + 0x201004 + hart * 0x2000;
}

// the kernel expects there to be RAM
// for use by the kernel and user pages
// from physical address 0x80000000 to PHYSTOP.
pub const KERNBASE = 0x80000000;
pub const PHYSTOP = KERNBASE + 128 * 1024 * 1024;

// map the trampoline page to the highest address,
// in both user and kernel space.
pub const TRAMPOLINE = riscv.MAXVA - riscv.PGSIZE;

// map kernel stacks beneath the trampoline,
// each surrounded by invalid guard pages.
pub fn KSTACK(p: usize) usize {
    return TRAMPOLINE - (p + 1) * 2 * riscv.PGSIZE;
}

// User memory layout.
// Address zero first:
//   text
//   original data and bss
//   fixed-size stack
//   expandable heap
//   ...
//   TRAPFRAME (p->trapframe, used by the trampoline)
//   TRAMPOLINE (the same page as in the kernel)
pub const TRAPFRAME = TRAMPOLINE - riscv.PGSIZE;
