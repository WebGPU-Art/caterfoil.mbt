///|
fn comp_cubic_array(
  width? : Float,
) -> @caterfoil.CaterfoilRenderObject raise @caterfoil.BuilderError {

  // create lines of grid in 4 dimension, 4x4x4x4 cells, thus 5x5x5x5 lines
  let triangles_list : Array[@caterfoil.PolylineVertex] = []
  let unit : Float = 60.0
  let size = 26
  let size_f = Float::from_int(size)
  for ix = 0; ix <= size; ix = ix + 1 {
    for iy = 0; iy <= size; iy = iy + 1 {
      for iz = 0; iz <= size; iz = iz + 1 {
        for iw = 0; iw <= size; iw = iw + 1 {
          let x = Float::from_int(ix) * unit - unit * size_f * 0.5
          let y = Float::from_int(iy) * unit - unit * size_f * 0.5
          let z = Float::from_int(iz) * unit - unit * size_f * 0.5
          let w = Float::from_int(iw) * unit - unit * size_f * 0.5
          let p = Quaternion::new(x~, y~, z~, w~)
          // draw 4 lines of unit length in 4 directions
          if ix == 0 {
            let line : Array[@caterfoil.Vertex] = [
              { position: p, color: Color::orange() },
              {
                position: p.op_add(Quaternion::new(x=unit * size_f)),
                color: Color::orange(),
              },
            ]
            triangles_list.push_iter(
              @caterfoil.create_vertex_data(line, width=width.unwrap_or(1.0)).iter(),
            )
          }
          if iy == 0 {
            let line : Array[@caterfoil.Vertex] = [
              { position: p, color: Color::green() },
              {
                position: p.op_add(Quaternion::new(y=unit * size_f)),
                color: Color::green(),
              },
            ]
            triangles_list.push_iter(
              @caterfoil.create_vertex_data(line, width=width.unwrap_or(1.0)).iter(),
            )
          }
          if iz == 0 {
            let line : Array[@caterfoil.Vertex] = [
              { position: p, color: Color::gray() },
              {
                position: p.op_add(Quaternion::new(z=unit * size_f)),
                color: Color::gray(),
              },
            ]
            triangles_list.push_iter(
              @caterfoil.create_vertex_data(line, width=width.unwrap_or(1.0)).iter(),
            )
          }
          if iw == 0 {
            let line : Array[@caterfoil.Vertex] = [
              { position: p, color: Color::blue_brigher() },
              {
                position: p.op_add(Quaternion::new(w=unit * size_f)),
                color: Color::blue_brigher(),
              },
            ]
            triangles_list.push_iter(
              @caterfoil.create_vertex_data(line, width=width.unwrap_or(1.0)).iter(),
            )
          }
        }
      }
    }
  }
  @caterfoil.object(label="axis", data=WithTriangles(triangles_list))
}
