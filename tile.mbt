///|
/// Repeat an entire draft; reject resource overflow before allocation.
pub fn Draft::tile(
  self : Draft,
  warp : Int,
  pick : Int,
) -> Result[Draft, String] {
  if warp < 1 ||
    pick < 1 ||
    warp > 2048 / self.width() ||
    pick > 2048 / self.height() {
    return Err("weave.size")
  }
  let w = self.width() * warp
  let h = self.height() * pick
  if w * h > 262144 {
    return Err("weave.size")
  }
  draft(
    self.shafts,
    Array::makei(w, fn(i) { self.threading[i % self.width()] }),
    Array::makei(h, fn(i) { self.lifts[i % self.height()].copy() }),
  )
}

///|
/// Finite rectangular sample. It is not automatically a valid repeat unit.
pub fn Draft::crop(
  self : Draft,
  x : Int,
  y : Int,
  width : Int,
  height : Int,
) -> Result[Draft, String] {
  if x < 0 ||
    y < 0 ||
    width < 1 ||
    height < 1 ||
    x >= self.width() ||
    y >= self.height() ||
    width > self.width() - x ||
    height > self.height() - y {
    return Err("weave.crop")
  }
  draft(
    self.shafts,
    Array::makei(width, fn(i) { self.threading[x + i] }),
    Array::makei(height, fn(i) { self.lifts[y + i].copy() }),
  )
}
