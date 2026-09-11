///|
/// Portable drawdown notation: '#' warp above, '.' weft above, newline separates picks.
/// One optional terminal newline and CRLF are accepted; no whitespace is discarded.
pub fn read_grid(text : String) -> Result[Draft, String] {
  if text.length() > 528384 {
    return Err("weave.grid_size")
  }
  let lines = text.split("\n").map(fn(s) { s.to_owned() }).to_array()
  if lines.length() > 0 && lines[lines.length() - 1] == "" {
    lines.remove(lines.length() - 1) |> ignore
  }
  if lines.length() < 1 || lines.length() > 2048 {
    return Err("weave.size")
  }
  let cells : Array[Array[Bool]] = []
  for line in lines {
    let row : Array[Bool] = []
    let chars = line.iter().to_array()
    for i, c in chars {
      if c == '\r' && i == chars.length() - 1 {
        continue
      }
      if c == '#' {
        row.push(true)
      } else if c == '.' {
        row.push(false)
      } else {
        return Err("weave.grid_character")
      }
    }
    cells.push(row)
  }
  from_drawdown(cells)
}

///|
pub fn Draft::write_grid(self : Draft) -> String {
  let out = StringBuilder()
  for row in self.drawdown() {
    for cell in row {
      out.write_string(if cell { "#" } else { "." })
    }
    out.write_string("\n")
  }
  out.to_string()
}
