///|
test "repeat detection uses fabric rather than shaft labels" {
  let d = draft(4, [1, 2, 3, 4], [[1, 3], [2, 4], [1, 3], [2, 4]]).unwrap()
  assert_eq(d.repeat_size(), { warp: 2, pick: 2, })
  assert_eq(d.reduce_repeat().tile(2, 2).unwrap().drawdown(), d.drawdown())
  assert_eq(draft(1, [1, 1, 1], [[1], [1]]).unwrap().repeat_size(), {
    warp: 1,
    pick: 1,
  })
  assert_eq(twill(2, 1).unwrap().repeat_size(), { warp: 3, pick: 3, })
}
