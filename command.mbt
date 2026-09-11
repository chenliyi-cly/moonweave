///|
pub fn help() -> String {
  "MoonWeave: plain <warp-repeats> <pick-repeats> | twill <up> <down> | satin <shafts> <step> [grid|json|svg|report]\nJSON input: json <document> [grid|json|svg|report]\nGrid input: grid <document> [grid|json|svg|report]"
}

///|
pub(all) struct Analysis {
  width : Int
  height : Int
  shafts : Int
  repeat_size : RepeatSize
  front : Array[PeriodicFloat]
  back : Array[PeriodicFloat]
  bindings : BindingCounts
} derive(Eq, Debug, ToJson, FromJson)

///|
pub fn Draft::analyze(self : Draft) -> Analysis {
  {
    width: self.width(),
    height: self.height(),
    shafts: self.shafts,
    repeat_size: self.repeat_size(),
    front: self.periodic_floats(2).unwrap(),
    back: self.periodic_floats(2, back=true).unwrap(),
    bindings: self.bindings(periodic=true),
  }
}

///|
/// Pure command dispatcher: args excludes program name; never opens files or runs processes.
pub fn command(args : Array[String]) -> Result[String, String] {
  if args == [] || args == ["help"] || args == ["--help"] {
    return Ok(help())
  }
  let name = args[0]
  let input_mode = name == "json" || name == "grid"
  let count = if input_mode { 2 } else { 3 }
  if args.length() != count && args.length() != count + 1 {
    return Err("cli.arguments")
  }
  let format = if args.length() == count + 1 { args[count] } else { "grid" }
  let built = if input_mode {
    if name == "json" {
      read_json(args[1])
    } else {
      read_grid(args[1])
    }
  } else {
    try {
      let a = @string.parse_int(args[1])
      let b = @string.parse_int(args[2])
      match name {
        "plain" => plain(a, b)
        "twill" => twill(a, b)
        "satin" => satin(a, b)
        _ => Err("cli.command")
      }
    } catch {
      _ => Err("cli.integer")
    }
  }
  match built {
    Err(e) => Err(e)
    Ok(d) =>
      match format {
        "grid" => Ok(d.write_grid())
        "json" => Ok(d.write_json())
        "svg" => d.svg()
        "report" => Ok(d.analyze().to_json().stringify())
        _ => Err("cli.format")
      }
  }
}
