///|
test "direct pedal synthesis reproduces lifts including rest picks" {
  let d = draft(3, [1, 2, 3], [[1, 2], [], [3], [1, 2]]).unwrap()
  let p = d.direct_tieup(2).unwrap()
  assert_eq(p.tieup.length(), 2)
  assert_eq(from_treadles(3, d.threads(), p.tieup, p.treadling).unwrap(), d)
  assert_true(d.direct_tieup(1) is Err(_))
  let rest = draft(1, [1], [[]]).unwrap()
  let idle = rest.direct_tieup(1).unwrap()
  assert_eq(from_treadles(1, [1], idle.tieup, idle.treadling).unwrap(), rest)
}
