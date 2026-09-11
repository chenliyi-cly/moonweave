///|
test "linear floats retain location direction and face" {
  let d = draft(2, [1, 2, 2, 2], [[1], [1], [2]]).unwrap()
  let a = d.floats(2).unwrap()
  assert_eq(a.length(), 3)
  assert_eq(a[0], FloatRun::{ direction: Warp, thread: 0, start: 0, length: 2 })
  assert_eq(a[1], FloatRun::{ direction: Weft, thread: 0, start: 1, length: 3 })
  assert_eq(d.floats(0).unwrap_err(), "weave.float-limit")
  assert_eq(d.floats(5).unwrap(), [])
  assert_eq(d.floats(2, back=true).unwrap().length(), 4)
}

///|
test "alternating plain weave has no two-cell linear float" {
  let d = draft(2, [1, 2, 1, 2], [[1], [2], [1], [2]]).unwrap()
  assert_eq(d.floats(2).unwrap(), [])
  assert_eq(d.floats(2, back=true).unwrap(), [])
}
