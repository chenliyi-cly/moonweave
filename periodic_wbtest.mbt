///|
test "period seams merge and fully exposed threads remain unbounded" {
  let a = cyclic_runs([true, false, true, true], Warp, 0, 2)
  assert_eq(a.length(), 1)
  assert_eq(a[0].run.start, 2)
  assert_eq(a[0].run.length, 3)
  assert_true(a[0].wraps)
  assert_false(a[0].unbounded)
  let b = draft(1, [1], [[1]]).unwrap().periodic_floats(100).unwrap()
  assert_eq(b.length(), 1)
  assert_true(b[0].unbounded)
}

///|
test "exhaustive cyclic coverage all bit strings through length eight" {
  for n = 1; n <= 8; n = n + 1 {
    for mask = 0; mask < 1 << n; mask = mask + 1 {
      let bits = Array::makei(n, fn(i) { (mask & (1 << i)) != 0 })
      let seen = Array::make(n, 0)
      for r in cyclic_runs(bits, Warp, 0, 1) {
        for k = 0; k < r.run.length; k = k + 1 {
          let i = (r.run.start + k) % n
          seen[i] = seen[i] + 1
        }
      }
      for i = 0; i < n; i = i + 1 {
        assert_eq(seen[i], if bits[i] { 1 } else { 0 })
      }
    }
  }
}
