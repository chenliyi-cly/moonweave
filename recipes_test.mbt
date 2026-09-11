///|
test "plain and twill generators have analytical float lengths" {
  let p = plain(3, 4).unwrap()
  assert_eq(p.width(), 6)
  assert_eq(p.height(), 8)
  assert_eq(p.floats(2).unwrap().length(), 0)
  let t = twill(2, 2).unwrap()
  assert_true(
    t
    .periodic_floats(2)
    .unwrap()
    .all(fn(r) { r.run.length == 2 && !r.unbounded }),
  )
  assert_true(plain(1024, 1024) is Err(_))
  assert_true(twill(0, 2) is Err(_))
}

///|
test "satin steps visit every binding point exactly once" {
  let s = satin(5, 2).unwrap().drawdown()
  for x = 0; x < 5; x = x + 1 {
    assert_eq(s.filter(fn(row) { !row[x] }).length(), 1)
  }
  assert_true(satin(6, 2) is Err(_))
  assert_true(satin(5, 1) is Err(_))
}
