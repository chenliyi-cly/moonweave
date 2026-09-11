///|
/// Infer a rising-shed liftplan by grouping identical warp columns.
/// This minimizes shafts for the exact supplied drawdown, not treadles or a different repeat.
pub fn from_drawdown(cells : Array[Array[Bool]]) -> Result[Draft, String] {
  let h = cells.length()
  if h < 1 || h > 2048 {
    return Err("weave.size")
  }
  let w = cells[0].length()
  if w < 1 || w > 2048 || w * h > 262144 {
    return Err("weave.size")
  }
  if cells.any(fn(row) { row.length() != w }) {
    return Err("weave.ragged")
  }
  let signatures : Array[Array[Bool]] = []
  let threading : Array[Int] = []
  for x = 0; x < w; x = x + 1 {
    let column = cells.map(fn(row) { row[x] })
    let mut found = -1
    for i, s in signatures {
      if s == column {
        found = i
        break
      }
    }
    if found < 0 {
      if signatures.length() == 64 {
        return Err("weave.shafts")
      }
      found = signatures.length()
      signatures.push(column)
    }
    threading.push(found + 1)
  }
  draft(
    signatures.length(),
    threading,
    Array::makei(h, fn(y) {
      let lift : Array[Int] = []
      for i, s in signatures {
        if s[y] {
          lift.push(i + 1)
        }
      }
      lift
    }),
  )
}
