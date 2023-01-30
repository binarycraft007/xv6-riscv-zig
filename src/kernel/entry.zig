/// qemu -kernel loads the kernel at 0x80000000
/// and causes each hart (i.e. CPU) to jump there.
/// kernel.ld causes the following code to
/// be placed at 0x80000000.
const start = @import("start.zig");
const param = @import("param.zig");

const stack_size: usize = 4096 * param.NCPU;
export fn _entry() callconv(.Naked) noreturn {
    // set up a stack for zig.
    // 4096-byte stack per CPU.
    // sp = stack0 + (hartid * 4096)
    const stack0 align(16) = [_]u8{0} ** stack_size;
    const hardid = asm volatile ("csrr a0, mhartid"
        : [ret] "={a0}" (-> usize),
    );

    const stack = @ptrToInt(&stack0) + (hardid * 4096);
    asm volatile (""
        :
        : [stack] "{sp}" (stack),
    );
    start.start();
    while (true) {}
}
