///|
struct Branch {
  from : @quaternion.Quaternion
  to : @quaternion.Quaternion
}

///|
struct BaseBranch {
  line : @quaternion.Quaternion
}

///|
let ratio : Float = -0.27

///|
let r2 : Float = ratio

///|
let transformers : Array[BaseBranch] = [
  { line: @quaternion.q(ratio, r2, 0.0, 0.0) },
  { line: @quaternion.q(ratio, -r2, 0.0, 0.0) },
  { line: @quaternion.q(ratio, 0.0, r2, 0.0) },
  { line: @quaternion.q(ratio, 0.0, -r2, 0.0) },
  { line: @quaternion.q(ratio, 0.0, 0.0, r2) },
  { line: @quaternion.q(ratio, 0.0, 0.0, -r2) },
]

///|
fn generate_lines(
  base : @quaternion.Quaternion,
  l0 : @quaternion.Quaternion,
  level : UInt
) -> Iter[Branch] {
  let line_to = base + l0
  let next : Iter[Branch] = if level > 0 {
    transformers
    .iter()
    .flat_map(fn(info) {
      let trans = info.line
      return generate_lines(line_to, l0 * trans, level - 1)
    })
  } else {
    [].iter()
  }
  return ([{ from: base, to: line_to }].iter() + next.iter()).iter()
}

///|
fn comp_quat_tree() -> @caterfoil.CaterfoilRenderObject {
  let p0 = @quaternion.q(0, 0, -15, 0)
  let l0 = @quaternion.q(0, 0, 20, 0)
  let lines = generate_lines(p0, l0, 8)
  let scaled = 20.0.to_float()
  let data = []
  for branch in lines {
    let v = @caterfoil.Vertex::{
      position: @caterfoil.Point4D::new(
        x=branch.from.x,
        y=branch.from.y,
        z=branch.from.z,
        w=branch.from.w,
      ).scale(scaled),
      color: @caterfoil.Color::new(r=1.0, g=1.0),
    }
    data.push(v.to_value())
    let v = @caterfoil.Vertex::{
      position: @caterfoil.Point4D::new(
        x=branch.to.x,
        y=branch.to.y,
        z=branch.to.z,
        w=branch.to.w,
      ).scale(scaled),
      color: @caterfoil.Color::new(r=1.0, g=1.0),
    }
    data.push(v.to_value())
  }
  @caterfoil.object({
    label: "fly-city",
    shader: triangle_wgsl,
    topology: LineList,
    attrs_list: [
      { field: "position", format: Float32x4 },
      { field: "color", format: Float32x4 },
    ],
    data,
    indices: None,
    get_params: None,
  })
}
