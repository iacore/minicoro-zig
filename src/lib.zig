const std = @import("std");
const testing = std.testing;

export fn add(a: i32, b: i32) i32 {
    return a + b;
}

test "basic add functionality" {
    try testing.expect(add(3, 7) == 10);
}

test "c testsuite" {
    const testsuite = @import("c_testsuite.zig");
    try std.testing.expectEqual(@as(c_int, 0), testsuite.main());
}

