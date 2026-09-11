///|
test "loom float findings preserve face direction and grid coordinates" {
  let d = draft(2, [1, 2, 2, 1], [[1], [2], [1]]).unwrap()
  let found = d.check_loom({ shafts: 2, raised: 1, float_length: 1, }).unwrap()
  let a = d.drawdown()
  for f in found {
    if f.code == "loom.long_float" || f.code == "loom.unbound_thread" {
      let back = f.back.unwrap()
      let direction = f.direction.unwrap()
      assert_eq(
        a[f.pick][f.thread],
        if direction == Warp {
          !back
        } else {
          back
        },
      )
    }
  }
  assert_true(
    found.any(fn(f) { f.direction == Some(Weft) && f.back == Some(false) }),
  )
  assert_true(
    found.any(fn(f) { f.direction == Some(Warp) && f.back == Some(true) }),
  )
  let unused = draft(3, [1, 2], [[1], [2]])
    .unwrap()
    .check_loom({ shafts: 3, raised: 1, float_length: 1, })
    .unwrap()
  assert_true(unused.any(fn(f) { f.shaft == Some(3) && f.thread == -1 }))
}
