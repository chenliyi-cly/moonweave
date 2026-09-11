///|
/// Feasible direct tie-up: one pedal per distinct nonempty shed. Not a minimum multi-pedal solution.
pub(all) struct PedalPlan {
  tieup : Array[Array[Int]]
  treadling : Array[Array[Int]]
} derive(Eq, Debug, ToJson, FromJson)

///|
pub fn Draft::direct_tieup(
  self : Draft,
  pedals : Int,
) -> Result[PedalPlan, String] {
  if pedals < 1 || pedals > 64 {
    return Err("weave.pedals")
  }
  let tieup : Array[Array[Int]] = []
  let treadling : Array[Array[Int]] = []
  for lift in self.lifts {
    if lift.is_empty() {
      treadling.push([])
      continue
    }
    let mut at = -1
    for i, t in tieup {
      if t == lift {
        at = i
        break
      }
    }
    if at < 0 {
      if tieup.length() == pedals {
        return Err("weave.pedal_capacity")
      }
      at = tieup.length()
      tieup.push(lift.copy())
    }
    treadling.push([at + 1])
  }
  // Keep a legal idle pedal even when every pick rests.
  if tieup.is_empty() {
    tieup.push([])
  }
  Ok({ tieup, treadling })
}
