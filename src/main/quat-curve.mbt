///|
type! BuilderError String

///|
typealias PolylineVertex = @caterfoil.PolylineVertex

///| turn a chunk of vertices into triangles data
fn create_vertex_data(
  chunk : Array[@caterfoil.Vertex],
  width? : Float
) -> Array[@hashmap.T[String, Array[Float]]]!BuilderError {
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
    data.push(
      PolylineVertex::{
        position: vertex.position,
        color: vertex.color,
        direction,
        side: 0,
      }.to_value(),
    )
    data.push(
      PolylineVertex::{
        position: vertex_next.position,
        color: vertex_next.color,
        direction,
        side: 0,
      }.to_value(),
    )
    data.push(
      PolylineVertex::{
        position: vertex.position,
        color: vertex.color,
        direction,
        side: 1,
      }.to_value(),
    )
    data.push(
      PolylineVertex::{
        position: vertex.position,
        color: vertex.color,
        direction,
        side: 1,
      }.to_value(),
    )
    data.push(
      PolylineVertex::{
        position: vertex_next.position,
        color: vertex_next.color,
        direction,
        side: 1,
      }.to_value(),
    )
    data.push(
      PolylineVertex::{
        position: vertex_next.position,
        color: vertex_next.color,
        direction,
        side: 0,
      }.to_value(),
    )
  }
  data
}

///|
fn comp_quat_curve() -> @caterfoil.CaterfoilRenderObject {
  let data = []
  let points : Array[@quaternion.Quaternion] = []
  for i = 0; i < 100; i = i + 1 {
    // a spiral curve
    let t = i.to_float() / 10.0
    let x = t * 10.0
    let y = t * (@math.cos(t.to_double()) * 10.0).to_float()
    let z = t * (@math.sin(t.to_double()) * 10.0).to_float()
    let w = t * 1.0
    points.push({ x, y, z, w })
  }
  for i = 0; i < 99; i = i + 1 {
    // for each line segment, push two triangles, or 6 vertices
    let p0 = points[i]
    let p1 = points[i + 1]
    let length = (p1 - p0).length()
    let width = 2.0.to_float()
    let direction = (p1 - p0).scale(1.0.to_float() / length)
    let direction = direction.scale(width)
    let pos = p0
    let pos_next = p1
    let color = @caterfoil.Color::new(r=1.0)
    data.push(
      PolylineVertex::{ position: pos, color, direction, side: 0 }.to_value(),
    )
    data.push(
      PolylineVertex::{ position: pos_next, color, direction, side: 0 }.to_value(),
    )
    data.push(
      PolylineVertex::{ position: pos, color, direction, side: 1 }.to_value(),
    )
    data.push(
      PolylineVertex::{ position: pos, color, direction, side: 1 }.to_value(),
    )
    data.push(
      PolylineVertex::{ position: pos_next, color, direction, side: 1 }.to_value(),
    )
    data.push(
      PolylineVertex::{ position: pos_next, color, direction, side: 0 }.to_value(),
    )
  }
  @caterfoil.object({
    label: "triangle",
    shader: @caterfoil.polyline_wgsl(),
    topology: TriangleList,
    attrs_list: PolylineVertex::attrs(),
    data,
    indices: None,
    get_params: None,
  })
}
