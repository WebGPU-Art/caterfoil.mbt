///|
struct Point4D {
  x : Float
  y : Float
  z : Float
  w : Float
}

///|
fn Point4D::new(x? : Float, y? : Float, z? : Float, w? : Float) -> Point4D {
  Point4D::{
    x: x.or_default(),
    y: y.or_default(),
    z: z.or_default(),
    w: w.or_default(),
  }
}

///|
fn Point4D::scale(self : Point4D, t : Float) -> Point4D {
  Point4D::{ x: self.x * t, y: self.y * t, z: self.z * t, w: self.w * t }
}

///|
struct Color {
  r : Float
  g : Float
  b : Float
  a : Float
}

///|
fn Color::new(r? : Float, g? : Float, b? : Float, a? : Float) -> Color {
  Color::{
    r: r.or_default(),
    g: g.or_default(),
    b: b.or_default(),
    a: a.or_else(fn() { 1.0 }),
  }
}

///|
struct Vertex {
  position : Point4D
  color : Color
}

///|
fn Vertex::to_value(
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
fn comp_container() -> @caterfoil.CaterfoilRenderObject {
  let data = []
  let vertex_list = [
    { position: Point4D::new(x=-100.0), color: Color::new(r=0.5, g=0.5, b=0.5) },
    { position: Point4D::new(x=100.0), color: Color::new(r=0.5, g=0.5, b=0.5) },
    { position: Point4D::new(y=-100.0), color: Color::new(r=0.5, g=0.5, b=0.5) },
    { position: Point4D::new(y=100.0), color: Color::new(g=1.0) },
    { position: Point4D::new(z=-100.0), color: Color::new(g=1.0) },
    { position: Point4D::new(z=100.0), color: Color::new(r=1.0) },
    { position: Point4D::new(w=-100.0), color: Color::new(r=1.0) },
    { position: Point4D::new(w=100.0), color: Color::new(r=1.0) },
  ]
  for vertex in vertex_list {
    data.push(vertex.to_value())
  }
  @caterfoil.group([
    // comp_lamp_tree(),
    comp_fly_city(),
    @caterfoil.object({
      label: "triangle",
      shader: triangle_wgsl,
      topology: LineList,
      attrs_list: [
        { field: "position", format: Float32x4 },
        { field: "color", format: Float32x4 },
      ],
      data,
      indices: None,
      get_params: None,
    }),
  ])
}
