const std = @import("std");
const mco = @import("lib.zig");

const aeq = std.testing.expectEqual;

//TP void coro_entry2(mco_coro* co2) {
fn coro_entry2_inner(co2: *mco.Coro) !void {
    //TP   mco_coro* co = NULL;
    var co: *mco.Coro = undefined;
    //TP   assert(mco_running() == co2);
    try aeq(co2, mco.running());

    //TP   assert(mco_status(co2) == MCO_RUNNING);
    try aeq(co2.status(), .running);

    //TP   assert(mco_pop(co2, &co, sizeof(co)) == MCO_SUCCESS);
    try co2.pop(&co); // pop(T, value: *T)

    //TP   assert(mco_pop(co2, NULL, mco_get_bytes_stored(co2)) == MCO_SUCCESS);
    try co2.popDiscard(co2.storage_len());

    //TP   assert(mco_status(co) == MCO_NORMAL);
    try aeq(co.status(), .normal);

    //TP   assert(mco_get_bytes_stored(co2) == 0);
    try aeq(co2.storage_len(), 0);

    //TP   printf("hello 2\n");
    std.debug.print("hello 2\n");
    //TP   assert(mco_yield(mco_running()) == MCO_SUCCESS);

    try mco.running().yield();

    //TP   printf("world! 2\n");
    std.debug.print("world! 2\n");
    //TP }
}

fn coro_entry2(co2: *mco.coro) void {
    coro_entry2_inner(co2) catch unreachable;
}

//TP int dummy_user_data = 0;
var dummy_user_data: i32 = 0;

//TP void coro_entry(mco_coro* co) {
fn coro_entry1_inner(co: *mco.Coro) !void {
    var buffer: [128]u8 = .{0} ** 128;
    var ret: i32 = 0;

    //TP   char buffer[128] = {0};
    //TP   int ret;
    //TP   mco_coro* co2;

    //TP   /* Startup checks */
    //TP   assert(mco_get_user_data(co) == &dummy_user_data);
    aeq(co.get_user_data(), &dummy_user_data);
    //TP   assert(mco_running() == co);
    aeq(mco.running(), co);
    //TP   assert(mco_status(co) == MCO_RUNNING);
    aeq(co.status(), .running);

    //TP   /* Get storage 1 */
    //TP   assert(mco_get_bytes_stored(co) == 6);
    aeq(co.storage_len(), 6);
    //TP   assert(mco_peek(co, buffer, mco_get_bytes_stored(co)) == MCO_SUCCESS);
    try co.peekSlice(buffer[0..co.storage_len()]);
    //TP   assert(strcmp(buffer, "hello") == 0);
    try std.testing.expectEqualSlices(u8, buffer[0..first_word.len], first_word);
    //TP   assert(mco_pop(co, NULL, mco_get_bytes_stored(co)) == MCO_SUCCESS);
    try co.popDiscard(co.storage_len());
    //TP   puts(buffer);
    std.debug.print("{s}\n", .{buffer}); // jank: the trailing zeroes

    //TP   /* Set storage 1 */
    //TP   ret = 1;
    ret = 1;
    try co.push(ret);
    //TP   assert(mco_push(co, &ret, sizeof(ret)) == MCO_SUCCESS);

    //TP   /* Yield 1 */
    //TP   assert(mco_yield(co) == MCO_SUCCESS);
    try co.yield();

    //TP   /* Get storage 2 */
    //TP   assert(mco_get_bytes_stored(co) == 7);
    try aeq(co.storage_len(), 7);
    //TP   assert(mco_pop(co, buffer, mco_get_bytes_stored(co)) == MCO_SUCCESS);
    try co.popSlice(buffer[0..co.storage_len()]);
    //TP   assert(strcmp(buffer, "world!") == 0);
    try std.testing.expectEqualSlices(u8, buffer[0..second_word.len], second_word);
    //TP   puts(buffer);
    std.debug.print("{s}\n", .{buffer});

    //TP   /* Set storage 2 */
    //TP   ret = 2;
    ret = 2;
    //TP   assert(mco_push(co, &ret, sizeof(ret)) == MCO_SUCCESS);
    try co.push(ret);

    //TP   /* Nested coroutine test */

    //TP   mco_desc desc = mco_desc_init(coro_entry2, 0);
    const desc = mco.Desc.init(coro_entry2, 0);
    //TP   assert(mco_create(&co2, &desc) == MCO_SUCCESS);
    const co2: *mco.Coro = try desc.create();
    //TP   assert(mco_push(co2, &co, sizeof(co)) == MCO_SUCCESS);
    try co2.push(co);
    //TP   assert(mco_resume(co2) == MCO_SUCCESS);
    try co2.resume_();
    //TP   assert(mco_resume(co2) == MCO_SUCCESS);
    try co2.resume_();
    //TP   assert(mco_get_bytes_stored(co2) == 0);
    try aeq(co2.storage_len(), 0);
    //TP   assert(mco_status(co2) == MCO_DEAD);
    try aeq(co2.status(), .dead);
    //TP   assert(mco_status(co) == MCO_RUNNING);
    try aeq(co.status(), .running);
    //TP   assert(mco_running() == co);
    try aeq(mco.running(), co);
    //TP   assert(mco_destroy(co2) == MCO_SUCCESS);
    try co2.deinit();
    //TP }
}

