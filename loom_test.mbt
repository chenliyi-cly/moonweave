///|
test "loom constraints report capacity closed shed unused shafts and both faces" {
  let d = draft(3, [1, 2], [[1, 2], [1]]).unwrap()
  let found = d.check_loom({ shafts: 2, raised: 1, float_length: 1 }).unwrap()
  for
    code in [
      "loom.shaft_capacity", "loom.raised_capacity", "loom.closed_shed", "loom.unused_shaft",
      "loom.unbound_thread",
    ] {
    assert_true(found.any(fn(f) { f.code == code }))
  }
  assert_true(d.check_loom({ shafts: 0, raised: 0, float_length: 1 }) is Err(_))
}

///|
test "balanced plain weave satisfies small loom constraints" {
  let d = draft(2, [1, 2], [[1], [2]]).unwrap()
  assert_eq(
    d.check_loom({ shafts: 2, raised: 1, float_length: 1 }).unwrap().length(),
    0,
  )
}
