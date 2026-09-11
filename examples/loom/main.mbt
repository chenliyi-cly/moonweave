///|
fn main {
  let d = @weave.from_treadles(
    4,
    [1, 2, 3, 4],
    [[1, 2], [2, 3], [3, 4], [1, 4]],
    [[1], [2], [3], [4]],
  ).unwrap()
  let findings = d
    .check_loom({ shafts: 4, raised: 2, float_length: 1 })
    .unwrap()
  assert_true(findings.any(fn(f) { f.code == "loom.long_float" })) catch {
    _ => abort("loom example failed")
  }
  println(
    "2/2 斜纹：综框与提升容量满足；阈值 1 下检测到跨周期长浮线。",
  )
  println(findings.to_json().stringify())
}
