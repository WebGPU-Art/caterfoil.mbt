///|
fn comp_axis(
  width? : Float
) -> @caterfoil.CaterfoilRenderObject!@caterfoil.BuilderError {
  let short = 20.0.to_float()
  let long = 400.0.to_float()
  let axis_x : Array[@caterfoil.Vertex] = [
    { position: Quaternion::new(x=-short), color: Color::yellow(a=0.3) },
    { position: Quaternion::new(x=long), color: Color::yellow() },
  ]
  let axis_y : Array[@caterfoil.Vertex] = [
    { position: Quaternion::new(y=-short), color: Color::orange(a=0.3) },
    { position: Quaternion::new(y=long), color: Color::orange() },
  ]
  let axis_z : Array[@caterfoil.Vertex] = [
    { position: Quaternion::new(z=-short), color: Color::gray(a=0.3) },
    { position: Quaternion::new(z=long), color: Color::gray() },
  ]
  let axis_w : Array[@caterfoil.Vertex] = [
    { position: Quaternion::new(w=-short), color: Color::blue_brigher(a=0.3) },
    { position: Quaternion::new(w=long), color: Color::blue_brigher() },
  ]
  let triangles_list = @caterfoil.create_vertex_data!(axis_x, width=width.or(1)) +
    @caterfoil.create_vertex_data!(axis_y, width=width.or(1)) +
    @caterfoil.create_vertex_data!(axis_z, width=width.or(1)) +
    @caterfoil.create_vertex_data!(axis_w, width=width.or(1))
  @caterfoil.object(label="axis", data=WithTriangles(triangles_list))
}
