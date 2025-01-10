///|
fn random_around(center : Float, range : Float) -> Float {
  center + range * (@caterfoil.math_random(1) - 0.5)
}

///|
fn rect(
  p1 : Quaternion,
  p2 : Quaternion,
  p3 : Quaternion,
  p4 : Quaternion,
  color? : Color
) -> Array[Vertex] {
  let color = color.or(Color::new(r=1.0, g=0.5, b=0.2, a=0.6))
  [
    { position: p1, color },
    { position: p2, color },
    { position: p3, color },
    //
    { position: p1, color },
    { position: p3, color },
    { position: p4, color },
  ]
}

///|
fn make_cube_data(
  offset : Quaternion,
  unit : Float,
  color : Color
) -> Array[Vertex] {
  let p1 = @quaternion.q(-unit, -unit, -unit, -unit) + offset
  let p2 = @quaternion.q(unit, -unit, -unit, -unit) + offset
  let p3 = @quaternion.q(unit, -unit, unit, -unit) + offset
  let p4 = @quaternion.q(-unit, -unit, unit, -unit) + offset
  let p5 = @quaternion.q(-unit, unit, -unit, -unit) + offset
  let p6 = @quaternion.q(unit, unit, -unit, -unit) + offset
  let p7 = @quaternion.q(unit, unit, unit, -unit) + offset
  let p8 = @quaternion.q(-unit, unit, unit, -unit) + offset
  let p11 = @quaternion.q(-unit, -unit, -unit, unit) + offset
  let p12 = @quaternion.q(unit, -unit, -unit, unit) + offset
  let p13 = @quaternion.q(unit, -unit, unit, unit) + offset
  let p14 = @quaternion.q(-unit, -unit, unit, unit) + offset
  let p15 = @quaternion.q(-unit, unit, -unit, unit) + offset
  let p16 = @quaternion.q(unit, unit, -unit, unit) + offset
  let p17 = @quaternion.q(unit, unit, unit, unit) + offset
  let p18 = @quaternion.q(-unit, unit, unit, unit) + offset
  let vertexes : Array[Vertex] = rect(p1, p2, p3, p4, color~) +
    rect(p5, p6, p7, p8, color~) +
    rect(p1, p2, p6, p5, color~) +
    rect(p2, p3, p7, p6, color~) +
    rect(p3, p4, p8, p7, color~) +
    rect(p4, p1, p5, p8, color~) +
    rect(p11, p12, p13, p14, color~) +
    rect(p15, p16, p17, p18, color~) +
    rect(p11, p12, p16, p15, color~) +
    rect(p12, p13, p17, p16, color~) +
    rect(p13, p14, p18, p17, color~) +
    rect(p14, p11, p15, p18, color~) +
    rect(p1, p2, p12, p11, color~) +
    rect(p2, p3, p13, p12, color~) +
    rect(p3, p4, p14, p13, color~) +
    rect(p4, p1, p11, p14, color~) +
    rect(p5, p6, p16, p15, color~) +
    rect(p6, p7, p17, p16, color~) +
    rect(p7, p8, p18, p17, color~) +
    rect(p8, p5, p15, p18, color~)
  vertexes
}

///|
pub fn comp_hyper_cube_grid() ->
     @caterfoil.CaterfoilRenderObject!@caterfoil.BuilderError {
  guard true else { raise @caterfoil.BuilderError("ok") }
  let unit = 20.0.to_float()
  let mut vertex_list : Array[Vertex] = []
  for i = 0; i < 200; i = i + 1 {
    let offset = @quaternion.q(
      random_around(0, 800),
      random_around(0, 800),
      random_around(0, 800),
      random_around(0, 800),
    )
    let white = Color::new(
      r=@caterfoil.math_random(1),
      g=@caterfoil.math_random(1),
      b=@caterfoil.math_random(1),
      a=0.6,
    )
    let vertexes = make_cube_data(offset, unit, white)
    vertex_list = vertex_list + vertexes
  }
  @caterfoil.object(
    label="hyper-cube-grid",
    topology=TriangleList,
    data=WithPoints(vertex_list),
  )
}
