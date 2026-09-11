///|
fn main {
  let d = @weave.plain(4, 4).unwrap()
  assert_eq(d.periodic_floats(2).unwrap().length(), 0) catch {
    _ => abort("plain example failed")
  }
  println(
    "平纹 8×8：经纬交替，周期内没有长度 ≥2 的正面浮长。",
  )
  println(d.write_grid())
}
