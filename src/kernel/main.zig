const Proc = @import("Proc.zig");

pub fn main() void {
    if (Proc.cpuId() == 0) {}
}
