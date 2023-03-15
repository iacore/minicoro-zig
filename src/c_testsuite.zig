//! translation of minicoro/tests/testsuite.c

const std = @import("std");
const c = @import("c.zig");
const mco_coro = c.mco_coro;
const mco_create = c.mco_create;
const MCO_DEAD = c.MCO_DEAD;
const mco_desc = c.mco_desc;
const mco_desc_init = c.mco_desc_init;
const mco_destroy = c.mco_destroy;
const mco_get_bytes_stored = c.mco_get_bytes_stored;
const mco_get_user_data = c.mco_get_user_data;
const MCO_NORMAL = c.MCO_NORMAL;
const mco_peek = c.mco_peek;
const mco_pop = c.mco_pop;
const mco_push = c.mco_push;
const mco_resume = c.mco_resume;
const mco_running = c.mco_running;
const MCO_RUNNING = c.MCO_RUNNING;
const mco_status = c.mco_status;
const MCO_SUCCESS = c.MCO_SUCCESS;
const MCO_SUSPENDED = c.MCO_SUSPENDED;
const mco_yield = c.mco_yield;
const strcmp = std.zig.c_builtins.__builtin_strcmp;

fn __assert_fail(msg: []const u8, file: []const u8, line: c_uint, func: []const u8) noreturn {
    std.debug.panic("{s}\nat {s} {s}:{}", .{ msg, func, file, line });
}

