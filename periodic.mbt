///|
pub(all) struct PeriodicFloat {
  run : FloatRun
  wraps : Bool
  unbounded : Bool
} derive(Eq, Debug, ToJson, FromJson)

///|
fn cyclic_runs(
  bits : Array[Bool],
  direction : Direction,
  thread : Int,
  min_length : Int,
) -> Array[PeriodicFloat] {
  let n = bits.length()
  let out = []
  if bits.iter().all(fn(b) { b }) {
    out.push({
      run: { direction, thread, start: 0, length: n, },
      wraps: true,
      unbounded: true,
    })
    return out
  }
  for i = 0; i < n; i = i + 1 {
    if !bits[i] || bits[(i + n - 1) % n] {
      continue
    }
    let mut length = 1
    while length < n && bits[(i + length) % n] {
      length = length + 1
    }
    if length >= min_length {
      out.push({
        run: { direction, thread, start: i, length, },
        wraps: i + length > n,
        unbounded: false,
      })
    }
  }
  out
}

///|
/// Infinite tiled fabric. A wholly exposed thread is unbounded, never merely period-length.
pub fn Draft::periodic_floats(
  self : Draft,
  min_length : Int,
  back? : Bool = false,
) -> Result[Array[PeriodicFloat], String] {
  if min_length < 1 {
    return Err("weave.float-limit")
  }
  let cells = self.drawdown()
  let out = []
  for x = 0; x < self.width(); x = x + 1 {
    for
      r in cyclic_runs(
        cells.map(fn(row) { row[x] != back }),
        Warp,
        x,
        min_length,
      ) {
      out.push(r)
    }
  }
  for y = 0; y < self.height(); y = y + 1 {
    for r in cyclic_runs(cells[y].map(fn(b) { b == back }), Weft, y, min_length) {
      out.push(r)
    }
  }
  Ok(out)
}
