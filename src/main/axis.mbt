///|
fn comp_axis() -> @caterfoil.CaterfoilRenderObject!@caterfoil.BuilderError {
  let axis_x : Array[@caterfoil.Vertex] = [
    {
      position: Quaternion::new(x=-100.0),
      color: @caterfoil.Color::new(r=0.5, g=0.5, b=0.5),
    },
    {
      position: Quaternion::new(x=100.0),
      color: @caterfoil.Color::new(r=0.5, g=0.5, b=0.5),
    },
  ]
  let axis_y : Array[@caterfoil.Vertex] = [
    {
      position: Quaternion::new(y=-100.0),
      color: @caterfoil.Color::new(r=0.5, g=0.5, b=0.5),
    },
    { position: Quaternion::new(y=100.0), color: @caterfoil.Color::new(g=1.0) },
  ]
  let axis_z : Array[@caterfoil.Vertex] = [
    { position: Quaternion::new(z=-100.0), color: @caterfoil.Color::new(g=1.0) },
    { position: Quaternion::new(z=100.0), color: @caterfoil.Color::new(r=1.0) },
  ]
  let axis_w : Array[@caterfoil.Vertex] = [
    { position: Quaternion::new(w=-100.0), color: @caterfoil.Color::new(r=1.0) },
    { position: Quaternion::new(w=100.0), color: @caterfoil.Color::new(r=1.0) },
  ]
  let triangles_list = @caterfoil.create_vertex_data!(axis_x, width=4) +
    @caterfoil.create_vertex_data!(axis_y, width=4) +
    @caterfoil.create_vertex_data!(axis_z, width=4) +
    @caterfoil.create_vertex_data!(axis_w, width=4)
  @caterfoil.object({
    label: "triangle",
    shader: @caterfoil.polyline_wgsl(),
    topology: TriangleList,
    attrs_list: @caterfoil.PolylineVertex::attrs(),
    data: triangles_list,
    indices: None,
    get_params: None,
  })
}
