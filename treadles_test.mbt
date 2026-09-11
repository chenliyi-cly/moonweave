///|
test "multi-pedal unions and sinking normalization" {
  let up = from_treadles(3, [1, 2, 3], [[1, 2], [2, 3]], [[1, 2], [], [2]]).unwrap()
  assert_eq(up.liftplan(), [[1, 2, 3], [], [2, 3]])
  let down = from_treadles(
    3,
    [1, 2, 3],
    [[1, 2], [2, 3]],
    [[1, 2], [], [2]],
    rising=false,
  ).unwrap()
  assert_eq(down.liftplan(), [[], [1, 2, 3], [1]])
}

///|
test "invalid loom activation cannot become silent empty shed" {
  assert_eq(from_treadles(2, [1], [[1]], [[2]]).unwrap_err(), "weave.treadling")
  assert_eq(from_treadles(2, [1], [[1, 1]], [[1]]).unwrap_err(), "weave.tieup")
  assert_eq(
    from_treadles(2, [1], [[1]], [[1, 1]]).unwrap_err(),
    "weave.treadling",
  )
  assert_eq(from_treadles(2, [1], [], [[1]]).unwrap_err(), "weave.treadles")
}
