///|
test "plain weave and defensive copies" {
  let threads = [1, 2, 1, 2]
  let lifts = [[1], [2]]
  let d = draft(2, threads, lifts).unwrap()
  threads[0] = 2
  lifts[0].push(2)
  d.threads()[0] = 2
  d.liftplan()[0].push(2)
  assert_eq(d.drawdown(), [
    [true, false, true, false],
    [false, true, false, true],
  ])
  assert_eq(d.width(), 4)
  assert_eq(d.height(), 2)
  assert_eq(d.shaft_count(), 2)
}

///|
test "reject malformed draft and canonicalize set order" {
  assert_eq(draft(0, [1], [[1]]), Err("weave.shafts"))
  assert_eq(draft(2, [], [[1]]), Err("weave.size"))
  assert_eq(draft(2, [3], [[1]]), Err("weave.threading"))
  assert_eq(draft(2, [1], [[1, 1]]), Err("weave.lift"))
  assert_eq(draft(2, [1], [[0]]), Err("weave.lift"))
  assert_eq(draft(2, [1], [[2, 1]]).unwrap().liftplan(), [[1, 2]])
}
