///|
/// Compile a treadle loom. Pressed treadles union their shaft sets.
/// Sinking looms are normalized once into rising liftplans.
pub fn from_treadles(
  shafts : Int,
  threading : Array[Int],
  tieup : Array[Array[Int]],
  treadling : Array[Array[Int]],
  rising? : Bool = true,
) -> Result[Draft, String] {
  if shafts < 1 || shafts > 64 {
    return Err("weave.shafts")
  }
  if tieup.length() < 1 || tieup.length() > 64 {
    return Err("weave.treadles")
  }
  if treadling.length() < 1 || treadling.length() > 2048 {
    return Err("weave.size")
  }
  for group in tieup {
    if !valid_set(group, shafts) {
      return Err("weave.tieup")
    }
  }
  let lifts : Array[Array[Int]] = []
  for pressed in treadling {
    if !valid_set(pressed, tieup.length()) {
      return Err("weave.treadling")
    }
    let raised = Array::make(shafts, false)
    for pedal in pressed {
      for shaft in tieup[pedal - 1] {
        raised[shaft - 1] = true
      }
    }
    let row = []
    for s = 0; s < shafts; s = s + 1 {
      if raised[s] == rising {
        row.push(s + 1)
      }
    }
    lifts.push(row)
  }
  draft(shafts, threading, lifts)
}
