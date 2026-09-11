///|
/// Balanced two-shaft plain weave, repeated in both dimensions.
pub fn plain(warp_repeats : Int, weft_repeats : Int) -> Result[Draft, String] {
  if warp_repeats < 1 ||
    weft_repeats < 1 ||
    warp_repeats > 1024 ||
    weft_repeats > 1024 ||
    warp_repeats * weft_repeats > 65536 {
    return Err("weave.size")
  }
  draft(
    2,
    Array::makei(warp_repeats * 2, fn(i) { i % 2 + 1 }),
    Array::makei(weft_repeats * 2, fn(i) { [i % 2 + 1] }),
  )
}

///|
/// Straight twill. up/down specify consecutive raised/lowered shafts.
pub fn twill(up : Int, down : Int) -> Result[Draft, String] {
  if up < 1 || down < 1 || up > 63 || down > 63 || up + down > 64 {
    return Err("weave.twill")
  }
  let n = up + down
  draft(
    n,
    Array::makei(n, fn(i) { i + 1 }),
    Array::makei(n, fn(p) { Array::makei(up, fn(k) { (p + k) % n + 1 }) }),
  )
}

///|
fn gcd(a : Int, b : Int) -> Int {
  if b == 0 {
    a
  } else {
    gcd(b, a % b)
  }
}

///|
/// Warp-faced regular satin: one lowered shaft per pick. Reject adjacent or non-coprime steps.
pub fn satin(shafts : Int, step : Int) -> Result[Draft, String] {
  if shafts < 5 ||
    shafts > 64 ||
    step <= 1 ||
    step >= shafts - 1 ||
    gcd(shafts, step) != 1 {
    return Err("weave.satin")
  }
  draft(
    shafts,
    Array::makei(shafts, fn(i) { i + 1 }),
    Array::makei(shafts, fn(p) {
      Array::makei(shafts, fn(i) { i + 1 }).filter(fn(s) {
        s != p * step % shafts + 1
      })
    }),
  )
}
