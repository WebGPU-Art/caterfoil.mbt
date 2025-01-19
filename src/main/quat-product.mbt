///|
enum DemoMode {
  Single
  Grid
}

///|
pub fn comp_quat_product(
  mode? : DemoMode,
  times? : Int,
  width? : Float,
  multiplicand? : Quaternion
) -> @caterfoil.CaterfoilRenderObject {
  let mut data : Array[PolylineVertex] = []
  let multiplicand = multiplicand.or(
    @quaternion.Quaternion::new(w=1.0, x=0.08).normalize().scale(1.006),
  )
  fn iterate(p0 : Quaternion, times : Int) -> Unit {
    let mut p = p0
    // println("p: \{p}")
    let trail : Array[Vertex] = []
    trail.push({ position: p.scale(20), color: Color::white(a=0.2) })
    for m = 0; m < times; m = m + 1 {
      p = p * multiplicand
      trail.push({ position: p.scale(20), color: Color::white(a=0.4) })
    }
    data = data +
      @caterfoil.create_vertex_data?(trail, width=width.or(0.6)).unwrap()
  }

  match mode.or(Single) {
    Single => {
      let p = @quaternion.qi(1, 4, 3, 4).scale(0.2)
      iterate(p, times.or(200))
    }
    Grid => {
      let size : Int = 2
      for i = 0; i < size; i = i + 1 {
        for j = 0; j < size; j = j + 1 {
          for k = 0; k < size; k = k + 1 {
            for l = 0; l < size; l = l + 1 {
              let p = @quaternion.qi(i, j, k, l).scale(2)
              iterate(p, times.or(200))
            }
          }
        }
      }
    }
  }
  @caterfoil.object(label="curve", data=WithTriangles(data))
}
