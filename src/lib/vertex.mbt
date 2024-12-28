///|
pub(all) struct Vertex {
  position : @quaternion.Quaternion
  color : Color
}

///|
pub fn Vertex::attrs() -> Array[CaterfoilAttribute] {
  [
    { field: "position", format: Float32x4 },
    { field: "color", format: Float32x4 },
  ]
}

///|
pub fn Vertex::to_value(
  self : Vertex
) -> @moonbitlang/core/hashmap.T[String, Array[Float]] {
  let dict : @moonbitlang/core/hashmap.T[String, Array[Float]] = @moonbitlang/core/hashmap.new()
  dict["position"] = [
    self.position.x,
    self.position.y,
    self.position.z,
    self.position.w,
  ]
  dict["color"] = [self.color.r, self.color.g, self.color.b, self.color.a]
  dict
}

///|
pub(all) struct PolylineVertex {
  position : @quaternion.Quaternion
  color : Color
  direction : @quaternion.Quaternion
  side : Int
}

///|
pub fn PolylineVertex::to_value(
  self : PolylineVertex
) -> @moonbitlang/core/hashmap.T[String, Array[Float]] {
  let dict : @moonbitlang/core/hashmap.T[String, Array[Float]] = @moonbitlang/core/hashmap.new()
  dict["position"] = self.position.to_xyzw()
  dict["color"] = [self.color.r, self.color.g, self.color.b, self.color.a]
  dict["direction"] = self.direction.to_xyzw()
  dict["side"] = [self.side.to_float()] // need int but JavaScript auto converts
  dict
}

///|
pub fn PolylineVertex::attrs() -> Array[CaterfoilAttribute] {
  [
    { field: "position", format: Float32x4 },
    { field: "color", format: Float32x4 },
    { field: "direction", format: Float32x4 },
    { field: "side", format: Sint32 },
  ]
}

///|
pub(all) type! BuilderError String

///| turn a chunk of vertices into triangles data
pub fn create_vertex_data(
  chunk : Array[Vertex],
  width? : Float
) -> Array[PolylineVertex]!BuilderError {
  let data = []
  let size = chunk.length()
  if size < 2 {
    raise BuilderError("chunk size must be at least 2")
  }
  for i = 0; i < size - 1; i = i + 1 {
    let vertex = chunk[i]
    let vertex_next = chunk[i + 1]
    let direction = (vertex_next.position - vertex.position)
      .normalize()
      .scale(width.or(2.0))
    /// 2 triangles
    data.push(PolylineVertex::{
      position: vertex.position,
      color: vertex.color,
      direction,
      side: 0,
    })
    data.push(PolylineVertex::{
      position: vertex_next.position,
      color: vertex_next.color,
      direction,
      side: 0,
    })
    data.push(PolylineVertex::{
      position: vertex.position,
      color: vertex.color,
      direction,
      side: 1,
    })
    data.push(PolylineVertex::{
      position: vertex.position,
      color: vertex.color,
      direction,
      side: 1,
    })
    data.push(PolylineVertex::{
      position: vertex_next.position,
      color: vertex_next.color,
      direction,
      side: 1,
    })
    data.push(PolylineVertex::{
      position: vertex_next.position,
      color: vertex_next.color,
      direction,
      side: 0,
    })
  }
  data
}
