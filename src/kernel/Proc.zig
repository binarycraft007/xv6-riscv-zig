const std = @import("std");
const param = @import("param.zig");
const riscv = @import("riscv.zig");
const swtch = @import("swtch.zig");
const Cpu = @import("Cpu.zig");
const kvm = @import("kvm.zig");
const kalloc = @import("kalloc.zig");
const memlayout = @import("memlayout.zig");
const SpinLock = @import("SpinLock.zig");
const mem = std.mem;

pub var cpus: [param.NCPU]Cpu = undefined;

pub const TrapFrame = struct {
    kernel_satp: u64,
    kernel_sp: u64,
    kernel_trap: u64,
    epc: u64,
    kernel_hartid: u64,
    ra: u64,
    sp: u64,
    gp: u64,
    tp: u64,
    t0: u64,
    t1: u64,
    t2: u64,
    s0: u64,
    s1: u64,
    a0: u64,
    a1: u64,
    a2: u64,
    a3: u64,
    a4: u64,
    a5: u64,
    a6: u64,
    a7: u64,
    s2: u64,
    s3: u64,
    s4: u64,
    s5: u64,
    s6: u64,
    s7: u64,
    s8: u64,
    s9: u64,
    s10: u64,
    s11: u64,
    t3: u64,
    t4: u64,
    t5: u64,
    t6: u64,
};

pub const ProcState = enum {
    UNUSED,
    USED,
    SLEEPING,
    RUNNABLE,
    RUNNING,
    ZOMBIE,
};

const Proc = @This();
var procs: [param.NPROC]Proc = undefined;

lock: SpinLock,
state: ProcState,
chan: ?*anyopaque,
killed: bool,
xstate: i32,
pid: i32,
parent: *Proc,

kstack: u64,
size: u64,
pagetable: riscv.PageTable,
trapframe: *TrapFrame,
context: Cpu.Context,

pub fn cpuId() u32 {
    return @as(u32, @intCast(riscv.r_tp()));
}

pub fn MyCpu() *Cpu {
    return &cpus[cpuId()];
}

pub fn MyProc() *Proc {
    SpinLock.pushOff();
    var cpu = MyCpu();
    var proc = cpu.proc;
    SpinLock.popOff();
    return proc;
}

pub fn sched() void {
    var p = MyProc();

    if (!p.lock.holding())
        @panic("sched p->lock");
    if (MyCpu().noff != 1)
        @panic("sched locks");
    if (p.state == .RUNNING)
        @panic("sched running");
    if (riscv.intr_get())
        @panic("sched interruptible");

    var intena = MyCpu().intena;
    swtch.swtch(&p.context, &MyCpu().context);
    MyCpu().intena = intena;
}

pub fn sleep(chan: *anyopaque, lock: *SpinLock) void {
    var proc = MyProc();

    // Must acquire p->lock in order to
    // change p->state and then call sched.
    // Once we hold p->lock, we can be
    // guaranteed that we won't miss any wakeup
    // (wakeup locks p->lock),
    // so it's okay to release lk.

    proc.lock.acquire(); //DOC: sleeplock1
    // Reacquire original lock.
    defer proc.lock.release();

    lock.release();
    defer lock.acquire();

    // Go to sleep.
    proc.chan = chan;
    proc.state = .SLEEPING;

    sched();

    // Tidy up.
    proc.chan = null;
}

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
pub fn wakeup(chan: *anyopaque) void {
    for (procs) |*proc| {
        if (proc != MyProc()) {
            proc.lock.acquire();
            defer proc.lock.release();
            if (proc.state == .SLEEPING and
                proc.chan == chan)
            {
                proc.state = .RUNNABLE;
            }
        }
    }
}

pub fn mapStacks(kpgtbl: []usize) !void {
    for (0..procs.len) |i| {
        var pa = try kalloc.allocPage();
        var va = memlayout.KSTACK(i);
        try kvm.mapPages(kpgtbl, .{
            .virt_addr = va,
            .phy_addr = @intFromPtr(&pa[0]),
            .size = mem.page_size,
            .perm = riscv.PTE_R | riscv.PTE_W,
        });
    }
}
