///|
struct Branch {
  from : Quaternion
  to : Quaternion
}

///|
struct BaseBranch {
  line : Quaternion
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
  base : Quaternion,
  l0 : Quaternion,
  level : UInt
) -> Iter[Branch] {
  let line_to = base + l0
  let next : Iter[Branch] = if level > 0 {
    transformers
    .iter()
    .flat_map(fn(info) {
      return generate_lines(line_to, l0 * info.line, level - 1)
    })
  } else {
    [].iter()
  }
  return ([{ from: base, to: line_to }].iter() + next.iter()).iter()
}

///|
pub fn comp_quat_tree(times? : UInt) -> @caterfoil.CaterfoilRenderObject {
  let p0 = @quaternion.q(0, 0, -15, 0)
  let l0 = @quaternion.q(0, 0, 20, 0)
  let lines = generate_lines(p0, l0, times.or(8))
  let scaled = 20.0.to_float()
  let data = []
  for branch in lines {
    let v = Vertex::{
      position: branch.from.scale(scaled),
      color: Color::new(r=1.0, g=1.0),
    }
    data.push(v)
    let v = Vertex::{
      position: branch.to.scale(scaled),
      color: Color::new(r=1.0, g=1.0),
    }
    data.push(v)
  }
  @caterfoil.object(label="tree", topology=LineList, data=WithPoints(data))
}
