///|
fn comp_cubic_gird(
  width? : Float
) -> @caterfoil.CaterfoilRenderObject!@caterfoil.BuilderError {

  // create lines of grid in 4 dimension, 4x4x4x4 cells, thus 5x5x5x5 lines
  let triangles_list : Array[@caterfoil.PolylineVertex] = []
  let unit : Float = 10.0
  let size = 16
  for ix = 0; ix <= size; ix = ix + 1 {
    for iy = 0; iy <= size; iy = iy + 1 {
      for iz = 0; iz <= size; iz = iz + 1 {
        for iw = 0; iw <= size; iw = iw + 1 {
          let x = ix.to_float() * unit - unit * size.to_float() * 0.5
          let y = iy.to_float() * unit - unit * size.to_float() * 0.5
          let z = iz.to_float() * unit - unit * size.to_float() * 0.5
          let w = iw.to_float() * unit - unit * size.to_float() * 0.5
          let p = Quaternion::new(x~, y~, z~, w~)
          // draw 4 lines of unit length in 4 directions
          if ix < size {
            let line : Array[@caterfoil.Vertex] = [
              { position: p, color: Color::yellow() },
              { position: p + Quaternion::new(x=unit), color: Color::yellow() },
            ]
            triangles_list.push_iter(
              @caterfoil.create_vertex_data!(line, width=width.or(1)).iter(),
            )
          }
          if iy < size {
            let line : Array[@caterfoil.Vertex] = [
              { position: p, color: Color::orange() },
              { position: p + Quaternion::new(y=unit), color: Color::orange() },
            ]
            triangles_list.push_iter(
              @caterfoil.create_vertex_data!(line, width=width.or(1)).iter(),
            )
          }
          if iz < size {
            let line : Array[@caterfoil.Vertex] = [
              { position: p, color: Color::gray() },
              { position: p + Quaternion::new(z=unit), color: Color::gray() },
            ]
            triangles_list.push_iter(
              @caterfoil.create_vertex_data!(line, width=width.or(1)).iter(),
            )
          }
          if iw < size {
            let line : Array[@caterfoil.Vertex] = [
              { position: p, color: Color::blue() },
              { position: p + Quaternion::new(w=unit), color: Color::blue() },
            ]
            triangles_list.push_iter(
              @caterfoil.create_vertex_data!(line, width=width.or(1)).iter(),
            )
          }
        }
      }
    }
  }
  @caterfoil.object(label="axis", data=WithTriangles(triangles_list))
}
