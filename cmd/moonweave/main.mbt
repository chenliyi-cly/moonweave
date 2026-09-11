///|
#cfg(target="js")
fn argument_offset() -> Int {
  2
}

///|
#cfg(not(target="js"))
fn argument_offset() -> Int {
  1
}

///|
fn main {
  let raw = @env.args()
  let offset = argument_offset()
  let args = if raw.length() > offset {
    Array::makei(raw.length() - offset, fn(i) { raw[i + offset] })
  } else {
    []
  }
  match @weave.command(args) {
    Ok(output) => println(output)
    Err(code) => {
      println("MoonWeave error: " + code)
      @abort.abort(code)
    }
  }
}
