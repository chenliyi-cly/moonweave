///|
pub(all) struct CellDifference {
  warp : Int
  pick : Int
  before : Bool
  after : Bool
} derive(Eq, Debug, ToJson, FromJson)

///|
/// Compare finite fabrics. Unequal dimensions are an error; phase is not silently aligned.
pub fn Draft::differences(
  self : Draft,
  other : Draft,
) -> Result[Array[CellDifference], String] {
  if self.width() != other.width() || self.height() != other.height() {
    return Err("weave.dimensions")
  }
  let a = self.drawdown()
  let b = other.drawdown()
  let out : Array[CellDifference] = []
  for y, row in a {
    for x, v in row {
      if v != b[y][x] {
        out.push({ warp: x, pick: y, before: v, after: b[y][x] })
      }
    }
  }
  Ok(out)
}

///|
/// Count actual face changes along yarns; counts each seam once only when periodic.
pub(all) struct BindingCounts {
  warp : Array[Int]
  weft : Array[Int]
} derive(Eq, Debug, ToJson, FromJson)

///|
pub fn Draft::bindings(self : Draft, periodic? : Bool = false) -> BindingCounts {
  let a = self.drawdown()
  let warp = Array::make(self.width(), 0)
  let weft = Array::make(self.height(), 0)
  for y, row in a {
    for x, v in row {
      if (y > 0 || periodic) &&
        v != a[(y + self.height() - 1) % self.height()][x] {
        warp[x] = warp[x] + 1
      }
      if (x > 0 || periodic) && v != row[(x + self.width() - 1) % self.width()] {
        weft[y] = weft[y] + 1
      }
    }
  }
  { warp, weft }
}
