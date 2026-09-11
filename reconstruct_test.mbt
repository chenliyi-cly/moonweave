///|
test "shaft inference roundtrips all 3x3 binary fabrics" {
  for mask = 0; mask < 512; mask = mask + 1 {
    let cells = Array::makei(3, fn(y) {
      Array::makei(3, fn(x) { (mask & (1 << (y * 3 + x))) != 0 })
    })
    let d = from_drawdown(cells).unwrap()
    assert_eq(d.drawdown(), cells)
    let distinct : Array[Array[Bool]] = []
    for x = 0; x < 3; x = x + 1 {
      let c = cells.map(fn(r) { r[x] })
      if !distinct.contains(c) {
        distinct.push(c)
      }
    }
    assert_eq(d.shaft_count(), distinct.length())
  }
  assert_true(from_drawdown([[true], []]) is Err(_))
  assert_true(from_drawdown([]) is Err(_))
}

///|
test "inference refuses 65 independent shafts" {
  let cells = Array::makei(7, fn(y) {
    Array::makei(65, fn(x) { (x & (1 << y)) != 0 })
  })
  assert_true(from_drawdown(cells) is Err(_))
}
