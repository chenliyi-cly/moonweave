///|
/// Reverse warp ordering without changing the loom setup.
pub fn Draft::reverse_warp(self : Draft) -> Draft {
  {
    shafts: self.shafts,
    threading: Array::makei(self.width(), fn(i) {
      self.threading[self.width() - 1 - i]
    }),
    lifts: self.liftplan(),
  }
}

///|
pub fn Draft::reverse_picks(self : Draft) -> Draft {
  {
    shafts: self.shafts,
    threading: self.threads(),
    lifts: Array::makei(self.height(), fn(i) {
      self.lifts[self.height() - 1 - i].copy()
    }),
  }
}

///|
/// Change fabric face by complementing each shaft lift.
pub fn Draft::other_face(self : Draft) -> Draft {
  {
    shafts: self.shafts,
    threading: self.threads(),
    lifts: self.lifts.map(fn(row) {
      Array::makei(self.shafts, fn(i) { i + 1 }).filter(fn(s) {
        !row.contains(s)
      })
    }),
  }
}

///|
/// Shift repeat origin. Positive offsets select a later thread/pick; negative offsets wrap.
pub fn Draft::shift(self : Draft, warp : Int, pick : Int) -> Draft {
  let x = (warp % self.width() + self.width()) % self.width()
  let y = (pick % self.height() + self.height()) % self.height()
  {
    shafts: self.shafts,
    threading: Array::makei(self.width(), fn(i) {
      self.threading[(i + x) % self.width()]
    }),
    lifts: Array::makei(self.height(), fn(i) {
      self.lifts[(i + y) % self.height()].copy()
    }),
  }
}
