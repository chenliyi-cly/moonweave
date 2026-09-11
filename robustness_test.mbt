///|
test "Unicode palettes and extreme numeric limits return errors without panics" {
  let d = plain(1, 1).unwrap()
  assert_true(d.svg(warp_color="#😀abcd") is Err(_))
  assert_true(
    d.check_loom({ shafts: 2, raised: 1, float_length: 2147483647, }) is Err(_),
  )
  assert_true(d.tile(-2147483648, 1) is Err(_))
  assert_eq(d.shift(-2147483648, 2147483647).width(), 2)
  assert_true(read_json("[[[[[[[[[0]]]]]]]]]") is Err(_))
  assert_true(
    read_json(
      "{\"schema\":\"moonweave/1\",\"shafts\":2,\"threading\":[1.5],\"lifts\":[[1]]}",
    )
    is Err(_),
  )
}

///|
test "periodic float analysis agrees with independent cell walking oracle" {
  for mask = 0; mask < 512; mask = mask + 1 {
    let a = Array::makei(3, fn(y) {
      Array::makei(3, fn(x) { (mask & (1 << (y * 3 + x))) != 0 })
    })
    let d = from_drawdown(a).unwrap()
    for back in [false, true] {
      let actual = d.periodic_floats(2, back~).unwrap()
      let mut expected = 0
      for axis in [Direction::Warp, Direction::Weft] {
        for thread = 0; thread < 3; thread = thread + 1 {
          let bits = Array::makei(3, fn(i) {
            if axis == Direction::Warp {
              a[i][thread] != back
            } else {
              a[thread][i] == back
            }
          })
          if bits.all(fn(b) { b }) {
            expected = expected + 1
          } else {
            for start = 0; start < 3; start = start + 1 {
              if !bits[start] || bits[(start + 2) % 3] {
                continue
              }
              let mut length = 1
              while length < 3 && bits[(start + length) % 3] {
                length = length + 1
              }
              if length >= 2 {
                expected = expected + 1
                assert_true(
                  actual.any(fn(r) {
                    r.run.direction == axis &&
                    r.run.thread == thread &&
                    r.run.start == start &&
                    r.run.length == length &&
                    !r.unbounded
                  }),
                )
              }
            }
          }
        }
      }
      assert_eq(actual.length(), expected)
    }
  }
}

///|
test "hard cell boundary is accepted and excess resources refused" {
  let d = plain(256, 256).unwrap()
  assert_eq(d.drawdown().length(), 512)
  assert_true(plain(257, 256) is Err(_))
  assert_true(d.svg() is Err(_))
}
