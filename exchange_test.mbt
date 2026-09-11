///|
test "JSON exchange validates schema fields and draft invariants" {
  let d = satin(5, 2).unwrap()
  assert_eq(read_json(d.write_json()).unwrap(), d)
  for
    bad in [
      "{}", "[]", "null", "{", "{\"schema\":\"moonweave/2\",\"shafts\":1,\"threading\":[1],\"lifts\":[[1]]}",
      "{\"schema\":\"moonweave/1\",\"shafts\":1,\"threading\":[2],\"lifts\":[[1]]}",
      "{\"schema\":\"moonweave/1\",\"shafts\":1.5,\"threading\":[1],\"lifts\":[[1]]}",
      "{\"schema\":\"moonweave/1\",\"shafts\":1,\"threading\":[1],\"lifts\":[[1]],\"extra\":0}",
    ] {
    assert_true(read_json(bad) is Err(_))
  }
}
