///|
fn fold_line4(
  level : UInt,
  base : @quaternion.Quaternion,
  v : @quaternion.Quaternion,
  a : @quaternion.Quaternion,
  b : @quaternion.Quaternion,
  c : @quaternion.Quaternion,
  d : @quaternion.Quaternion,
  full_ : @quaternion.Quaternion,
  minimal_seg : Float
) -> Array[@quaternion.Quaternion] {
  let v_ = v * full_
  let br_a = v_ * a
  let br_b = v_ * b
  let br_c = v_ * c
  let br_d = v_ * d
  if level == 0 || v.square_length() <= minimal_seg {
    [base + br_a, base + br_b, base + br_c, base + v]
  } else {
    let l2 = level - 1
    fold_line4(l2, base, br_a, a, b, c, d, full_, minimal_seg) +
    fold_line4(l2, base + br_a, br_b - br_a, a, b, c, d, full_, minimal_seg) +
    fold_line4(l2, base + br_b, br_c - br_b, a, b, c, d, full_, minimal_seg) +
    fold_line4(l2, base + br_c, br_d - br_c, a, b, c, d, full_, minimal_seg) +
    fold_line4(l2, base + br_d, v - br_d, a, b, c, d, full_, minimal_seg)
  }
}

///|
fn comp_lamp_tree() -> @caterfoil.CaterfoilRenderObject {
  let lamp_tree = fold_line4(
    // 14,
    10,
    @quaternion.Quaternion::default(),
    @quaternion.Quaternion::new(y=100.0),
    @quaternion.Quaternion::new(y=20.0, w=22.0),
    @quaternion.Quaternion::new(x=16.0, y=20.0, w=23.0),
    @quaternion.Quaternion::new(x=16.0, y=20.0, w=27.0),
    @quaternion.Quaternion::new(y=20.0, w=28.0),
    @quaternion.Quaternion::new(w=50.0).inverse(),
    0.02,
  )
  let data = []
  for point in lamp_tree {
    let v = Vertex::{
      position: Point4D::new(x=point.x, y=point.y, z=point.z, w=point.w).scale(
        4.0,
      ),
      color: Color::new(r=1.0, g=1.0),
    }
    data.push(v.to_value())
  }
  @caterfoil.object({
    label: "lamp-tree",
    shader: triangle_wgsl,
    topology: LineStrip,
    attrs_list: [
      { field: "position", format: Float32x4 },
      { field: "color", format: Float32x4 },
    ],
    data,
    indices: None,
    get_params: None,
  })
}

// :fly-city $ fold-line4 9 ([] 0 0 0 0) ([] 200 0 0 0) ([] 0 20 0 25) ([] 5 20 10 25) ([] 5 20 10 15) ([] 0 20 0 15)
//   q-inverse $ [] 0 0 0 50
//   , 0.16

///|
fn comp_fly_city() -> @caterfoil.CaterfoilRenderObject {
  let fly_city = fold_line4(
    // 14,
    10,
    @quaternion.Quaternion::default(),
    @quaternion.Quaternion::new(x=200.0),
    @quaternion.Quaternion::new(y=20.0, w=25.0),
    @quaternion.Quaternion::new(x=5.0, y=20.0, z=10.0, w=25.0),
    @quaternion.Quaternion::new(x=5.0, y=20.0, z=10.0, w=15.0),
    @quaternion.Quaternion::new(y=20.0, w=15.0),
    @quaternion.Quaternion::new(w=50.0).inverse(),
    0.16,
  )
  let data = []
  for point in fly_city {
    let v = Vertex::{
      position: Point4D::new(x=point.x, y=point.y, z=point.z, w=point.w).scale(
        4.0,
      ),
      color: Color::new(r=1.0, g=1.0),
    }
    data.push(v.to_value())
  }
  @caterfoil.object({
    label: "fly-city",
    shader: triangle_wgsl,
    topology: LineStrip,
    attrs_list: [
      { field: "position", format: Float32x4 },
      { field: "color", format: Float32x4 },
    ],
    data,
    indices: None,
    get_params: None,
  })
}
