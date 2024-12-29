///|
fn comp_quat_product() -> @caterfoil.CaterfoilRenderObject {
  let mut data : Array[PolylineVertex] = []
  let size : Int = 2
  let times : Int = 160
  let multiplicand = @quaternion.new(w=1.0, x=0.08).normalize().scale(1.006)
  for i = 0; i < size; i = i + 1 {
    for j = 0; j < size; j = j + 1 {
      for k = 0; k < size; k = k + 1 {
        for l = 0; l < size; l = l + 1 {
          let mut p = @quaternion.qi(i, j, k, l).scale(2)
          // println("p: \{p}")
          let trail : Array[Vertex] = []
          trail.push({ position: p.scale(20), color: Color::white(a=0.2) })
          for m = 0; m < times; m = m + 1 {
            p = p * multiplicand
            trail.push({ position: p.scale(20), color: Color::white(a=0.4) })
          }
          data = data +
            @caterfoil.create_vertex_data?(trail, width=0.6).unwrap()
        }
      }
    }
  }
  @caterfoil.object({
    label: "curve",
    shader: @caterfoil.polyline_wgsl(),
    topology: TriangleList,
    attrs_list: PolylineVertex::attrs(),
    data: WithTriangles(data),
    indices: None,
    get_params: None,
  })
}