pub export fn coro_entry2(arg_co2: [*c]mco_coro) void {
    var co2 = arg_co2;
    var co: [*c]mco_coro = null;
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (mco_running() == co2) {} else {
                __assert_fail("mco_running() == co2", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 11)), "void coro_entry2(mco_coro *)");
            };
        };
    };
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (mco_status(co2) == @bitCast(c_uint, MCO_RUNNING)) {} else {
                __assert_fail("mco_status(co2) == MCO_RUNNING", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 12)), "void coro_entry2(mco_coro *)");
            };
        };
    };
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (mco_pop(co2, @ptrCast(?*anyopaque, &co), @sizeOf([*c]mco_coro)) == @bitCast(c_uint, MCO_SUCCESS)) {} else {
                __assert_fail("mco_pop(co2, &co, sizeof(co)) == MCO_SUCCESS", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 13)), "void coro_entry2(mco_coro *)");
            };
        };
    };
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (mco_pop(co2, @intToPtr(?*anyopaque, @as(c_int, 0)), mco_get_bytes_stored(co2)) == @bitCast(c_uint, MCO_SUCCESS)) {} else {
                __assert_fail("mco_pop(co2, NULL, mco_get_bytes_stored(co2)) == MCO_SUCCESS", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 14)), "void coro_entry2(mco_coro *)");
            };
        };
    };
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (mco_status(co) == @bitCast(c_uint, MCO_NORMAL)) {} else {
                __assert_fail("mco_status(co) == MCO_NORMAL", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 15)), "void coro_entry2(mco_coro *)");
            };
        };
    };
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (mco_get_bytes_stored(co2) == @bitCast(c_ulong, @as(c_long, @as(c_int, 0)))) {} else {
                __assert_fail("mco_get_bytes_stored(co2) == 0", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 16)), "void coro_entry2(mco_coro *)");
            };
        };
    };
    _ = std.debug.print("hello 2\n", .{});
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (mco_yield(mco_running()) == @bitCast(c_uint, MCO_SUCCESS)) {} else {
                __assert_fail("mco_yield(mco_running()) == MCO_SUCCESS", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 18)), "void coro_entry2(mco_coro *)");
            };
        };
    };
    _ = std.debug.print("world! 2\n", .{});
}
pub export var dummy_user_data: c_int = 0;
pub export fn coro_entry(arg_co: [*c]mco_coro) void {
    var co = arg_co;
    var buffer: [128]u8 = [1]u8{
        0,
    } ++ [1]u8{0} ** 127;
    var ret: c_int = undefined;
    var co2: [*c]mco_coro = undefined;
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (mco_get_user_data(co) == @ptrCast(?*anyopaque, &dummy_user_data)) {} else {
                __assert_fail("mco_get_user_data(co) == &dummy_user_data", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 30)), "void coro_entry(mco_coro *)");
            };
        };
    };
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (mco_running() == co) {} else {
                __assert_fail("mco_running() == co", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 31)), "void coro_entry(mco_coro *)");
            };
        };
    };
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (mco_status(co) == @bitCast(c_uint, MCO_RUNNING)) {} else {
                __assert_fail("mco_status(co) == MCO_RUNNING", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 32)), "void coro_entry(mco_coro *)");
            };
        };
    };
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (mco_get_bytes_stored(co) == @bitCast(c_ulong, @as(c_long, @as(c_int, 6)))) {} else {
                __assert_fail("mco_get_bytes_stored(co) == 6", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 35)), "void coro_entry(mco_coro *)");
            };
        };
    };
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (mco_peek(co, @ptrCast(?*anyopaque, @ptrCast([*c]u8, @alignCast(@import("std").meta.alignment([*c]u8), &buffer))), mco_get_bytes_stored(co)) == @bitCast(c_uint, MCO_SUCCESS)) {} else {
                __assert_fail("mco_peek(co, buffer, mco_get_bytes_stored(co)) == MCO_SUCCESS", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 36)), "void coro_entry(mco_coro *)");
            };
        };
    };
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (strcmp(@ptrCast([*c]u8, @alignCast(@import("std").meta.alignment([*c]u8), &buffer)), "hello") == @as(c_int, 0)) {} else {
                __assert_fail("strcmp(buffer, \"hello\") == 0", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 37)), "void coro_entry(mco_coro *)");
            };
        };
    };
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (mco_pop(co, @intToPtr(?*anyopaque, @as(c_int, 0)), mco_get_bytes_stored(co)) == @bitCast(c_uint, MCO_SUCCESS)) {} else {
                __assert_fail("mco_pop(co, NULL, mco_get_bytes_stored(co)) == MCO_SUCCESS", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 38)), "void coro_entry(mco_coro *)");
            };
        };
    };
    _ = std.debug.print("{s}\n", .{buffer});
    ret = 1;
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (mco_push(co, @ptrCast(?*const anyopaque, &ret), @sizeOf(c_int)) == @bitCast(c_uint, MCO_SUCCESS)) {} else {
                __assert_fail("mco_push(co, &ret, sizeof(ret)) == MCO_SUCCESS", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 43)), "void coro_entry(mco_coro *)");
            };
        };
    };
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (mco_yield(co) == @bitCast(c_uint, MCO_SUCCESS)) {} else {
                __assert_fail("mco_yield(co) == MCO_SUCCESS", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 46)), "void coro_entry(mco_coro *)");
            };
        };
    };
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (mco_get_bytes_stored(co) == @bitCast(c_ulong, @as(c_long, @as(c_int, 7)))) {} else {
                __assert_fail("mco_get_bytes_stored(co) == 7", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 49)), "void coro_entry(mco_coro *)");
            };
        };
    };
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (mco_pop(co, @ptrCast(?*anyopaque, @ptrCast([*c]u8, @alignCast(@import("std").meta.alignment([*c]u8), &buffer))), mco_get_bytes_stored(co)) == @bitCast(c_uint, MCO_SUCCESS)) {} else {
                __assert_fail("mco_pop(co, buffer, mco_get_bytes_stored(co)) == MCO_SUCCESS", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 50)), "void coro_entry(mco_coro *)");
            };
        };
    };
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (strcmp(@ptrCast([*c]u8, @alignCast(@import("std").meta.alignment([*c]u8), &buffer)), "world!") == @as(c_int, 0)) {} else {
                __assert_fail("strcmp(buffer, \"world!\") == 0", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 51)), "void coro_entry(mco_coro *)");
            };
        };
    };
    _ = std.debug.print("{s}\n", .{buffer});
    ret = 2;
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (mco_push(co, @ptrCast(?*const anyopaque, &ret), @sizeOf(c_int)) == @bitCast(c_uint, MCO_SUCCESS)) {} else {
                __assert_fail("mco_push(co, &ret, sizeof(ret)) == MCO_SUCCESS", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 56)), "void coro_entry(mco_coro *)");
            };
        };
    };
    var desc: mco_desc = mco_desc_init(&coro_entry2, @bitCast(usize, @as(c_long, @as(c_int, 0))));
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (mco_create(&co2, &desc) == @bitCast(c_uint, MCO_SUCCESS)) {} else {
                __assert_fail("mco_create(&co2, &desc) == MCO_SUCCESS", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 60)), "void coro_entry(mco_coro *)");
            };
        };
    };
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (mco_push(co2, @ptrCast(?*const anyopaque, &co), @sizeOf([*c]mco_coro)) == @bitCast(c_uint, MCO_SUCCESS)) {} else {
                __assert_fail("mco_push(co2, &co, sizeof(co)) == MCO_SUCCESS", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 61)), "void coro_entry(mco_coro *)");
            };
        };
    };
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (mco_resume(co2) == @bitCast(c_uint, MCO_SUCCESS)) {} else {
                __assert_fail("mco_resume(co2) == MCO_SUCCESS", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 62)), "void coro_entry(mco_coro *)");
            };
        };
    };
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (mco_resume(co2) == @bitCast(c_uint, MCO_SUCCESS)) {} else {
                __assert_fail("mco_resume(co2) == MCO_SUCCESS", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 63)), "void coro_entry(mco_coro *)");
            };
        };
    };
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (mco_get_bytes_stored(co2) == @bitCast(c_ulong, @as(c_long, @as(c_int, 0)))) {} else {
                __assert_fail("mco_get_bytes_stored(co2) == 0", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 64)), "void coro_entry(mco_coro *)");
            };
        };
    };
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (mco_status(co2) == @bitCast(c_uint, MCO_DEAD)) {} else {
                __assert_fail("mco_status(co2) == MCO_DEAD", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 65)), "void coro_entry(mco_coro *)");
            };
        };
    };
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (mco_status(co) == @bitCast(c_uint, MCO_RUNNING)) {} else {
                __assert_fail("mco_status(co) == MCO_RUNNING", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 66)), "void coro_entry(mco_coro *)");
            };
        };
    };
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (mco_running() == co) {} else {
                __assert_fail("mco_running() == co", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 67)), "void coro_entry(mco_coro *)");
            };
        };
    };
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (mco_destroy(co2) == @bitCast(c_uint, MCO_SUCCESS)) {} else {
                __assert_fail("mco_destroy(co2) == MCO_SUCCESS", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 68)), "void coro_entry(mco_coro *)");
            };
        };
    };
}
pub fn main() c_int {
    var co: [*c]mco_coro = undefined;
    var ret: c_int = 0;
    var desc: mco_desc = mco_desc_init(&coro_entry, @bitCast(usize, @as(c_long, @as(c_int, 0))));
    desc.user_data = @ptrCast(?*anyopaque, &dummy_user_data);
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (mco_create(&co, &desc) == @bitCast(c_uint, MCO_SUCCESS)) {} else {
                __assert_fail("mco_create(&co, &desc) == MCO_SUCCESS", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 78)), "int main(void)");
            };
        };
    };
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (mco_status(co) == @bitCast(c_uint, MCO_SUSPENDED)) {} else {
                __assert_fail("mco_status(co) == MCO_SUSPENDED", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 79)), "int main(void)");
            };
        };
    };
    const first_word: [5:0]u8 = "hello".*;
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (mco_push(co, @ptrCast(?*const anyopaque, @ptrCast([*c]const u8, @alignCast(@import("std").meta.alignment([*c]const u8), &first_word))), @sizeOf([6]u8)) == @bitCast(c_uint, MCO_SUCCESS)) {} else {
                __assert_fail("mco_push(co, first_word, sizeof(first_word)) == MCO_SUCCESS", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 83)), "int main(void)");
            };
        };
    };
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (mco_resume(co) == @bitCast(c_uint, MCO_SUCCESS)) {} else {
                __assert_fail("mco_resume(co) == MCO_SUCCESS", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 86)), "int main(void)");
            };
        };
    };
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (mco_status(co) == @bitCast(c_uint, MCO_SUSPENDED)) {} else {
                __assert_fail("mco_status(co) == MCO_SUSPENDED", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 87)), "int main(void)");
            };
        };
    };
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (mco_pop(co, @ptrCast(?*anyopaque, &ret), @sizeOf(c_int)) == @bitCast(c_uint, MCO_SUCCESS)) {} else {
                __assert_fail("mco_pop(co, &ret, sizeof(ret)) == MCO_SUCCESS", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 90)), "int main(void)");
            };
        };
    };
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (ret == @as(c_int, 1)) {} else {
                __assert_fail("ret == 1", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 91)), "int main(void)");
            };
        };
    };
    const second_word: [6:0]u8 = "world!".*;
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (mco_push(co, @ptrCast(?*const anyopaque, @ptrCast([*c]const u8, @alignCast(@import("std").meta.alignment([*c]const u8), &second_word))), @sizeOf([7]u8)) == @bitCast(c_uint, MCO_SUCCESS)) {} else {
                __assert_fail("mco_push(co, second_word, sizeof(second_word)) == MCO_SUCCESS", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 95)), "int main(void)");
            };
        };
    };
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (mco_resume(co) == @bitCast(c_uint, MCO_SUCCESS)) {} else {
                __assert_fail("mco_resume(co) == MCO_SUCCESS", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 98)), "int main(void)");
            };
        };
    };
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (mco_status(co) == @bitCast(c_uint, MCO_DEAD)) {} else {
                __assert_fail("mco_status(co) == MCO_DEAD", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 99)), "int main(void)");
            };
        };
    };
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (mco_pop(co, @ptrCast(?*anyopaque, &ret), @sizeOf(c_int)) == @bitCast(c_uint, MCO_SUCCESS)) {} else {
                __assert_fail("mco_pop(co, &ret, sizeof(ret)) == MCO_SUCCESS", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 102)), "int main(void)");
            };
        };
    };
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (ret == @as(c_int, 2)) {} else {
                __assert_fail("ret == 2", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 103)), "int main(void)");
            };
        };
    };
    _ = blk: {
        _ = @sizeOf(c_int);
        break :blk blk_1: {
            break :blk_1 if (mco_destroy(co) == @bitCast(c_uint, MCO_SUCCESS)) {} else {
                __assert_fail("mco_destroy(co) == MCO_SUCCESS", "tests/testsuite.c", @bitCast(c_uint, @as(c_int, 106)), "int main(void)");
            };
        };
    };
    _ = std.debug.print("Test suite succeeded!\n", .{});
    return 0;
}
