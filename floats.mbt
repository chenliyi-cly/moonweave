///|
pub(all) enum Direction {
  Warp
  Weft
} derive(Eq, Debug, ToJson, FromJson)

///|
/// Thread and start are zero-based drawdown coordinates.
pub(all) struct FloatRun {
  direction : Direction
  thread : Int
  start : Int
  length : Int
} derive(Eq, Debug, ToJson, FromJson)

///|
fn linear_runs(
  bits : Array[Bool],
  direction : Direction,
  thread : Int,
  min_length : Int,
) -> Array[FloatRun] {
  let out = []
  let mut start = 0
  while start < bits.length() {
    if !bits[start] {
      start = start + 1
      continue
    }
    let mut end = start + 1
    while end < bits.length() && bits[end] {
      end = end + 1
    }
    if end - start >= min_length {
      out.push({ direction, thread, start, length: end - start, })
    }
    start = end
  }
  out
}

///|
/// Front-face warp runs vertically, weft runs horizontally. Back swaps visibility.
pub fn Draft::floats(
  self : Draft,
  min_length : Int,
  back? : Bool = false,
) -> Result[Array[FloatRun], String] {
  if min_length < 1 {
    return Err("weave.float-limit")
  }
  let cells = self.drawdown()
  let out = []
  for x = 0; x < self.width(); x = x + 1 {
    let bits = cells.map(fn(row) { row[x] != back })
    for run in linear_runs(bits, Warp, x, min_length) {
      out.push(run)
    }
  }
  for y = 0; y < self.height(); y = y + 1 {
    let bits = cells[y].map(fn(b) { b == back })
    for run in linear_runs(bits, Weft, y, min_length) {
      out.push(run)
    }
  }
  Ok(out)
}
