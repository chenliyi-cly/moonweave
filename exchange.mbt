///|
struct DraftData {
  schema : String
  shafts : Int
  threading : Array[Int]
  lifts : Array[Array[Int]]
} derive(ToJson, FromJson)

///|
/// Versioned JSON interchange. Limit text before parsing; core parser rejects excess nesting.
pub fn read_json(text : String) -> Result[Draft, String] {
  if text.length() > 1048576 {
    return Err("weave.json_size")
  }
  try {
    let mut depth = 0
    let mut quoted = false
    let mut escaped = false
    for c in text.iter() {
      if quoted {
        if escaped {
          escaped = false
        } else if c == '\\' {
          escaped = true
        } else if c == '"' {
          quoted = false
        }
      } else if c == '"' {
        quoted = true
      } else if c == '{' || c == '[' {
        depth = depth + 1
        if depth > 8 {
          return Err("weave.json_depth")
        }
      } else if c == '}' || c == ']' {
        depth = depth - 1
      }
    }
    let value = @json.parse(text)
    guard value is Object(fields) else { return Err("weave.json_object") }
    if fields.length() != 4 ||
      !fields.contains("schema") ||
      !fields.contains("shafts") ||
      !fields.contains("threading") ||
      !fields.contains("lifts") {
      return Err("weave.json_fields")
    }
    guard fields.get("shafts") is Some(Number(n, ..)) else {
      return Err("weave.json_integer")
    }
    if n < 1 || n > 64 || n != n.to_int().to_double() {
      return Err("weave.json_integer")
    }
    guard fields.get("threading") is Some(Array(threads)) else {
      return Err("weave.json_array")
    }
    guard fields.get("lifts") is Some(Array(rows)) else {
      return Err("weave.json_array")
    }
    if threads.length() > 2048 ||
      rows.length() > 2048 ||
      threads.length() * rows.length() > 262144 {
      return Err("weave.size")
    }
    let groups = [threads]
    for row in rows {
      guard row is Array(ids) else { return Err("weave.json_array") }
      if ids.length() > 64 {
        return Err("weave.lift")
      }
      groups.push(ids)
    }
    for group in groups {
      for item in group {
        guard item is Number(id, ..) else { return Err("weave.json_integer") }
        if id < 1 || id > 64 || id != id.to_int().to_double() {
          return Err("weave.json_integer")
        }
      }
    }
    let data : DraftData = @json.from_json(value)
    if data.schema != "moonweave/1" {
      return Err("weave.json_version")
    }
    draft(data.shafts, data.threading, data.lifts)
  } catch {
    _ => Err("weave.json_syntax_or_type")
  }
}

///|
pub fn Draft::write_json(self : Draft) -> String {
  let data : DraftData = {
    schema: "moonweave/1",
    shafts: self.shafts,
    threading: self.threads(),
    lifts: self.liftplan(),
  }
  data.to_json().stringify()
}
