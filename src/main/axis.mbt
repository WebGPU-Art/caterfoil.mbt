///|
fn comp_axis(
  width? : Float
) -> @caterfoil.CaterfoilRenderObject!@caterfoil.BuilderError {
  let axis_x : Array[@caterfoil.Vertex] = [
    { position: Quaternion::new(x=-20.0), color: Color::yellow(a=0.3) },
    { position: Quaternion::new(x=200.0), color: Color::yellow() },
  ]
  let axis_y : Array[@caterfoil.Vertex] = [
    { position: Quaternion::new(y=-20.0), color: Color::orange(a=0.3) },
    { position: Quaternion::new(y=200.0), color: Color::orange() },
  ]
  let axis_z : Array[@caterfoil.Vertex] = [
    { position: Quaternion::new(z=-20.0), color: Color::gray(a=0.3) },
    { position: Quaternion::new(z=200.0), color: Color::gray() },
  ]
  let axis_w : Array[@caterfoil.Vertex] = [
    { position: Quaternion::new(w=-20.0), color: Color::blue_brigher(a=0.3) },
    { position: Quaternion::new(w=200.0), color: Color::blue_brigher() },
  ]
  let triangles_list = @caterfoil.create_vertex_data!(axis_x, width=width.or(1)) +
    @caterfoil.create_vertex_data!(axis_y, width=width.or(1)) +
    @caterfoil.create_vertex_data!(axis_z, width=width.or(1)) +
    @caterfoil.create_vertex_data!(axis_w, width=width.or(1))
  @caterfoil.object(label="axis", data=WithTriangles(triangles_list))
}
