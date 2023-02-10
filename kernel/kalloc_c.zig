pub const __builtin_bswap16 = @import("std").zig.c_builtins.__builtin_bswap16;
pub const __builtin_bswap32 = @import("std").zig.c_builtins.__builtin_bswap32;
pub const __builtin_bswap64 = @import("std").zig.c_builtins.__builtin_bswap64;
pub const __builtin_signbit = @import("std").zig.c_builtins.__builtin_signbit;
pub const __builtin_signbitf = @import("std").zig.c_builtins.__builtin_signbitf;
pub const __builtin_popcount = @import("std").zig.c_builtins.__builtin_popcount;
pub const __builtin_ctz = @import("std").zig.c_builtins.__builtin_ctz;
pub const __builtin_clz = @import("std").zig.c_builtins.__builtin_clz;
pub const __builtin_sqrt = @import("std").zig.c_builtins.__builtin_sqrt;
pub const __builtin_sqrtf = @import("std").zig.c_builtins.__builtin_sqrtf;
pub const __builtin_sin = @import("std").zig.c_builtins.__builtin_sin;
pub const __builtin_sinf = @import("std").zig.c_builtins.__builtin_sinf;
pub const __builtin_cos = @import("std").zig.c_builtins.__builtin_cos;
pub const __builtin_cosf = @import("std").zig.c_builtins.__builtin_cosf;
pub const __builtin_exp = @import("std").zig.c_builtins.__builtin_exp;
pub const __builtin_expf = @import("std").zig.c_builtins.__builtin_expf;
pub const __builtin_exp2 = @import("std").zig.c_builtins.__builtin_exp2;
pub const __builtin_exp2f = @import("std").zig.c_builtins.__builtin_exp2f;
pub const __builtin_log = @import("std").zig.c_builtins.__builtin_log;
pub const __builtin_logf = @import("std").zig.c_builtins.__builtin_logf;
pub const __builtin_log2 = @import("std").zig.c_builtins.__builtin_log2;
pub const __builtin_log2f = @import("std").zig.c_builtins.__builtin_log2f;
pub const __builtin_log10 = @import("std").zig.c_builtins.__builtin_log10;
pub const __builtin_log10f = @import("std").zig.c_builtins.__builtin_log10f;
pub const __builtin_abs = @import("std").zig.c_builtins.__builtin_abs;
pub const __builtin_fabs = @import("std").zig.c_builtins.__builtin_fabs;
pub const __builtin_fabsf = @import("std").zig.c_builtins.__builtin_fabsf;
pub const __builtin_floor = @import("std").zig.c_builtins.__builtin_floor;
pub const __builtin_floorf = @import("std").zig.c_builtins.__builtin_floorf;
pub const __builtin_ceil = @import("std").zig.c_builtins.__builtin_ceil;
pub const __builtin_ceilf = @import("std").zig.c_builtins.__builtin_ceilf;
pub const __builtin_trunc = @import("std").zig.c_builtins.__builtin_trunc;
pub const __builtin_truncf = @import("std").zig.c_builtins.__builtin_truncf;
pub const __builtin_round = @import("std").zig.c_builtins.__builtin_round;
pub const __builtin_roundf = @import("std").zig.c_builtins.__builtin_roundf;
pub const __builtin_strlen = @import("std").zig.c_builtins.__builtin_strlen;
pub const __builtin_strcmp = @import("std").zig.c_builtins.__builtin_strcmp;
pub const __builtin_object_size = @import("std").zig.c_builtins.__builtin_object_size;
pub const __builtin___memset_chk = @import("std").zig.c_builtins.__builtin___memset_chk;
pub const __builtin_memset = @import("std").zig.c_builtins.__builtin_memset;
pub const __builtin___memcpy_chk = @import("std").zig.c_builtins.__builtin___memcpy_chk;
pub const __builtin_memcpy = @import("std").zig.c_builtins.__builtin_memcpy;
pub const __builtin_expect = @import("std").zig.c_builtins.__builtin_expect;
pub const __builtin_nanf = @import("std").zig.c_builtins.__builtin_nanf;
pub const __builtin_huge_valf = @import("std").zig.c_builtins.__builtin_huge_valf;
pub const __builtin_inff = @import("std").zig.c_builtins.__builtin_inff;
pub const __builtin_isnan = @import("std").zig.c_builtins.__builtin_isnan;
pub const __builtin_isinf = @import("std").zig.c_builtins.__builtin_isinf;
pub const __builtin_isinf_sign = @import("std").zig.c_builtins.__builtin_isinf_sign;
pub const __has_builtin = @import("std").zig.c_builtins.__has_builtin;
pub const __builtin_assume = @import("std").zig.c_builtins.__builtin_assume;
pub const __builtin_unreachable = @import("std").zig.c_builtins.__builtin_unreachable;
pub const __builtin_constant_p = @import("std").zig.c_builtins.__builtin_constant_p;
pub const __builtin_mul_overflow = @import("std").zig.c_builtins.__builtin_mul_overflow;
pub const uint = c_uint;
pub const ushort = c_ushort;
pub const uchar = u8;
pub const uint8 = u8;
pub const uint16 = c_ushort;
pub const uint32 = c_uint;
pub const uint64 = c_ulong;
pub const pde_t = uint64;
pub const struct_cpu = opaque {};
pub const struct_spinlock = extern struct {
    locked: uint,
    name: [*c]u8,
    cpu: ?*struct_cpu,
}; // kernel/riscv.h:8:3: warning: TODO implement translation of stmt class GCCAsmStmtClass
// kernel/riscv.h:5:1: warning: unable to translate function, demoted to extern
pub extern fn r_mhartid() callconv(.C) uint64; // kernel/riscv.h:24:3: warning: TODO implement translation of stmt class GCCAsmStmtClass
// kernel/riscv.h:21:1: warning: unable to translate function, demoted to extern
pub extern fn r_mstatus() callconv(.C) uint64; // kernel/riscv.h:31:3: warning: TODO implement translation of stmt class GCCAsmStmtClass
// kernel/riscv.h:29:1: warning: unable to translate function, demoted to extern
pub extern fn w_mstatus(arg_x: uint64) callconv(.C) void; // kernel/riscv.h:40:3: warning: TODO implement translation of stmt class GCCAsmStmtClass
// kernel/riscv.h:38:1: warning: unable to translate function, demoted to extern
pub extern fn w_mepc(arg_x: uint64) callconv(.C) void; // kernel/riscv.h:55:3: warning: TODO implement translation of stmt class GCCAsmStmtClass
// kernel/riscv.h:52:1: warning: unable to translate function, demoted to extern
pub extern fn r_sstatus() callconv(.C) uint64; // kernel/riscv.h:62:3: warning: TODO implement translation of stmt class GCCAsmStmtClass
// kernel/riscv.h:60:1: warning: unable to translate function, demoted to extern
pub extern fn w_sstatus(arg_x: uint64) callconv(.C) void; // kernel/riscv.h:70:3: warning: TODO implement translation of stmt class GCCAsmStmtClass
// kernel/riscv.h:67:1: warning: unable to translate function, demoted to extern
pub extern fn r_sip() callconv(.C) uint64; // kernel/riscv.h:77:3: warning: TODO implement translation of stmt class GCCAsmStmtClass
// kernel/riscv.h:75:1: warning: unable to translate function, demoted to extern
pub extern fn w_sip(arg_x: uint64) callconv(.C) void; // kernel/riscv.h:88:3: warning: TODO implement translation of stmt class GCCAsmStmtClass
// kernel/riscv.h:85:1: warning: unable to translate function, demoted to extern
pub extern fn r_sie() callconv(.C) uint64; // kernel/riscv.h:95:3: warning: TODO implement translation of stmt class GCCAsmStmtClass
// kernel/riscv.h:93:1: warning: unable to translate function, demoted to extern
pub extern fn w_sie(arg_x: uint64) callconv(.C) void; // kernel/riscv.h:106:3: warning: TODO implement translation of stmt class GCCAsmStmtClass
// kernel/riscv.h:103:1: warning: unable to translate function, demoted to extern
pub extern fn r_mie() callconv(.C) uint64; // kernel/riscv.h:113:3: warning: TODO implement translation of stmt class GCCAsmStmtClass
// kernel/riscv.h:111:1: warning: unable to translate function, demoted to extern
pub extern fn w_mie(arg_x: uint64) callconv(.C) void; // kernel/riscv.h:122:3: warning: TODO implement translation of stmt class GCCAsmStmtClass
// kernel/riscv.h:120:1: warning: unable to translate function, demoted to extern
pub extern fn w_sepc(arg_x: uint64) callconv(.C) void; // kernel/riscv.h:129:3: warning: TODO implement translation of stmt class GCCAsmStmtClass
// kernel/riscv.h:126:1: warning: unable to translate function, demoted to extern
pub extern fn r_sepc() callconv(.C) uint64; // kernel/riscv.h:138:3: warning: TODO implement translation of stmt class GCCAsmStmtClass
// kernel/riscv.h:135:1: warning: unable to translate function, demoted to extern
pub extern fn r_medeleg() callconv(.C) uint64; // kernel/riscv.h:145:3: warning: TODO implement translation of stmt class GCCAsmStmtClass
// kernel/riscv.h:143:1: warning: unable to translate function, demoted to extern
pub extern fn w_medeleg(arg_x: uint64) callconv(.C) void; // kernel/riscv.h:153:3: warning: TODO implement translation of stmt class GCCAsmStmtClass
// kernel/riscv.h:150:1: warning: unable to translate function, demoted to extern
pub extern fn r_mideleg() callconv(.C) uint64; // kernel/riscv.h:160:3: warning: TODO implement translation of stmt class GCCAsmStmtClass
// kernel/riscv.h:158:1: warning: unable to translate function, demoted to extern
pub extern fn w_mideleg(arg_x: uint64) callconv(.C) void; // kernel/riscv.h:168:3: warning: TODO implement translation of stmt class GCCAsmStmtClass
// kernel/riscv.h:166:1: warning: unable to translate function, demoted to extern
pub extern fn w_stvec(arg_x: uint64) callconv(.C) void; // kernel/riscv.h:175:3: warning: TODO implement translation of stmt class GCCAsmStmtClass
// kernel/riscv.h:172:1: warning: unable to translate function, demoted to extern
pub extern fn r_stvec() callconv(.C) uint64; // kernel/riscv.h:183:3: warning: TODO implement translation of stmt class GCCAsmStmtClass
// kernel/riscv.h:181:1: warning: unable to translate function, demoted to extern
pub extern fn w_mtvec(arg_x: uint64) callconv(.C) void; // kernel/riscv.h:190:3: warning: TODO implement translation of stmt class GCCAsmStmtClass
// kernel/riscv.h:188:1: warning: unable to translate function, demoted to extern
pub extern fn w_pmpcfg0(arg_x: uint64) callconv(.C) void; // kernel/riscv.h:196:3: warning: TODO implement translation of stmt class GCCAsmStmtClass
// kernel/riscv.h:194:1: warning: unable to translate function, demoted to extern
pub extern fn w_pmpaddr0(arg_x: uint64) callconv(.C) void; // kernel/riscv.h:209:3: warning: TODO implement translation of stmt class GCCAsmStmtClass
// kernel/riscv.h:207:1: warning: unable to translate function, demoted to extern
pub extern fn w_satp(arg_x: uint64) callconv(.C) void; // kernel/riscv.h:216:3: warning: TODO implement translation of stmt class GCCAsmStmtClass
// kernel/riscv.h:213:1: warning: unable to translate function, demoted to extern
pub extern fn r_satp() callconv(.C) uint64; // kernel/riscv.h:223:3: warning: TODO implement translation of stmt class GCCAsmStmtClass
// kernel/riscv.h:221:1: warning: unable to translate function, demoted to extern
pub extern fn w_mscratch(arg_x: uint64) callconv(.C) void; // kernel/riscv.h:231:3: warning: TODO implement translation of stmt class GCCAsmStmtClass
// kernel/riscv.h:228:1: warning: unable to translate function, demoted to extern
pub extern fn r_scause() callconv(.C) uint64; // kernel/riscv.h:240:3: warning: TODO implement translation of stmt class GCCAsmStmtClass
// kernel/riscv.h:237:1: warning: unable to translate function, demoted to extern
pub extern fn r_stval() callconv(.C) uint64; // kernel/riscv.h:248:3: warning: TODO implement translation of stmt class GCCAsmStmtClass
// kernel/riscv.h:246:1: warning: unable to translate function, demoted to extern
pub extern fn w_mcounteren(arg_x: uint64) callconv(.C) void; // kernel/riscv.h:255:3: warning: TODO implement translation of stmt class GCCAsmStmtClass
// kernel/riscv.h:252:1: warning: unable to translate function, demoted to extern
pub extern fn r_mcounteren() callconv(.C) uint64; // kernel/riscv.h:264:3: warning: TODO implement translation of stmt class GCCAsmStmtClass
// kernel/riscv.h:261:1: warning: unable to translate function, demoted to extern
pub extern fn r_time() callconv(.C) uint64;
pub fn intr_on() callconv(.C) void {
    w_sstatus(r_sstatus() | @bitCast(c_ulong, @as(c_long, 1) << @intCast(@import("std").math.Log2Int(c_long), 1)));
}
pub fn intr_off() callconv(.C) void {
    w_sstatus(r_sstatus() & @bitCast(c_ulong, ~(@as(c_long, 1) << @intCast(@import("std").math.Log2Int(c_long), 1))));
}
pub fn intr_get() callconv(.C) c_int {
    var x: uint64 = r_sstatus();
    return @boolToInt((x & @bitCast(c_ulong, @as(c_long, 1) << @intCast(@import("std").math.Log2Int(c_long), 1))) != @bitCast(c_ulong, @as(c_long, @as(c_int, 0))));
} // kernel/riscv.h:294:3: warning: TODO implement translation of stmt class GCCAsmStmtClass
// kernel/riscv.h:291:1: warning: unable to translate function, demoted to extern
pub extern fn r_sp() callconv(.C) uint64; // kernel/riscv.h:304:3: warning: TODO implement translation of stmt class GCCAsmStmtClass
// kernel/riscv.h:301:1: warning: unable to translate function, demoted to extern
pub extern fn r_tp() callconv(.C) uint64; // kernel/riscv.h:311:3: warning: TODO implement translation of stmt class GCCAsmStmtClass
// kernel/riscv.h:309:1: warning: unable to translate function, demoted to extern
pub extern fn w_tp(arg_x: uint64) callconv(.C) void; // kernel/riscv.h:318:3: warning: TODO implement translation of stmt class GCCAsmStmtClass
// kernel/riscv.h:315:1: warning: unable to translate function, demoted to extern
pub extern fn r_ra() callconv(.C) uint64; // kernel/riscv.h:327:3: warning: TODO implement translation of stmt class GCCAsmStmtClass
// kernel/riscv.h:324:1: warning: unable to translate function, demoted to extern
pub extern fn sfence_vma() callconv(.C) void;
pub const pte_t = uint64;
pub const pagetable_t = [*c]uint64;
pub const struct_buf = opaque {};
pub const struct_context = opaque {};
pub const struct_file = opaque {};
pub const struct_inode = opaque {};
pub const struct_pipe = opaque {};
pub const struct_proc = opaque {};
pub const struct_sleeplock = opaque {};
pub const struct_stat = opaque {};
pub const struct_superblock = opaque {};
pub extern fn binit() void;
pub extern fn bread(uint, uint) ?*struct_buf;
pub extern fn brelse(?*struct_buf) void;
pub extern fn bwrite(?*struct_buf) void;
pub extern fn bpin(?*struct_buf) void;
pub extern fn bunpin(?*struct_buf) void;
pub extern fn consoleinit() void;
pub extern fn consoleintr(c_int) void;
pub extern fn consputc(c_int) void;
pub extern fn exec([*c]u8, [*c][*c]u8) c_int;
pub extern fn filealloc() ?*struct_file;
pub extern fn fileclose(?*struct_file) void;
pub extern fn filedup(?*struct_file) ?*struct_file;
pub extern fn fileinit() void;
pub extern fn fileread(?*struct_file, uint64, n: c_int) c_int;
pub extern fn filestat(?*struct_file, addr: uint64) c_int;
pub extern fn filewrite(?*struct_file, uint64, n: c_int) c_int;
pub extern fn fsinit(c_int) void;
pub extern fn dirlink(?*struct_inode, [*c]u8, uint) c_int;
pub extern fn dirlookup(?*struct_inode, [*c]u8, [*c]uint) ?*struct_inode;
pub extern fn ialloc(uint, c_short) ?*struct_inode;
pub extern fn idup(?*struct_inode) ?*struct_inode;
pub extern fn iinit(...) void;
pub extern fn ilock(?*struct_inode) void;
pub extern fn iput(?*struct_inode) void;
pub extern fn iunlock(?*struct_inode) void;
pub extern fn iunlockput(?*struct_inode) void;
pub extern fn iupdate(?*struct_inode) void;
pub extern fn namecmp([*c]const u8, [*c]const u8) c_int;
pub extern fn namei([*c]u8) ?*struct_inode;
pub extern fn nameiparent([*c]u8, [*c]u8) ?*struct_inode;
pub extern fn readi(?*struct_inode, c_int, uint64, uint, uint) c_int;
pub extern fn stati(?*struct_inode, ?*struct_stat) void;
pub extern fn writei(?*struct_inode, c_int, uint64, uint, uint) c_int;
pub extern fn itrunc(?*struct_inode) void;
pub extern fn ramdiskinit() void;
pub extern fn ramdiskintr() void;
pub extern fn ramdiskrw(?*struct_buf) void;
pub const struct_run = extern struct {
    next: [*c]struct_run,
};
pub export fn kalloc() ?*anyopaque {
    var r: [*c]struct_run = undefined;
    acquire(&kmem.lock);
    r = kmem.freelist;
    if (r != null) {
        kmem.freelist = r.*.next;
    }
    release(&kmem.lock);
    if (r != null) {
        _ = memset(@ptrCast(?*anyopaque, @ptrCast([*c]u8, @alignCast(@import("std").meta.alignment([*c]u8), r))), @as(c_int, 5), @bitCast(uint, @as(c_int, 4096)));
    }
    return @ptrCast(?*anyopaque, r);
}
pub export fn kfree(arg_pa: ?*anyopaque) void {
    var pa = arg_pa;
    var r: [*c]struct_run = undefined;
    if ((((@intCast(uint64, @ptrToInt(pa)) % @bitCast(c_ulong, @as(c_long, @as(c_int, 4096)))) != @bitCast(c_ulong, @as(c_long, @as(c_int, 0)))) or (@ptrCast([*c]u8, @alignCast(@import("std").meta.alignment([*c]u8), pa)) < @ptrCast([*c]u8, @alignCast(@import("std").meta.alignment([*c]u8), &end)))) or (@intCast(uint64, @ptrToInt(pa)) >= @bitCast(c_ulong, @as(c_long, 2147483648) + @bitCast(c_long, @as(c_long, (@as(c_int, 128) * @as(c_int, 1024)) * @as(c_int, 1024)))))) {
        panic(@intToPtr([*c]u8, @ptrToInt("kfree")));
    }
    _ = memset(pa, @as(c_int, 1), @bitCast(uint, @as(c_int, 4096)));
    r = @ptrCast([*c]struct_run, @alignCast(@import("std").meta.alignment([*c]struct_run), pa));
    acquire(&kmem.lock);
    r.*.next = kmem.freelist;
    kmem.freelist = r;
    release(&kmem.lock);
}
pub export fn kinit() void {
    initlock(&kmem.lock, @intToPtr([*c]u8, @ptrToInt("kmem")));
    freerange(@ptrCast(?*anyopaque, @ptrCast([*c]u8, @alignCast(@import("std").meta.alignment([*c]u8), &end))), @intToPtr(?*anyopaque, @as(c_long, 2147483648) + @bitCast(c_long, @as(c_long, (@as(c_int, 128) * @as(c_int, 1024)) * @as(c_int, 1024)))));
}
pub extern fn initlog(c_int, ?*struct_superblock) void;
pub extern fn log_write(?*struct_buf) void;
pub extern fn begin_op() void;
pub extern fn end_op() void;
pub extern fn pipealloc([*c]?*struct_file, [*c]?*struct_file) c_int;
pub extern fn pipeclose(?*struct_pipe, c_int) void;
pub extern fn piperead(?*struct_pipe, uint64, c_int) c_int;
pub extern fn pipewrite(?*struct_pipe, uint64, c_int) c_int;
pub extern fn printf([*c]u8, ...) void;
pub extern fn panic([*c]u8) noreturn;
pub extern fn printfinit() void;
pub extern fn cpuid() c_int;
pub extern fn exit(c_int) noreturn;
pub extern fn fork() c_int;
pub extern fn growproc(c_int) c_int;
pub extern fn proc_mapstacks(pagetable_t) void;
pub extern fn proc_pagetable(?*struct_proc) pagetable_t;
pub extern fn proc_freepagetable(pagetable_t, uint64) void;
pub extern fn kill(c_int) c_int;
pub extern fn killed(?*struct_proc) c_int;
pub extern fn setkilled(?*struct_proc) void;
pub extern fn mycpu() ?*struct_cpu;
pub extern fn getmycpu() ?*struct_cpu;
pub extern fn myproc(...) ?*struct_proc;
pub extern fn procinit() void;
pub extern fn scheduler() noreturn;
pub extern fn sched() void;
pub extern fn sleep(?*anyopaque, [*c]struct_spinlock) void;
pub extern fn userinit() void;
pub extern fn wait(uint64) c_int;
pub extern fn wakeup(?*anyopaque) void;
pub extern fn yield() void;
pub extern fn either_copyout(user_dst: c_int, dst: uint64, src: ?*anyopaque, len: uint64) c_int;
pub extern fn either_copyin(dst: ?*anyopaque, user_src: c_int, src: uint64, len: uint64) c_int;
pub extern fn procdump() void;
pub extern fn swtch(?*struct_context, ?*struct_context) void;
pub extern fn acquire([*c]struct_spinlock) void;
pub extern fn holding([*c]struct_spinlock) c_int;
pub extern fn initlock([*c]struct_spinlock, [*c]u8) void;
pub extern fn release([*c]struct_spinlock) void;
pub extern fn push_off() void;
pub extern fn pop_off() void;
pub extern fn acquiresleep(?*struct_sleeplock) void;
pub extern fn releasesleep(?*struct_sleeplock) void;
pub extern fn holdingsleep(?*struct_sleeplock) c_int;
pub extern fn initsleeplock(?*struct_sleeplock, [*c]u8) void;
pub extern fn memcmp(?*const anyopaque, ?*const anyopaque, uint) c_int;
pub extern fn memmove(?*anyopaque, ?*const anyopaque, uint) ?*anyopaque;
pub extern fn memset(?*anyopaque, c_int, uint) ?*anyopaque;
pub extern fn safestrcpy([*c]u8, [*c]const u8, c_int) [*c]u8;
pub extern fn strlen([*c]const u8) c_int;
pub extern fn strncmp([*c]const u8, [*c]const u8, uint) c_int;
pub extern fn strncpy([*c]u8, [*c]const u8, c_int) [*c]u8;
pub extern fn argint(c_int, [*c]c_int) void;
pub extern fn argstr(c_int, [*c]u8, c_int) c_int;
pub extern fn argaddr(c_int, [*c]uint64) void;
pub extern fn fetchstr(uint64, [*c]u8, c_int) c_int;
pub extern fn fetchaddr(uint64, [*c]uint64) c_int;
pub extern fn syscall(...) void;
pub extern var ticks: uint;
pub extern fn trapinit() void;
pub extern fn trapinithart() void;
pub extern var tickslock: struct_spinlock;
pub extern fn usertrapret() void;
pub extern fn uartinit() void;
pub extern fn uartintr() void;
pub extern fn uartputc(c_int) void;
pub extern fn uartputc_sync(c_int) void;
pub extern fn uartgetc() c_int;
pub extern fn kvminit() void;
pub extern fn kvminithart() void;
pub extern fn kvmmap(pagetable_t, uint64, uint64, uint64, c_int) void;
pub extern fn mappages(pagetable_t, uint64, uint64, uint64, c_int) c_int;
pub extern fn uvmcreate() pagetable_t;
pub extern fn uvmfirst(pagetable_t, [*c]uchar, uint) void;
pub extern fn uvmalloc(pagetable_t, uint64, uint64, c_int) uint64;
pub extern fn uvmdealloc(pagetable_t, uint64, uint64) uint64;
pub extern fn uvmcopy(pagetable_t, pagetable_t, uint64) c_int;
pub extern fn uvmfree(pagetable_t, uint64) void;
pub extern fn uvmunmap(pagetable_t, uint64, uint64, c_int) void;
pub extern fn uvmclear(pagetable_t, uint64) void;
pub extern fn walk(pagetable_t, uint64, c_int) [*c]pte_t;
pub extern fn walkaddr(pagetable_t, uint64) uint64;
pub extern fn copyout(pagetable_t, uint64, [*c]u8, uint64) c_int;
pub extern fn copyin(pagetable_t, [*c]u8, uint64, uint64) c_int;
pub extern fn copyinstr(pagetable_t, [*c]u8, uint64, uint64) c_int;
pub extern fn plicinit() void;
pub extern fn plicinithart() void;
pub extern fn plic_claim() c_int;
pub extern fn plic_complete(c_int) void;
pub extern fn virtio_disk_init() void;
pub extern fn virtio_disk_rw(?*struct_buf, c_int) void;
pub extern fn virtio_disk_intr() void;
pub export fn freerange(arg_pa_start: ?*anyopaque, arg_pa_end: ?*anyopaque) void {
    var pa_start = arg_pa_start;
    var pa_end = arg_pa_end;
    var p: [*c]u8 = undefined;
    p = @intToPtr([*c]u8, ((@intCast(uint64, @ptrToInt(pa_start)) +% @bitCast(c_ulong, @as(c_long, @as(c_int, 4096)))) -% @bitCast(c_ulong, @as(c_long, @as(c_int, 1)))) & @bitCast(c_ulong, @as(c_long, ~(@as(c_int, 4096) - @as(c_int, 1)))));
    while ((p + @bitCast(usize, @intCast(isize, @as(c_int, 4096)))) <= @ptrCast([*c]u8, @alignCast(@import("std").meta.alignment([*c]u8), pa_end))) : (p += @bitCast(usize, @intCast(isize, @as(c_int, 4096)))) {
        kfree(@ptrCast(?*anyopaque, p));
    }
}
pub extern var end: [*c]u8;
const struct_unnamed_1 = extern struct {
    lock: struct_spinlock,
    freelist: [*c]struct_run,
};
pub export var kmem: struct_unnamed_1 = @import("std").mem.zeroes(struct_unnamed_1);
pub const __INTMAX_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `L`"); // (no file):80:9
pub const __UINTMAX_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `UL`"); // (no file):86:9
pub const __FLT16_DENORM_MIN__ = @compileError("unable to translate C expr: unexpected token 'IntegerLiteral'"); // (no file):109:9
pub const __FLT16_EPSILON__ = @compileError("unable to translate C expr: unexpected token 'IntegerLiteral'"); // (no file):113:9
pub const __FLT16_MAX__ = @compileError("unable to translate C expr: unexpected token 'IntegerLiteral'"); // (no file):119:9
pub const __FLT16_MIN__ = @compileError("unable to translate C expr: unexpected token 'IntegerLiteral'"); // (no file):122:9
pub const __INT64_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `L`"); // (no file):183:9
pub const __UINT32_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `U`"); // (no file):205:9
pub const __UINT64_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `UL`"); // (no file):213:9
pub const __seg_gs = @compileError("unable to translate macro: undefined identifier `__attribute__`"); // (no file):343:9
pub const __seg_fs = @compileError("unable to translate macro: undefined identifier `__attribute__`"); // (no file):344:9
pub const NELEM = @compileError("unable to translate C expr: unexpected token '('"); // kernel/defs.h:189:9
pub const __llvm__ = @as(c_int, 1);
pub const __clang__ = @as(c_int, 1);
pub const __clang_major__ = @as(c_int, 15);
pub const __clang_minor__ = @as(c_int, 0);
pub const __clang_patchlevel__ = @as(c_int, 7);
pub const __clang_version__ = "15.0.7 (https://github.com/ziglang/zig-bootstrap 8aa969bd1ad4704a6f351db54aac7ca11de73a9d)";
pub const __GNUC__ = @as(c_int, 4);
pub const __GNUC_MINOR__ = @as(c_int, 2);
pub const __GNUC_PATCHLEVEL__ = @as(c_int, 1);
pub const __GXX_ABI_VERSION = @as(c_int, 1002);
pub const __ATOMIC_RELAXED = @as(c_int, 0);
pub const __ATOMIC_CONSUME = @as(c_int, 1);
pub const __ATOMIC_ACQUIRE = @as(c_int, 2);
pub const __ATOMIC_RELEASE = @as(c_int, 3);
pub const __ATOMIC_ACQ_REL = @as(c_int, 4);
pub const __ATOMIC_SEQ_CST = @as(c_int, 5);
pub const __OPENCL_MEMORY_SCOPE_WORK_ITEM = @as(c_int, 0);
pub const __OPENCL_MEMORY_SCOPE_WORK_GROUP = @as(c_int, 1);
pub const __OPENCL_MEMORY_SCOPE_DEVICE = @as(c_int, 2);
pub const __OPENCL_MEMORY_SCOPE_ALL_SVM_DEVICES = @as(c_int, 3);
pub const __OPENCL_MEMORY_SCOPE_SUB_GROUP = @as(c_int, 4);
pub const __PRAGMA_REDEFINE_EXTNAME = @as(c_int, 1);
pub const __VERSION__ = "Clang 15.0.7 (https://github.com/ziglang/zig-bootstrap 8aa969bd1ad4704a6f351db54aac7ca11de73a9d)";
pub const __OBJC_BOOL_IS_BOOL = @as(c_int, 0);
pub const __CONSTANT_CFSTRINGS__ = @as(c_int, 1);
pub const __clang_literal_encoding__ = "UTF-8";
pub const __clang_wide_literal_encoding__ = "UTF-32";
pub const __ORDER_LITTLE_ENDIAN__ = @as(c_int, 1234);
pub const __ORDER_BIG_ENDIAN__ = @as(c_int, 4321);
pub const __ORDER_PDP_ENDIAN__ = @as(c_int, 3412);
pub const __BYTE_ORDER__ = __ORDER_LITTLE_ENDIAN__;
pub const __LITTLE_ENDIAN__ = @as(c_int, 1);
pub const _LP64 = @as(c_int, 1);
pub const __LP64__ = @as(c_int, 1);
pub const __CHAR_BIT__ = @as(c_int, 8);
pub const __BOOL_WIDTH__ = @as(c_int, 8);
pub const __SHRT_WIDTH__ = @as(c_int, 16);
pub const __INT_WIDTH__ = @as(c_int, 32);
pub const __LONG_WIDTH__ = @as(c_int, 64);
pub const __LLONG_WIDTH__ = @as(c_int, 64);
pub const __BITINT_MAXWIDTH__ = @as(c_int, 128);
pub const __SCHAR_MAX__ = @as(c_int, 127);
pub const __SHRT_MAX__ = @as(c_int, 32767);
pub const __INT_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __LONG_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __LONG_LONG_MAX__ = @as(c_longlong, 9223372036854775807);
pub const __WCHAR_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __WCHAR_WIDTH__ = @as(c_int, 32);
pub const __WINT_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __WINT_WIDTH__ = @as(c_int, 32);
pub const __INTMAX_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INTMAX_WIDTH__ = @as(c_int, 64);
pub const __SIZE_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __SIZE_WIDTH__ = @as(c_int, 64);
pub const __UINTMAX_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __UINTMAX_WIDTH__ = @as(c_int, 64);
pub const __PTRDIFF_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __PTRDIFF_WIDTH__ = @as(c_int, 64);
pub const __INTPTR_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INTPTR_WIDTH__ = @as(c_int, 64);
pub const __UINTPTR_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __UINTPTR_WIDTH__ = @as(c_int, 64);
pub const __SIZEOF_DOUBLE__ = @as(c_int, 8);
pub const __SIZEOF_FLOAT__ = @as(c_int, 4);
pub const __SIZEOF_INT__ = @as(c_int, 4);
pub const __SIZEOF_LONG__ = @as(c_int, 8);
pub const __SIZEOF_LONG_DOUBLE__ = @as(c_int, 16);
pub const __SIZEOF_LONG_LONG__ = @as(c_int, 8);
pub const __SIZEOF_POINTER__ = @as(c_int, 8);
pub const __SIZEOF_SHORT__ = @as(c_int, 2);
pub const __SIZEOF_PTRDIFF_T__ = @as(c_int, 8);
pub const __SIZEOF_SIZE_T__ = @as(c_int, 8);
pub const __SIZEOF_WCHAR_T__ = @as(c_int, 4);
pub const __SIZEOF_WINT_T__ = @as(c_int, 4);
pub const __SIZEOF_INT128__ = @as(c_int, 16);
pub const __INTMAX_TYPE__ = c_long;
pub const __INTMAX_FMTd__ = "ld";
pub const __INTMAX_FMTi__ = "li";
pub const __UINTMAX_TYPE__ = c_ulong;
pub const __UINTMAX_FMTo__ = "lo";
pub const __UINTMAX_FMTu__ = "lu";
pub const __UINTMAX_FMTx__ = "lx";
pub const __UINTMAX_FMTX__ = "lX";
pub const __PTRDIFF_TYPE__ = c_long;
pub const __PTRDIFF_FMTd__ = "ld";
pub const __PTRDIFF_FMTi__ = "li";
pub const __INTPTR_TYPE__ = c_long;
pub const __INTPTR_FMTd__ = "ld";
pub const __INTPTR_FMTi__ = "li";
pub const __SIZE_TYPE__ = c_ulong;
pub const __SIZE_FMTo__ = "lo";
pub const __SIZE_FMTu__ = "lu";
pub const __SIZE_FMTx__ = "lx";
pub const __SIZE_FMTX__ = "lX";
pub const __WCHAR_TYPE__ = c_int;
pub const __WINT_TYPE__ = c_uint;
pub const __SIG_ATOMIC_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __SIG_ATOMIC_WIDTH__ = @as(c_int, 32);
pub const __CHAR16_TYPE__ = c_ushort;
pub const __CHAR32_TYPE__ = c_uint;
pub const __UINTPTR_TYPE__ = c_ulong;
pub const __UINTPTR_FMTo__ = "lo";
pub const __UINTPTR_FMTu__ = "lu";
pub const __UINTPTR_FMTx__ = "lx";
pub const __UINTPTR_FMTX__ = "lX";
pub const __FLT16_HAS_DENORM__ = @as(c_int, 1);
pub const __FLT16_DIG__ = @as(c_int, 3);
pub const __FLT16_DECIMAL_DIG__ = @as(c_int, 5);
pub const __FLT16_HAS_INFINITY__ = @as(c_int, 1);
pub const __FLT16_HAS_QUIET_NAN__ = @as(c_int, 1);
pub const __FLT16_MANT_DIG__ = @as(c_int, 11);
pub const __FLT16_MAX_10_EXP__ = @as(c_int, 4);
pub const __FLT16_MAX_EXP__ = @as(c_int, 16);
pub const __FLT16_MIN_10_EXP__ = -@as(c_int, 4);
pub const __FLT16_MIN_EXP__ = -@as(c_int, 13);
pub const __FLT_DENORM_MIN__ = @as(f32, 1.40129846e-45);
pub const __FLT_HAS_DENORM__ = @as(c_int, 1);
pub const __FLT_DIG__ = @as(c_int, 6);
pub const __FLT_DECIMAL_DIG__ = @as(c_int, 9);
pub const __FLT_EPSILON__ = @as(f32, 1.19209290e-7);
pub const __FLT_HAS_INFINITY__ = @as(c_int, 1);
pub const __FLT_HAS_QUIET_NAN__ = @as(c_int, 1);
pub const __FLT_MANT_DIG__ = @as(c_int, 24);
pub const __FLT_MAX_10_EXP__ = @as(c_int, 38);
pub const __FLT_MAX_EXP__ = @as(c_int, 128);
pub const __FLT_MAX__ = @as(f32, 3.40282347e+38);
pub const __FLT_MIN_10_EXP__ = -@as(c_int, 37);
pub const __FLT_MIN_EXP__ = -@as(c_int, 125);
pub const __FLT_MIN__ = @as(f32, 1.17549435e-38);
pub const __DBL_DENORM_MIN__ = @as(f64, 4.9406564584124654e-324);
pub const __DBL_HAS_DENORM__ = @as(c_int, 1);
pub const __DBL_DIG__ = @as(c_int, 15);
pub const __DBL_DECIMAL_DIG__ = @as(c_int, 17);
pub const __DBL_EPSILON__ = @as(f64, 2.2204460492503131e-16);
pub const __DBL_HAS_INFINITY__ = @as(c_int, 1);
pub const __DBL_HAS_QUIET_NAN__ = @as(c_int, 1);
pub const __DBL_MANT_DIG__ = @as(c_int, 53);
pub const __DBL_MAX_10_EXP__ = @as(c_int, 308);
pub const __DBL_MAX_EXP__ = @as(c_int, 1024);
pub const __DBL_MAX__ = @as(f64, 1.7976931348623157e+308);
pub const __DBL_MIN_10_EXP__ = -@as(c_int, 307);
pub const __DBL_MIN_EXP__ = -@as(c_int, 1021);
pub const __DBL_MIN__ = @as(f64, 2.2250738585072014e-308);
pub const __LDBL_DENORM_MIN__ = @as(c_longdouble, 3.64519953188247460253e-4951);
pub const __LDBL_HAS_DENORM__ = @as(c_int, 1);
pub const __LDBL_DIG__ = @as(c_int, 18);
pub const __LDBL_DECIMAL_DIG__ = @as(c_int, 21);
pub const __LDBL_EPSILON__ = @as(c_longdouble, 1.08420217248550443401e-19);
pub const __LDBL_HAS_INFINITY__ = @as(c_int, 1);
pub const __LDBL_HAS_QUIET_NAN__ = @as(c_int, 1);
pub const __LDBL_MANT_DIG__ = @as(c_int, 64);
pub const __LDBL_MAX_10_EXP__ = @as(c_int, 4932);
pub const __LDBL_MAX_EXP__ = @as(c_int, 16384);
pub const __LDBL_MAX__ = @as(c_longdouble, 1.18973149535723176502e+4932);
pub const __LDBL_MIN_10_EXP__ = -@as(c_int, 4931);
pub const __LDBL_MIN_EXP__ = -@as(c_int, 16381);
pub const __LDBL_MIN__ = @as(c_longdouble, 3.36210314311209350626e-4932);
pub const __POINTER_WIDTH__ = @as(c_int, 64);
pub const __BIGGEST_ALIGNMENT__ = @as(c_int, 16);
pub const __WINT_UNSIGNED__ = @as(c_int, 1);
pub const __INT8_TYPE__ = i8;
pub const __INT8_FMTd__ = "hhd";
pub const __INT8_FMTi__ = "hhi";
pub const __INT8_C_SUFFIX__ = "";
pub const __INT16_TYPE__ = c_short;
pub const __INT16_FMTd__ = "hd";
pub const __INT16_FMTi__ = "hi";
pub const __INT16_C_SUFFIX__ = "";
pub const __INT32_TYPE__ = c_int;
pub const __INT32_FMTd__ = "d";
pub const __INT32_FMTi__ = "i";
pub const __INT32_C_SUFFIX__ = "";
pub const __INT64_TYPE__ = c_long;
pub const __INT64_FMTd__ = "ld";
pub const __INT64_FMTi__ = "li";
pub const __UINT8_TYPE__ = u8;
pub const __UINT8_FMTo__ = "hho";
pub const __UINT8_FMTu__ = "hhu";
pub const __UINT8_FMTx__ = "hhx";
pub const __UINT8_FMTX__ = "hhX";
pub const __UINT8_C_SUFFIX__ = "";
pub const __UINT8_MAX__ = @as(c_int, 255);
pub const __INT8_MAX__ = @as(c_int, 127);
pub const __UINT16_TYPE__ = c_ushort;
pub const __UINT16_FMTo__ = "ho";
pub const __UINT16_FMTu__ = "hu";
pub const __UINT16_FMTx__ = "hx";
pub const __UINT16_FMTX__ = "hX";
pub const __UINT16_C_SUFFIX__ = "";
pub const __UINT16_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const __INT16_MAX__ = @as(c_int, 32767);
pub const __UINT32_TYPE__ = c_uint;
pub const __UINT32_FMTo__ = "o";
pub const __UINT32_FMTu__ = "u";
pub const __UINT32_FMTx__ = "x";
pub const __UINT32_FMTX__ = "X";
pub const __UINT32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __INT32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __UINT64_TYPE__ = c_ulong;
pub const __UINT64_FMTo__ = "lo";
pub const __UINT64_FMTu__ = "lu";
pub const __UINT64_FMTx__ = "lx";
pub const __UINT64_FMTX__ = "lX";
pub const __UINT64_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __INT64_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INT_LEAST8_TYPE__ = i8;
pub const __INT_LEAST8_MAX__ = @as(c_int, 127);
pub const __INT_LEAST8_WIDTH__ = @as(c_int, 8);
pub const __INT_LEAST8_FMTd__ = "hhd";
pub const __INT_LEAST8_FMTi__ = "hhi";
pub const __UINT_LEAST8_TYPE__ = u8;
pub const __UINT_LEAST8_MAX__ = @as(c_int, 255);
pub const __UINT_LEAST8_FMTo__ = "hho";
pub const __UINT_LEAST8_FMTu__ = "hhu";
pub const __UINT_LEAST8_FMTx__ = "hhx";
pub const __UINT_LEAST8_FMTX__ = "hhX";
pub const __INT_LEAST16_TYPE__ = c_short;
pub const __INT_LEAST16_MAX__ = @as(c_int, 32767);
pub const __INT_LEAST16_WIDTH__ = @as(c_int, 16);
pub const __INT_LEAST16_FMTd__ = "hd";
pub const __INT_LEAST16_FMTi__ = "hi";
pub const __UINT_LEAST16_TYPE__ = c_ushort;
pub const __UINT_LEAST16_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const __UINT_LEAST16_FMTo__ = "ho";
pub const __UINT_LEAST16_FMTu__ = "hu";
pub const __UINT_LEAST16_FMTx__ = "hx";
pub const __UINT_LEAST16_FMTX__ = "hX";
pub const __INT_LEAST32_TYPE__ = c_int;
pub const __INT_LEAST32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_LEAST32_WIDTH__ = @as(c_int, 32);
pub const __INT_LEAST32_FMTd__ = "d";
pub const __INT_LEAST32_FMTi__ = "i";
pub const __UINT_LEAST32_TYPE__ = c_uint;
pub const __UINT_LEAST32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __UINT_LEAST32_FMTo__ = "o";
pub const __UINT_LEAST32_FMTu__ = "u";
pub const __UINT_LEAST32_FMTx__ = "x";
pub const __UINT_LEAST32_FMTX__ = "X";
pub const __INT_LEAST64_TYPE__ = c_long;
pub const __INT_LEAST64_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INT_LEAST64_WIDTH__ = @as(c_int, 64);
pub const __INT_LEAST64_FMTd__ = "ld";
pub const __INT_LEAST64_FMTi__ = "li";
pub const __UINT_LEAST64_TYPE__ = c_ulong;
pub const __UINT_LEAST64_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __UINT_LEAST64_FMTo__ = "lo";
pub const __UINT_LEAST64_FMTu__ = "lu";
pub const __UINT_LEAST64_FMTx__ = "lx";
pub const __UINT_LEAST64_FMTX__ = "lX";
pub const __INT_FAST8_TYPE__ = i8;
pub const __INT_FAST8_MAX__ = @as(c_int, 127);
pub const __INT_FAST8_WIDTH__ = @as(c_int, 8);
pub const __INT_FAST8_FMTd__ = "hhd";
pub const __INT_FAST8_FMTi__ = "hhi";
pub const __UINT_FAST8_TYPE__ = u8;
pub const __UINT_FAST8_MAX__ = @as(c_int, 255);
pub const __UINT_FAST8_FMTo__ = "hho";
pub const __UINT_FAST8_FMTu__ = "hhu";
pub const __UINT_FAST8_FMTx__ = "hhx";
pub const __UINT_FAST8_FMTX__ = "hhX";
pub const __INT_FAST16_TYPE__ = c_short;
pub const __INT_FAST16_MAX__ = @as(c_int, 32767);
pub const __INT_FAST16_WIDTH__ = @as(c_int, 16);
pub const __INT_FAST16_FMTd__ = "hd";
pub const __INT_FAST16_FMTi__ = "hi";
pub const __UINT_FAST16_TYPE__ = c_ushort;
pub const __UINT_FAST16_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const __UINT_FAST16_FMTo__ = "ho";
pub const __UINT_FAST16_FMTu__ = "hu";
pub const __UINT_FAST16_FMTx__ = "hx";
pub const __UINT_FAST16_FMTX__ = "hX";
pub const __INT_FAST32_TYPE__ = c_int;
pub const __INT_FAST32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_FAST32_WIDTH__ = @as(c_int, 32);
pub const __INT_FAST32_FMTd__ = "d";
pub const __INT_FAST32_FMTi__ = "i";
pub const __UINT_FAST32_TYPE__ = c_uint;
pub const __UINT_FAST32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __UINT_FAST32_FMTo__ = "o";
pub const __UINT_FAST32_FMTu__ = "u";
pub const __UINT_FAST32_FMTx__ = "x";
pub const __UINT_FAST32_FMTX__ = "X";
pub const __INT_FAST64_TYPE__ = c_long;
pub const __INT_FAST64_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INT_FAST64_WIDTH__ = @as(c_int, 64);
pub const __INT_FAST64_FMTd__ = "ld";
pub const __INT_FAST64_FMTi__ = "li";
pub const __UINT_FAST64_TYPE__ = c_ulong;
pub const __UINT_FAST64_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __UINT_FAST64_FMTo__ = "lo";
pub const __UINT_FAST64_FMTu__ = "lu";
pub const __UINT_FAST64_FMTx__ = "lx";
pub const __UINT_FAST64_FMTX__ = "lX";
pub const __USER_LABEL_PREFIX__ = "";
pub const __FINITE_MATH_ONLY__ = @as(c_int, 0);
pub const __GNUC_STDC_INLINE__ = @as(c_int, 1);
pub const __GCC_ATOMIC_TEST_AND_SET_TRUEVAL = @as(c_int, 1);
pub const __CLANG_ATOMIC_BOOL_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_CHAR_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_CHAR16_T_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_CHAR32_T_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_WCHAR_T_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_SHORT_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_INT_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_LONG_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_LLONG_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_POINTER_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_BOOL_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_CHAR_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_CHAR16_T_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_CHAR32_T_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_WCHAR_T_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_SHORT_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_INT_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_LONG_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_LLONG_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_POINTER_LOCK_FREE = @as(c_int, 2);
pub const __NO_INLINE__ = @as(c_int, 1);
pub const __PIC__ = @as(c_int, 2);
pub const __pic__ = @as(c_int, 2);
pub const __PIE__ = @as(c_int, 2);
pub const __pie__ = @as(c_int, 2);
pub const __FLT_RADIX__ = @as(c_int, 2);
pub const __DECIMAL_DIG__ = __LDBL_DECIMAL_DIG__;
pub const __GCC_ASM_FLAG_OUTPUTS__ = @as(c_int, 1);
pub const __code_model_small__ = @as(c_int, 1);
pub const __amd64__ = @as(c_int, 1);
pub const __amd64 = @as(c_int, 1);
pub const __x86_64 = @as(c_int, 1);
pub const __x86_64__ = @as(c_int, 1);
pub const __SEG_GS = @as(c_int, 1);
pub const __SEG_FS = @as(c_int, 1);
pub const __k8 = @as(c_int, 1);
pub const __k8__ = @as(c_int, 1);
pub const __tune_k8__ = @as(c_int, 1);
pub const __REGISTER_PREFIX__ = "";
pub const __NO_MATH_INLINES = @as(c_int, 1);
pub const __AES__ = @as(c_int, 1);
pub const __VAES__ = @as(c_int, 1);
pub const __PCLMUL__ = @as(c_int, 1);
pub const __VPCLMULQDQ__ = @as(c_int, 1);
pub const __LAHF_SAHF__ = @as(c_int, 1);
pub const __LZCNT__ = @as(c_int, 1);
pub const __RDRND__ = @as(c_int, 1);
pub const __FSGSBASE__ = @as(c_int, 1);
pub const __BMI__ = @as(c_int, 1);
pub const __BMI2__ = @as(c_int, 1);
pub const __POPCNT__ = @as(c_int, 1);
pub const __PRFCHW__ = @as(c_int, 1);
pub const __RDSEED__ = @as(c_int, 1);
pub const __ADX__ = @as(c_int, 1);
pub const __MOVBE__ = @as(c_int, 1);
pub const __FMA__ = @as(c_int, 1);
pub const __F16C__ = @as(c_int, 1);
pub const __GFNI__ = @as(c_int, 1);
pub const __AVX512CD__ = @as(c_int, 1);
pub const __AVX512VPOPCNTDQ__ = @as(c_int, 1);
pub const __AVX512VNNI__ = @as(c_int, 1);
pub const __AVX512DQ__ = @as(c_int, 1);
pub const __AVX512BITALG__ = @as(c_int, 1);
pub const __AVX512BW__ = @as(c_int, 1);
pub const __AVX512VL__ = @as(c_int, 1);
pub const __AVX512VBMI__ = @as(c_int, 1);
pub const __AVX512VBMI2__ = @as(c_int, 1);
pub const __AVX512IFMA__ = @as(c_int, 1);
pub const __AVX512VP2INTERSECT__ = @as(c_int, 1);
pub const __SHA__ = @as(c_int, 1);
pub const __FXSR__ = @as(c_int, 1);
pub const __XSAVE__ = @as(c_int, 1);
pub const __XSAVEOPT__ = @as(c_int, 1);
pub const __XSAVEC__ = @as(c_int, 1);
pub const __XSAVES__ = @as(c_int, 1);
pub const __CLFLUSHOPT__ = @as(c_int, 1);
pub const __CLWB__ = @as(c_int, 1);
pub const __RDPID__ = @as(c_int, 1);
pub const __INVPCID__ = @as(c_int, 1);
pub const __AVX512F__ = @as(c_int, 1);
pub const __AVX2__ = @as(c_int, 1);
pub const __AVX__ = @as(c_int, 1);
pub const __SSE4_2__ = @as(c_int, 1);
pub const __SSE4_1__ = @as(c_int, 1);
pub const __SSSE3__ = @as(c_int, 1);
pub const __SSE3__ = @as(c_int, 1);
pub const __SSE2__ = @as(c_int, 1);
pub const __SSE2_MATH__ = @as(c_int, 1);
pub const __SSE__ = @as(c_int, 1);
pub const __SSE_MATH__ = @as(c_int, 1);
pub const __MMX__ = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_1 = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_2 = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_4 = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_8 = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_16 = @as(c_int, 1);
pub const __SIZEOF_FLOAT128__ = @as(c_int, 16);
pub const unix = @as(c_int, 1);
pub const __unix = @as(c_int, 1);
pub const __unix__ = @as(c_int, 1);
pub const linux = @as(c_int, 1);
pub const __linux = @as(c_int, 1);
pub const __linux__ = @as(c_int, 1);
pub const __ELF__ = @as(c_int, 1);
pub const __gnu_linux__ = @as(c_int, 1);
pub const __FLOAT128__ = @as(c_int, 1);
pub const __STDC__ = @as(c_int, 1);
pub const __STDC_HOSTED__ = @as(c_int, 1);
pub const __STDC_VERSION__ = @as(c_long, 201710);
pub const __STDC_UTF_16__ = @as(c_int, 1);
pub const __STDC_UTF_32__ = @as(c_int, 1);
pub const _DEBUG = @as(c_int, 1);
pub const __GCC_HAVE_DWARF2_CFI_ASM = @as(c_int, 1);
pub const NPROC = @as(c_int, 64);
pub const NCPU = @as(c_int, 8);
pub const NOFILE = @as(c_int, 16);
pub const NFILE = @as(c_int, 100);
pub const NINODE = @as(c_int, 50);
pub const NDEV = @as(c_int, 10);
pub const ROOTDEV = @as(c_int, 1);
pub const MAXARG = @as(c_int, 32);
pub const MAXOPBLOCKS = @as(c_int, 10);
pub const LOGSIZE = MAXOPBLOCKS * @as(c_int, 3);
pub const NBUF = MAXOPBLOCKS * @as(c_int, 3);
pub const FSSIZE = @as(c_int, 2000);
pub const MAXPATH = @as(c_int, 128);
pub const UART0 = @as(c_long, 0x10000000);
pub const UART0_IRQ = @as(c_int, 10);
pub const VIRTIO0 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x10001000, .hexadecimal);
pub const VIRTIO0_IRQ = @as(c_int, 1);
pub const CLINT = @as(c_long, 0x2000000);
pub inline fn CLINT_MTIMECMP(hartid: anytype) @TypeOf((CLINT + @as(c_int, 0x4000)) + (@as(c_int, 8) * hartid)) {
    return (CLINT + @as(c_int, 0x4000)) + (@as(c_int, 8) * hartid);
}
pub const CLINT_MTIME = CLINT + @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xBFF8, .hexadecimal);
pub const PLIC = @as(c_long, 0x0c000000);
pub const PLIC_PRIORITY = PLIC + @as(c_int, 0x0);
pub const PLIC_PENDING = PLIC + @as(c_int, 0x1000);
pub inline fn PLIC_MENABLE(hart: anytype) @TypeOf((PLIC + @as(c_int, 0x2000)) + (hart * @as(c_int, 0x100))) {
    return (PLIC + @as(c_int, 0x2000)) + (hart * @as(c_int, 0x100));
}
pub inline fn PLIC_SENABLE(hart: anytype) @TypeOf((PLIC + @as(c_int, 0x2080)) + (hart * @as(c_int, 0x100))) {
    return (PLIC + @as(c_int, 0x2080)) + (hart * @as(c_int, 0x100));
}
pub inline fn PLIC_MPRIORITY(hart: anytype) @TypeOf((PLIC + @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x200000, .hexadecimal)) + (hart * @as(c_int, 0x2000))) {
    return (PLIC + @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x200000, .hexadecimal)) + (hart * @as(c_int, 0x2000));
}
pub inline fn PLIC_SPRIORITY(hart: anytype) @TypeOf((PLIC + @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x201000, .hexadecimal)) + (hart * @as(c_int, 0x2000))) {
    return (PLIC + @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x201000, .hexadecimal)) + (hart * @as(c_int, 0x2000));
}
pub inline fn PLIC_MCLAIM(hart: anytype) @TypeOf((PLIC + @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x200004, .hexadecimal)) + (hart * @as(c_int, 0x2000))) {
    return (PLIC + @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x200004, .hexadecimal)) + (hart * @as(c_int, 0x2000));
}
pub inline fn PLIC_SCLAIM(hart: anytype) @TypeOf((PLIC + @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x201004, .hexadecimal)) + (hart * @as(c_int, 0x2000))) {
    return (PLIC + @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x201004, .hexadecimal)) + (hart * @as(c_int, 0x2000));
}
pub const KERNBASE = @import("std").zig.c_translation.promoteIntLiteral(c_long, 0x80000000, .hexadecimal);
pub const PHYSTOP = KERNBASE + ((@as(c_int, 128) * @as(c_int, 1024)) * @as(c_int, 1024));
pub const TRAMPOLINE = MAXVA - PGSIZE;
pub inline fn KSTACK(p: anytype) @TypeOf(TRAMPOLINE - (((p + @as(c_int, 1)) * @as(c_int, 2)) * PGSIZE)) {
    return TRAMPOLINE - (((p + @as(c_int, 1)) * @as(c_int, 2)) * PGSIZE);
}
pub const TRAPFRAME = TRAMPOLINE - PGSIZE;
pub const MSTATUS_MPP_MASK = @as(c_long, 3) << @as(c_int, 11);
pub const MSTATUS_MPP_M = @as(c_long, 3) << @as(c_int, 11);
pub const MSTATUS_MPP_S = @as(c_long, 1) << @as(c_int, 11);
pub const MSTATUS_MPP_U = @as(c_long, 0) << @as(c_int, 11);
pub const MSTATUS_MIE = @as(c_long, 1) << @as(c_int, 3);
pub const SSTATUS_SPP = @as(c_long, 1) << @as(c_int, 8);
pub const SSTATUS_SPIE = @as(c_long, 1) << @as(c_int, 5);
pub const SSTATUS_UPIE = @as(c_long, 1) << @as(c_int, 4);
pub const SSTATUS_SIE = @as(c_long, 1) << @as(c_int, 1);
pub const SSTATUS_UIE = @as(c_long, 1) << @as(c_int, 0);
pub const SIE_SEIE = @as(c_long, 1) << @as(c_int, 9);
pub const SIE_STIE = @as(c_long, 1) << @as(c_int, 5);
pub const SIE_SSIE = @as(c_long, 1) << @as(c_int, 1);
pub const MIE_MEIE = @as(c_long, 1) << @as(c_int, 11);
pub const MIE_MTIE = @as(c_long, 1) << @as(c_int, 7);
pub const MIE_MSIE = @as(c_long, 1) << @as(c_int, 3);
pub const SATP_SV39 = @as(c_long, 8) << @as(c_int, 60);
pub inline fn MAKE_SATP(pagetable: anytype) @TypeOf(SATP_SV39 | (@import("std").zig.c_translation.cast(uint64, pagetable) >> @as(c_int, 12))) {
    return SATP_SV39 | (@import("std").zig.c_translation.cast(uint64, pagetable) >> @as(c_int, 12));
}
pub const PGSIZE = @as(c_int, 4096);
pub const PGSHIFT = @as(c_int, 12);
pub inline fn PGROUNDUP(sz: anytype) @TypeOf(((sz + PGSIZE) - @as(c_int, 1)) & ~(PGSIZE - @as(c_int, 1))) {
    return ((sz + PGSIZE) - @as(c_int, 1)) & ~(PGSIZE - @as(c_int, 1));
}
pub inline fn PGROUNDDOWN(a: anytype) @TypeOf(a & ~(PGSIZE - @as(c_int, 1))) {
    return a & ~(PGSIZE - @as(c_int, 1));
}
pub const PTE_V = @as(c_long, 1) << @as(c_int, 0);
pub const PTE_R = @as(c_long, 1) << @as(c_int, 1);
pub const PTE_W = @as(c_long, 1) << @as(c_int, 2);
pub const PTE_X = @as(c_long, 1) << @as(c_int, 3);
pub const PTE_U = @as(c_long, 1) << @as(c_int, 4);
pub inline fn PA2PTE(pa: anytype) @TypeOf((@import("std").zig.c_translation.cast(uint64, pa) >> @as(c_int, 12)) << @as(c_int, 10)) {
    return (@import("std").zig.c_translation.cast(uint64, pa) >> @as(c_int, 12)) << @as(c_int, 10);
}
pub inline fn PTE2PA(pte: anytype) @TypeOf((pte >> @as(c_int, 10)) << @as(c_int, 12)) {
    return (pte >> @as(c_int, 10)) << @as(c_int, 12);
}
pub inline fn PTE_FLAGS(pte: anytype) @TypeOf(pte & @as(c_int, 0x3FF)) {
    return pte & @as(c_int, 0x3FF);
}
pub const PXMASK = @as(c_int, 0x1FF);
pub inline fn PXSHIFT(level: anytype) @TypeOf(PGSHIFT + (@as(c_int, 9) * level)) {
    return PGSHIFT + (@as(c_int, 9) * level);
}
pub inline fn PX(level: anytype, va: anytype) @TypeOf((@import("std").zig.c_translation.cast(uint64, va) >> PXSHIFT(level)) & PXMASK) {
    return (@import("std").zig.c_translation.cast(uint64, va) >> PXSHIFT(level)) & PXMASK;
}
pub const MAXVA = @as(c_long, 1) << ((((@as(c_int, 9) + @as(c_int, 9)) + @as(c_int, 9)) + @as(c_int, 12)) - @as(c_int, 1));
pub const cpu = struct_cpu;
pub const spinlock = struct_spinlock;
pub const buf = struct_buf;
pub const context = struct_context;
pub const file = struct_file;
pub const inode = struct_inode;
pub const pipe = struct_pipe;
pub const proc = struct_proc;
pub const sleeplock = struct_sleeplock;
pub const stat = struct_stat;
pub const superblock = struct_superblock;
pub const run = struct_run;
