///|
test "CLI command surface covers recipes exchange report and errors" {
  assert_eq(command(["plain", "1", "1"]).unwrap(), "#.\n.#\n")
  let text = command(["twill", "2", "2", "json"]).unwrap()
  assert_eq(
    command(["json", text, "grid"]).unwrap(),
    twill(2, 2).unwrap().write_grid(),
  )
  assert_true(
    command(["satin", "5", "2", "report"]).unwrap().contains("bindings"),
  )
  assert_true(command(["grid", "#.\n.#", "svg"]).unwrap().contains("<svg"))
  for
    args in [
      ["plain"],
      ["bad", "1", "2"],
      ["plain", "a", "1"],
      ["plain", "1", "1", "bad"],
      ["help", "extra"],
    ] {
    assert_true(command(args) is Err(_))
  }
}
