///|
fn comp_axis() -> @caterfoil.CaterfoilRenderObject {
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
  })
}
