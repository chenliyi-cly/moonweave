///|
fn main {
  let d = @weave.read_grid("#.#.\n.#.#\n#.#.\n.#.#").unwrap()
  let p = d.direct_tieup(2).unwrap()
  let restored = @weave.from_treadles(
    d.shaft_count(),
    d.threads(),
    p.tieup,
    p.treadling,
  ).unwrap()
  assert_eq(d.differences(restored).unwrap().length(), 0) catch {
    _ => abort("roundtrip example failed")
  }
  println(
    "从 4×4 交织图反推：2 个综框、2 个踏板，重建后 0 个交点差异。",
  )
  println(d.write_json())
}
