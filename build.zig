const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const target = std.zig.CrossTarget{
        .os_tag = .freestanding,
        .cpu_arch = .riscv64,
        .abi = .none,
    };

    const kernel_linker = "src/kernel/kernel.ld";

    const kernel = b.addExecutable(.{
        .name = "kernel",
        .root_source_file = .{ .path = "src/kernel/entry.zig" },
        .target = target,
        .optimize = std.builtin.Mode.ReleaseSmall,
    });
    kernel.addAssemblyFile("src/kernel/trampoline.S");
    kernel.setLinkerScriptPath(.{ .path = kernel_linker });
    kernel.code_model = .medium;
    kernel.install();
    kernel.strip = true;
}
