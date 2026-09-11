///|
test "human drawdown notation roundtrips and rejects ragged or ambiguous input" {
  let d = twill(2, 2).unwrap()
  assert_eq(read_grid(d.write_grid()).unwrap().drawdown(), d.drawdown())
  assert_eq(
    read_grid("#.\r\n.#\r\n").unwrap().drawdown(),
    plain(1, 1).unwrap().drawdown(),
  )
  for bad in ["", "# ", "#\n..", "#\n\n", "#x", "#\r."] {
    assert_true(read_grid(bad) is Err(_))
  }
}
