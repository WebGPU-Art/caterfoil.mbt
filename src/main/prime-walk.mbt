///|
fn comp_prime_walk() -> @caterfoil.CaterfoilRenderObject raise @caterfoil.BuilderError {
  let unit = Float::from_double(2.0)
  let steps = [
    Quaternion::new(x=unit),
    Quaternion::new(y=unit),
    Quaternion::new(z=unit),
    Quaternion::new(w=unit),
    Quaternion::new(x=-unit),
    Quaternion::new(y=-unit),
    Quaternion::new(z=-unit),
    Quaternion::new(w=-unit),
  ]
  let mut position = Quaternion::new()
  let mut data : Array[@caterfoil.PolylineVertex] = []
  let mut prev : UInt = 0
  for idx, v in primes_list.iter2() {
    let step = steps[idx % steps.length()]
    // println(
    //   "v: " +
    //   v.to_string() +
    //   " " +
    //   (idx % 8).to_string() +
    //   " " +
    //   step.scale(v.to_float()).to_string(),
    // )
    let next_position = position.op_add(step.scale(Float::from_uint(v - prev)))
    // let color = Color::new(r=1.0, g=0.5, b=0.2, a=0.6)
    let trail : Array[@caterfoil.Vertex] = [
      { position, color: Color::blue_brigher() },
      { position: next_position, color: Color::blue_brigher() },
    ]
    let triangles_list = @caterfoil.create_vertex_data(trail, width=1)
    data = data + triangles_list
    position = next_position
    prev = v
  }
  println("data length: " + data.length().to_string())
  @caterfoil.object(label="prime-walk", data=WithTriangles(data))
}
