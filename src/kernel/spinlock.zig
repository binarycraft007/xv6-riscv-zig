const proc = @import("proc.zig");
// Mutual exclusion lock.
pub const SpinLock = struct {
    locked: bool, // Is the lock held?
    // For debugging:
    name: []const u8, // Name of lock.
    cpu: ?*proc.Cpu, // The cpu holding the lock.

    const Self = @This();

    pub fn init(name: []const u8) Self {
        return Self{
            .name = name,
            .locked = false,
            .cpu = null,
        };
    }
};
