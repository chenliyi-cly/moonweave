///|
test "fabric transformations are involutions and commute with simulation" {
  let d = twill(2, 1).unwrap()
  assert_eq(d.reverse_warp().reverse_warp(), d)
  assert_eq(d.reverse_picks().reverse_picks(), d)
  assert_eq(d.other_face().other_face(), d)
  assert_eq(d.shift(-1, 2).shift(1, -2), d)
  let a = d.drawdown()
  let b = d.other_face().drawdown()
  for y, row in a {
    for x, v in row {
      assert_eq(b[y][x], !v)
    }
  }
  assert_eq(
    d.reverse_warp().drawdown()[0],
    Array::makei(3, fn(i) { a[0][2 - i] }),
  )
}
