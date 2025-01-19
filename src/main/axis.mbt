///|
/// Creates a visual representation of the 4D coordinate system axes, with each
/// axis having a different color and extending in both positive and negative
/// directions. The negative parts of the axes are rendered with more
/// transparency.
///
/// Parameters:
///
/// * `width` : Optional line width for the axes. If not specified, defaults to
/// 1.0.
///
/// Returns a `CaterfoilRenderObject` that can be used for rendering the
/// coordinate axes. The axes are colored as follows:
///
/// * X-axis: yellow
/// * Y-axis: orange
/// * Z-axis: gray
/// * W-axis: bright blue
///
/// Throws a `BuilderError` if there's an error during the creation of the render
/// object.
///
/// Example:
///
/// ```moonbit
/// test "comp_axis" {
///   let axes = comp_axis!(width=2.0)
///   inspect!(axes.label, content="\"axis\"")
/// }
/// ```
fn comp_axis(
  width? : Float
) -> @caterfoil.CaterfoilRenderObject!@caterfoil.BuilderError {
  let short = 20.0.to_float()
  let long = 200.0.to_float()
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
