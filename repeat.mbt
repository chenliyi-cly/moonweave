///|
pub(all) struct RepeatSize {
  warp : Int
  pick : Int
} derive(Eq, Debug, ToJson, FromJson)

///|
/// Smallest axis-aligned period dividing the finite drawdown. O(cells*(width+height)) worst case.
pub fn Draft::repeat_size(self : Draft) -> RepeatSize {
  let a = self.drawdown()
  let mut wx = self.width()
  for n = 1; n <= self.width(); n = n + 1 {
    if self.width() % n != 0 {
      continue
    }
    let mut good = true
    for row in a {
      for x, v in row {
        if v != row[x % n] {
          good = false
          break
        }
      }
      if !good {
        break
      }
    }
    if good {
      wx = n
      break
    }
  }
  let mut py = self.height()
  for n = 1; n <= self.height(); n = n + 1 {
    if self.height() % n != 0 {
      continue
    }
    let mut good = true
    for y, row in a {
      if row != a[y % n] {
        good = false
        break
      }
    }
    if good {
      py = n
      break
    }
  }
  { warp: wx, pick: py }
}

///|
/// Preserve draft shafts and crop to the smallest drawdown repeat.
pub fn Draft::reduce_repeat(self : Draft) -> Draft {
  let r = self.repeat_size()
  {
    shafts: self.shafts,
    threading: Array::makei(r.warp, fn(i) { self.threading[i] }),
    lifts: Array::makei(r.pick, fn(i) { self.lifts[i].copy() }),
  }
}
