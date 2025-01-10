///|
pub fn comp_hyper_cube() ->
     @caterfoil.CaterfoilRenderObject!@caterfoil.BuilderError {
  let unit = 80.0.to_float()
  let p1 = @quaternion.q(-unit, -unit, -unit, -unit)
  let p2 = @quaternion.q(unit, -unit, -unit, -unit)
  let p3 = @quaternion.q(unit, -unit, unit, -unit)
  let p4 = @quaternion.q(-unit, -unit, unit, -unit)
  let p5 = @quaternion.q(-unit, unit, -unit, -unit)
  let p6 = @quaternion.q(unit, unit, -unit, -unit)
  let p7 = @quaternion.q(unit, unit, unit, -unit)
  let p8 = @quaternion.q(-unit, unit, unit, -unit)
  let p11 = @quaternion.q(-unit, -unit, -unit, unit)
  let p12 = @quaternion.q(unit, -unit, -unit, unit)
  let p13 = @quaternion.q(unit, -unit, unit, unit)
  let p14 = @quaternion.q(-unit, -unit, unit, unit)
  let p15 = @quaternion.q(-unit, unit, -unit, unit)
  let p16 = @quaternion.q(unit, unit, -unit, unit)
  let p17 = @quaternion.q(unit, unit, unit, unit)
  let p18 = @quaternion.q(-unit, unit, unit, unit)
  let white = Color::new(r=1.0, g=0.5, b=0.2, a=0.6)
  let data = @caterfoil.create_vertex_data!([
      { position: p1, color: white },
      { position: p2, color: white },
    ]) +
    @caterfoil.create_vertex_data!([
      { position: p3, color: white },
      { position: p2, color: white },
    ]) +
    @caterfoil.create_vertex_data!([
      { position: p3, color: white },
      { position: p4, color: white },
    ]) +
    @caterfoil.create_vertex_data!([
      { position: p4, color: white },
      { position: p1, color: white },
    ]) +
    @caterfoil.create_vertex_data!([
      { position: p5, color: white },
      { position: p6, color: white },
    ]) +
    @caterfoil.create_vertex_data!([
      { position: p6, color: white },
      { position: p7, color: white },
    ]) +
    @caterfoil.create_vertex_data!([
      { position: p7, color: white },
      { position: p8, color: white },
    ]) +
    @caterfoil.create_vertex_data!([
      { position: p8, color: white },
      { position: p5, color: white },
    ]) +
    @caterfoil.create_vertex_data!([
      { position: p1, color: white },
      { position: p5, color: white },
    ]) +
    @caterfoil.create_vertex_data!([
      { position: p2, color: white },
      { position: p6, color: white },
    ]) +
    @caterfoil.create_vertex_data!([
      { position: p3, color: white },
      { position: p7, color: white },
    ]) +
    @caterfoil.create_vertex_data!([
      { position: p4, color: white },
      { position: p8, color: white },
    ]) +
    // Upper
    @caterfoil.create_vertex_data!([
      { position: p11, color: white },
      { position: p12, color: white },
    ]) +
    @caterfoil.create_vertex_data!([
      { position: p12, color: white },
      { position: p13, color: white },
    ]) +
    @caterfoil.create_vertex_data!([
      { position: p13, color: white },
      { position: p14, color: white },
    ]) +
    @caterfoil.create_vertex_data!([
      { position: p14, color: white },
      { position: p11, color: white },
    ]) +
    @caterfoil.create_vertex_data!([
      { position: p15, color: white },
      { position: p16, color: white },
    ]) +
    @caterfoil.create_vertex_data!([
      { position: p16, color: white },
      { position: p17, color: white },
    ]) +
    @caterfoil.create_vertex_data!([
      { position: p17, color: white },
      { position: p18, color: white },
    ]) +
    @caterfoil.create_vertex_data!([
      { position: p18, color: white },
      { position: p15, color: white },
    ]) +
    @caterfoil.create_vertex_data!([
      { position: p11, color: white },
      { position: p15, color: white },
    ]) +
    @caterfoil.create_vertex_data!([
      { position: p12, color: white },
      { position: p16, color: white },
    ]) +
    @caterfoil.create_vertex_data!([
      { position: p13, color: white },
      { position: p17, color: white },
    ]) +
    @caterfoil.create_vertex_data!([
      { position: p14, color: white },
      { position: p18, color: white },
    ]) +
    // conect
    @caterfoil.create_vertex_data!([
      { position: p1, color: white },
      { position: p11, color: white },
    ]) +
    @caterfoil.create_vertex_data!([
      { position: p2, color: white },
      { position: p12, color: white },
    ]) +
    @caterfoil.create_vertex_data!([
      { position: p3, color: white },
      { position: p13, color: white },
    ]) +
    @caterfoil.create_vertex_data!([
      { position: p4, color: white },
      { position: p14, color: white },
    ]) +
    @caterfoil.create_vertex_data!([
      { position: p5, color: white },
      { position: p15, color: white },
    ]) +
    @caterfoil.create_vertex_data!([
      { position: p6, color: white },
      { position: p16, color: white },
    ]) +
    @caterfoil.create_vertex_data!([
      { position: p7, color: white },
      { position: p17, color: white },
    ]) +
    @caterfoil.create_vertex_data!([
      { position: p8, color: white },
      { position: p18, color: white },
    ])
  @caterfoil.object(label="hyper-cube", data=WithTriangles(data))
}
