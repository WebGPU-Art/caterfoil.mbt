///|
pub fn comp_quat_curve() -> @caterfoil.CaterfoilRenderObject {
  let data : Array[PolylineVertex] = []
  let points : Array[@quaternion.Quaternion] = []
  for i = 0; i < 100; i = i + 1 {
    // a spiral curve
    let t = i.to_float() / 10.0
    let x = t * 10.0
    let y = t * (@math.cos(t.to_double()) * 10.0).to_float()
    let z = t * (@math.sin(t.to_double()) * 10.0).to_float()
    let w = t * 1.0
    points.push({ x, y, z, w })
  }
  for i = 0; i < 99; i = i + 1 {
    // for each line segment, push two triangles, or 6 vertices
    let p0 = points[i]
    let p1 = points[i + 1]
    let length = (p1 - p0).length()
    let width = 2.0.to_float()
    let direction = (p1 - p0).scale(1.0.to_float() / length)
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
  @caterfoil.object(label="curve", data=WithTriangles(data))
}
