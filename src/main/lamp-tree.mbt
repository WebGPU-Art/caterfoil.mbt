///|
fn fold_line4(
  level : UInt,
  base : Quaternion,
  v : Quaternion,
  a : Quaternion,
  b : Quaternion,
  c : Quaternion,
  d : Quaternion,
  full_ : Quaternion,
  minimal_seg : Float,
) -> Array[Quaternion] {
  let v_ = v.op_mul(full_)
  let br_a = v_.op_mul(a)
  let br_b = v_.op_mul(b)
  let br_c = v_.op_mul(c)
  let br_d = v_.op_mul(d)
  if level == 0 || v.square_length() <= minimal_seg {
    [base.op_add(br_a), base.op_add(br_b), base.op_add(br_c), base.op_add(v)]
  } else {
    let l2 = level - 1
    fold_line4(l2, base, br_a, a, b, c, d, full_, minimal_seg) +
    fold_line4(
      l2,
      base.op_add(br_a),
      br_b.op_sub(br_a),
      a,
      b,
      c,
      d,
      full_,
      minimal_seg,
    ) +
    fold_line4(
      l2,
      base.op_add(br_b),
      br_c.op_sub(br_b),
      a,
      b,
      c,
      d,
      full_,
      minimal_seg,
    ) +
    fold_line4(
      l2,
      base.op_add(br_c),
      br_d.op_sub(br_c),
      a,
      b,
      c,
      d,
      full_,
      minimal_seg,
    ) +
    fold_line4(
      l2,
      base.op_add(br_d),
      v.op_sub(br_d),
      a,
      b,
      c,
      d,
      full_,
      minimal_seg,
    )
  }
}

///|
pub fn comp_lamp_tree(times? : UInt) -> @caterfoil.CaterfoilRenderObject {
  let lamp_tree = fold_line4(
    times.unwrap_or(10),
    Quaternion::default(),
    Quaternion::new(y=100.0),
    Quaternion::new(y=20.0, w=22.0),
    Quaternion::new(x=16.0, y=20.0, w=23.0),
    Quaternion::new(x=16.0, y=20.0, w=27.0),
    Quaternion::new(y=20.0, w=28.0),
    Quaternion::new(w=50.0).inverse(),
    0.02,
  )
  let data = []
  for point in lamp_tree {
    let v = Vertex::{
      position: Quaternion::new(x=point.x, y=point.y, z=point.z, w=point.w).scale(
        4.0,
      ),
      color: Color::new(r=1.0, g=1.0),
    }
    data.push(v)
  }
  @caterfoil.object(
    label="lamp-tree",
    topology=LineStrip,
    data=WithPoints(data),
  )
}

///|
pub fn comp_fly_city(times? : UInt) -> @caterfoil.CaterfoilRenderObject {
  let fly_city = fold_line4(
    times.unwrap_or(10),
    Quaternion::default(),
    Quaternion::new(x=200.0),
    Quaternion::new(y=20.0, w=25.0),
    Quaternion::new(x=5.0, y=20.0, z=10.0, w=25.0),
    Quaternion::new(x=5.0, y=20.0, z=10.0, w=15.0),
    Quaternion::new(y=20.0, w=15.0),
    Quaternion::new(w=50.0).inverse(),
    0.16,
  )
  let data = []
  for point in fly_city {
    let v = Vertex::{
      position: point.scale(4.0),
      color: Color::new(r=1.0, g=1.0),
    }
    data.push(v)
  }
  @caterfoil.object(
    label="lamp-tree",
    shader=@caterfoil.lines_wgsl(),
    topology=LineStrip,
    data=WithPoints(data),
  )
}
