///|
pub fn comp_quat_curve() -> @caterfoil.CaterfoilRenderObject {
  let data : Array[PolylineVertex] = []
  let points : Array[@quaternion.Quaternion] = []
  for i = 0; i < 100; i = i + 1 {
    // a spiral curve
    let t = Float::from_int(i) / 10.0 + 10.0
    let x = t * 4.0
    let y = t * Float::from_double(@math.cos(t.to_double()) * 4.0)
    let z = t * Float::from_double(@math.sin(t.to_double()) * 4.0)
    let w = Float::from_double(0.0)
    points.push({ x, y, z, w })
  }
  for i = 0; i < 99; i = i + 1 {
    // for each line segment, push two triangles, or 6 vertices
    let p0 = points[i]
    let p1 = points[i + 1]
    let length = p1.op_sub(p0).length()
    let width = Float::from_double(2.0)
    let direction = p1.op_sub(p0).scale(Float::from_double(1.0) / length)
    let direction = direction.scale(width)
    let pos = p0
    let pos_next = p1
    let color = Color::new(r=1.0)
    data.push({ position: pos, color, direction, side: 0 })
    data.push({ position: pos_next, color, direction, side: 0 })
    data.push({ position: pos, color, direction, side: 1 })
    data.push({ position: pos, color, direction, side: 1 })
    data.push({ position: pos_next, color, direction, side: 1 })
    data.push({ position: pos_next, color, direction, side: 0 })
  }
  @caterfoil.object(
    label="curve",
    data=WithTriangles(data),
    topology=TriangleList,
  )
}
