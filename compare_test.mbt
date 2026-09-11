///|
test "finite comparison reports exact changed intersections" {
  let d = plain(1, 1).unwrap()
  assert_eq(d.differences(d).unwrap().length(), 0)
  assert_eq(d.differences(d.other_face()).unwrap().length(), 4)
  assert_true(d.differences(twill(2, 1).unwrap()) is Err(_))
  let b = d.bindings()
  assert_eq(b.warp, [1, 1])
  assert_eq(b.weft, [1, 1])
  assert_eq(d.bindings(periodic=true).warp, [2, 2])
  assert_eq(draft(1, [1], [[1]]).unwrap().bindings(periodic=true).weft, [0])
}
