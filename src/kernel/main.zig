const c = @cImport({
    @cInclude("src/kernel/types.h");
    @cInclude("src/kernel/param.h");
    @cInclude("src/kernel/memlayout.h");
    @cInclude("src/kernel/riscv.h");
    @cInclude("src/kernel/defs.h");
});
const std = @import("std");
const log_root = @import("log.zig");
const kmain_log = std.log.scoped(.kmain);
const riscv = @import("riscv.zig");
const kalloc = @import("kalloc.zig");
const kvm = @import("kvm.zig");
const console = @import("console.zig");
const Proc = @import("Proc.zig");
const Atomic = std.atomic.Atomic;

var started = Atomic(bool).init(false);

pub fn kmain() void {
    if (Proc.cpuId() == 0) {
        console.init();
        c.consoleinit(); // one init step is not implementated in zig
        kmain_log.info("xv6 kernel is booting\n", .{});
        kalloc.init(); // physical page allocator
        kvm.init(); // create kernel page table
        kvm.initHart(); // turn on paging
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

        kmain_log.info("hart {d} starting\n", .{Proc.cpuId()});
        kvm.initHart(); // turn on paging
        c.trapinithart(); // install kernel trap vector
        c.plicinithart(); // ask PLIC for device interrupts
    }
    c.scheduler();
}
