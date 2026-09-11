///|
fn hex_color(text : String) -> Bool {
  if text.length() != 7 || !text.has_prefix("#") {
    return false
  }
  let chars = text.iter().to_array()
  for i = 1; i < 7; i = i + 1 {
    let c = chars[i]
    if !((c >= '0' && c <= '9') ||
      (c >= 'a' && c <= 'f') ||
      (c >= 'A' && c <= 'F')) {
      return false
    }
  }
  true
}

///|
/// Self-contained SVG; only validated hex colors enter attributes. No external resources or scripts.
pub fn Draft::svg(
  self : Draft,
  cell? : Int = 16,
  warp_color? : String = "#245A81",
  weft_color? : String = "#E8D6B4",
) -> Result[String, String] {
  if cell < 1 || cell > 64 || !hex_color(warp_color) || !hex_color(weft_color) {
    return Err("weave.svg_options")
  }
  // A bounded preview, not a megapixel export engine.
  if self.width() * self.height() > 16384 {
    return Err("weave.svg_size")
  }
  let out = StringBuilder::new()
  out.write_string(
    "<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 \{self.width()*cell} \{self.height()*cell}\" role=\"img\" aria-label=\"Weaving drawdown: warp above shown in first color\">\n",
  )
  out.write_string(
    "<rect width=\"100%\" height=\"100%\" fill=\"\{weft_color}\"/>\n",
  )
  for y, row in self.drawdown() {
    for x, raised in row {
      if raised {
        out.write_string(
          "<rect x=\"\{x*cell}\" y=\"\{y*cell}\" width=\"\{cell}\" height=\"\{cell}\" fill=\"\{warp_color}\"/>\n",
        )
      }
    }
  }
  out.write_string("</svg>\n")
  Ok(out.to_string())
}
