///|
test "SVG preview dimensions and hostile colors" {
  let d = plain(1, 1).unwrap()
  let image = d.svg(cell=10).unwrap()
  assert_true(image.contains("viewBox=\"0 0 20 20\""))
  assert_eq(image.split("<rect").count(), 4)
  assert_true(d.svg(warp_color="\" onload=\"x") is Err(_))
  assert_true(d.svg(cell=0) is Err(_))
  assert_true(plain(100, 100).unwrap().svg() is Err(_))
}
