const c = @cImport({
    @cInclude("kernel/types.h");
    @cInclude("kernel/param.h");
    @cInclude("kernel/memlayout.h");
    @cInclude("kernel/riscv.h");
    @cInclude("kernel/defs.h");
});
const std = @import("std");
const riscv = @import("riscv.zig");
const Printf = @import("Printf.zig");
const Console = @import("Console.zig");
const Atomic = std.atomic.Atomic;

var started = Atomic(bool).init(false);
pub var printf: Printf = undefined;

pub fn kmain() void {
    if (c.cpuid() == 0) {
        c.consoleinit();
        //_ = Console.init();
        c.printfinit();
        printf = Printf.init();
        printf.print("\n", .{});
        printf.print("xv6 kernel is booting\n", .{});
        printf.print("\n", .{});
        c.kinit(); // physical page allocator
        c.kvminit(); // create kernel page table
        c.kvminithart(); // turn on paging
        c.procinit(); // process table
        c.trapinit(); // trap vectors
        c.trapinithart(); // install kernel trap vector
        c.plicinit(); // set up interrupt controller
        c.plicinithart(); // ask PLIC for device interrupts
        c.binit(); // buffer cache
        c.iinit(); // inode table
        c.fileinit(); // file table
        c.virtio_disk_init(); // emulated hard disk
        c.userinit(); // first user process
        started.store(true, .SeqCst);
    } else {
        while (!started.load(.SeqCst)) {}

        printf.print("hart {d} starting\n", .{c.cpuid()});
        c.kvminithart(); // turn on paging
        c.trapinithart(); // install kernel trap vector
        c.plicinithart(); // ask PLIC for device interrupts
    }
    c.scheduler();
}
