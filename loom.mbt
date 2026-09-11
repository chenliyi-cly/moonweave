///|
/// Loom limits are advisory engineering constraints, not fabric safety certification.
pub(all) struct LoomLimits {
  shafts : Int
  raised : Int
  float_length : Int
} derive(Eq, Debug)

///|
pub(all) struct Finding {
  code : String
  pick : Int
  thread : Int
  shaft : Int?
  direction : Direction?
  back : Bool?
} derive(Eq, Debug, ToJson, FromJson)

///|
pub fn Draft::check_loom(
  self : Draft,
  limits : LoomLimits,
) -> Result[Array[Finding], String] {
  if limits.shafts < 1 ||
    limits.raised < 0 ||
    limits.float_length < 1 ||
    limits.float_length > 2048 {
    return Err("weave.limits")
  }
  let out : Array[Finding] = []
  if self.shafts > limits.shafts {
    out.push({
      code: "loom.shaft_capacity",
      pick: -1,
      thread: -1,
      shaft: None,
      direction: None,
      back: None,
    })
  }
  for p, lift in self.lifts {
    if lift.length() > limits.raised {
      out.push({
        code: "loom.raised_capacity",
        pick: p,
        thread: -1,
        shaft: None,
        direction: None,
        back: None,
      })
    }
    let visible = self.threading.filter(fn(s) { lift.contains(s) }).length()
    if visible == 0 || visible == self.width() {
      out.push({
        code: "loom.closed_shed",
        pick: p,
        thread: -1,
        shaft: None,
        direction: None,
        back: None,
      })
    }
  }
  for s = 1; s <= self.shafts; s = s + 1 {
    if !self.threading.contains(s) {
      out.push({
        code: "loom.unused_shaft",
        pick: -1,
        thread: -1,
        shaft: Some(s),
        direction: None,
        back: None,
      })
    }
  }
  for back in [false, true] {
    match self.periodic_floats(limits.float_length + 1, back~) {
      Ok(runs) =>
        for r in runs {
          out.push({
            code: if r.unbounded {
              "loom.unbound_thread"
            } else {
              "loom.long_float"
            },
            pick: if r.run.direction == Warp {
              r.run.start
            } else {
              r.run.thread
            },
            thread: if r.run.direction == Warp {
              r.run.thread
            } else {
              r.run.start
            },
            shaft: None,
            direction: Some(r.run.direction),
            back: Some(back),
          })
        }
      Err(_) => ()
    }
  }
  Ok(out)
}
