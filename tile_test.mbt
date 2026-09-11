///|
test "tiling obeys drawdown repetition and cropping recovers source" {
  let d = twill(2, 1).unwrap()
  let t = d.tile(3, 2).unwrap()
  let a = d.drawdown()
  for y, row in t.drawdown() {
    for x, v in row {
      assert_eq(v, a[y % 3][x % 3])
    }
  }
  assert_eq(t.crop(3, 3, 3, 3).unwrap(), d)
  assert_true(d.tile(2147483647, 2) is Err(_))
  assert_true(d.crop(1, 1, 2147483647, 1) is Err(_))
  assert_true(d.crop(-1, 0, 1, 1) is Err(_))
}
