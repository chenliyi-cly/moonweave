///|
/// Validated rising-shed draft. Public accessors return copies. IDs are one-based.
pub struct Draft {
  priv shafts : Int
  priv threading : Array[Int]
  priv lifts : Array[Array[Int]]
} derive(Eq, Debug)

///|
fn valid_set(ids : Array[Int], upper : Int) -> Bool {
  let seen : Map[Int, Bool] = Map([])
  for id in ids {
    if id < 1 || id > upper || seen.contains(id) {
      return false
    }
    seen[id] = true
  }
  true
}

///|
/// Hard limits: 64 shafts, 2048 threads/picks, 262144 cells.
pub fn draft(
  shafts : Int,
  threading : Array[Int],
  lifts : Array[Array[Int]],
) -> Result[Draft, String] {
  if shafts < 1 || shafts > 64 {
    return Err("weave.shafts")
  }
  let w = threading.length()
  let h = lifts.length()
  if w < 1 || h < 1 || w > 2048 || h > 2048 || w * h > 262144 {
    return Err("weave.size")
  }
  for id in threading {
    if id < 1 || id > shafts {
      return Err("weave.threading")
    }
  }
  for row in lifts {
    if !valid_set(row, shafts) {
      return Err("weave.lift")
    }
  }
  let canonical = lifts.map(fn(row) {
    let a = row.copy()
    a.sort()
    a
  })
  Ok({ shafts, threading: threading.copy(), lifts: canonical })
}

///|
pub fn Draft::shaft_count(self : Draft) -> Int {
  self.shafts
}

///|
pub fn Draft::width(self : Draft) -> Int {
  self.threading.length()
}

///|
pub fn Draft::height(self : Draft) -> Int {
  self.lifts.length()
}

///|
pub fn Draft::threads(self : Draft) -> Array[Int] {
  self.threading.copy()
}

///|
pub fn Draft::liftplan(self : Draft) -> Array[Array[Int]] {
  self.lifts.map(fn(a) { a.copy() })
}

///|
/// Row-major; true means warp is above weft on the front face.
pub fn Draft::drawdown(self : Draft) -> Array[Array[Bool]] {
  self.lifts.map(fn(row) {
    self.threading.map(fn(shaft) { row.contains(shaft) })
  })
}