fn coro_entry1(co2: *mco.coro) void {
    coro_entry1_inner(co2) catch unreachable;
}

const first_word = "hello\x00";
const second_word = "world!\x00";

//TP int main(void) {
pub fn main() void {
    //TP   int ret = 0;
    var ret: i32 = 0;

    //TP   /* Create coroutine */
    //TP   mco_desc desc = mco_desc_init(coro_entry, 0);
    var desc = mco.Desc.init(coro_entry1, 0);
    //TP   desc.user_data = &dummy_user_data;
    desc.user_data = &dummy_user_data;
    //TP   assert(mco_create(&co, &desc) == MCO_SUCCESS);
    const co = try desc.create();
    //TP   assert(mco_status(co) == MCO_SUSPENDED);
    try aeq(co.status(), .suspended);

    //TP   /* Set storage 1 */
    //TP   const char first_word[] = "hello";

    //TP   assert(mco_push(co, first_word, sizeof(first_word)) == MCO_SUCCESS);
    try co.pushSlice(first_word);

    //TP   /* Resume 1 */
    //TP   assert(mco_resume(co) == MCO_SUCCESS);
    try co.resume_();
    //TP   assert(mco_status(co) == MCO_SUSPENDED);
    try aeq(co.status(), .suspended);

    //TP   /* Get storage 1 */
    //TP   assert(mco_pop(co, &ret, sizeof(ret)) == MCO_SUCCESS);
    try mco.pop(&ret);

    //TP   assert(ret == 1);
    try aeq(ret, 1);

    //TP   /* Set storage 2 */
    //TP   const char second_word[] = "world!";

    //TP   assert(mco_push(co, second_word, sizeof(second_word)) == MCO_SUCCESS);
    try co.pushSlice(second_word);

    //TP   /* Resume 2 */
    //TP   assert(mco_resume(co) == MCO_SUCCESS);
    try co.resume_();
    //TP   assert(mco_status(co) == MCO_DEAD);
    try aeq(co.status(), .dead);

    //TP   /* Get storage 2 */
    //TP   assert(mco_pop(co, &ret, sizeof(ret)) == MCO_SUCCESS);
    try co.pop(&ret);
    //TP   assert(ret == 2);
    try aeq(ret, 2);

    //TP   /* Destroy */
    //TP   assert(mco_destroy(co) == MCO_SUCCESS);
    try co.deinit();
    //TP   printf("Test suite succeeded!\n");
    std.debug.print("Test suite succeeded!\n");
    //TP   return 0;
    //TP }
}
