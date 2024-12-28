///|
fn comp_axis() -> @caterfoil.CaterfoilRenderObject!@caterfoil.BuilderError {
  let axis_x : Array[@caterfoil.Vertex] = [
    { position: Quaternion::new(x=-20.0), color: Color::yellow() },
    { position: Quaternion::new(x=200.0), color: Color::yellow() },
  ]
  let axis_y : Array[@caterfoil.Vertex] = [
    { position: Quaternion::new(y=-20.0), color: Color::orange() },
    { position: Quaternion::new(y=200.0), color: Color::orange() },
  ]
  let axis_z : Array[@caterfoil.Vertex] = [
    { position: Quaternion::new(z=-20.0), color: Color::gray() },
    { position: Quaternion::new(z=200.0), color: Color::gray() },
  ]
  let axis_w : Array[@caterfoil.Vertex] = [
    { position: Quaternion::new(w=-20.0), color: Color::blue_brigher() },
    { position: Quaternion::new(w=200.0), color: Color::blue_brigher() },
  ]
  let triangles_list = @caterfoil.create_vertex_data!(axis_x, width=1) +
    @caterfoil.create_vertex_data!(axis_y, width=1) +
    @caterfoil.create_vertex_data!(axis_z, width=2) +
    @caterfoil.create_vertex_data!(axis_w, width=2)
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
