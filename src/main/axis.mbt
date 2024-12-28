///|
fn comp_axis() -> @caterfoil.CaterfoilRenderObject {
  let data = []
  let vertex_list : Array[@caterfoil.Vertex] = [
    {
      position: @quaternion.Quaternion::new(x=-100.0),
      color: @caterfoil.Color::new(r=0.5, g=0.5, b=0.5),
    },
    {
      position: @quaternion.Quaternion::new(x=100.0),
      color: @caterfoil.Color::new(r=0.5, g=0.5, b=0.5),
    },
    {
      position: @quaternion.Quaternion::new(y=-100.0),
      color: @caterfoil.Color::new(r=0.5, g=0.5, b=0.5),
    },
    {
      position: @quaternion.Quaternion::new(y=100.0),
      color: @caterfoil.Color::new(g=1.0),
    },
    {
      position: @quaternion.Quaternion::new(z=-100.0),
      color: @caterfoil.Color::new(g=1.0),
    },
    {
      position: @quaternion.Quaternion::new(z=100.0),
      color: @caterfoil.Color::new(r=1.0),
    },
    {
      position: @quaternion.Quaternion::new(w=-100.0),
      color: @caterfoil.Color::new(r=1.0),
    },
    {
      position: @quaternion.Quaternion::new(w=100.0),
      color: @caterfoil.Color::new(r=1.0),
    },
  ]
  for vertex in vertex_list {
    data.push(vertex.to_value())
  }
  @caterfoil.object({
    label: "triangle",
    shader: triangle_wgsl,
    topology: LineList,
    attrs_list: @caterfoil.Vertex::attrs(),
    data,
    indices: None,
    get_params: None,
  })
}
