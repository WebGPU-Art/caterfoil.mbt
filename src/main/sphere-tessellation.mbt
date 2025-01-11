///|
struct Triangle {
  a : Quaternion
  b : Quaternion
  c : Quaternion
}

///|
fn Triangle::new(a : Quaternion, b : Quaternion, c : Quaternion) -> Triangle {
  Triangle::{ a, b, c }
}

///| split the triangle into 4 triangles from middle points of each edge
fn Triangle::split_4(self : Triangle) -> Array[Triangle] {
  let ab = (self.a + self.b).scale(0.5).normalize()
  let bc = (self.b + self.c).scale(0.5).normalize()
  let ca = (self.c + self.a).scale(0.5).normalize()
  [
    Triangle::new(self.a, ab, ca),
    Triangle::new(ab, self.b, bc),
    Triangle::new(bc, self.c, ca),
    Triangle::new(ab, bc, ca),
  ]
}

///|
fn Triangle::lines_points(self : Triangle) -> Array[Quaternion] {
  [self.a, self.b, self.a, self.c, self.b, self.c]
}

///|
pub fn comp_sphere_tessellation(
  times? : Int
) -> @caterfoil.CaterfoilRenderObject {
  let p1 = Quaternion::new(x=1.0)
  let p2 = Quaternion::new(x=-1.0)
  let p3 = Quaternion::new(y=1.0)
  let p4 = Quaternion::new(y=-1.0)
  let p5 = Quaternion::new(z=1.0)
  let p6 = Quaternion::new(z=-1.0)
  let p7 = Quaternion::new(w=1.0)
  let p8 = Quaternion::new(w=-1.0)
  let mut triangles : Array[Triangle] = [
    // group 135
    Triangle::new(p1, p3, p5),
    Triangle::new(p1, p3, p6),
    Triangle::new(p1, p4, p5),
    Triangle::new(p1, p4, p6),
    Triangle::new(p2, p3, p5),
    Triangle::new(p2, p3, p6),
    Triangle::new(p2, p4, p5),
    Triangle::new(p2, p4, p6),
    // group 137
    Triangle::new(p1, p3, p7),
    Triangle::new(p1, p3, p8),
    Triangle::new(p1, p4, p7),
    Triangle::new(p1, p4, p8),
    Triangle::new(p2, p3, p7),
    Triangle::new(p2, p3, p8),
    Triangle::new(p2, p4, p7),
    Triangle::new(p2, p4, p8),
    // group 157
    Triangle::new(p1, p5, p7),
    Triangle::new(p1, p5, p8),
    Triangle::new(p1, p6, p7),
    Triangle::new(p1, p6, p8),
    Triangle::new(p2, p5, p7),
    Triangle::new(p2, p5, p8),
    Triangle::new(p2, p6, p7),
    Triangle::new(p2, p6, p8),
    // group 357
    Triangle::new(p3, p5, p7),
    Triangle::new(p3, p5, p8),
    Triangle::new(p3, p6, p7),
    Triangle::new(p3, p6, p8),
    Triangle::new(p4, p5, p7),
    Triangle::new(p4, p5, p8),
    Triangle::new(p4, p6, p7),
    Triangle::new(p4, p6, p8),
  ]
  let times = times.or(5)
  for i = 0; i < times; i = i + 1 {
    let next_triangles : Array[Triangle] = []
    for triangle in triangles {
      for t in triangle.split_4() {
        next_triangles.push(t)
      }
    }
    triangles = next_triangles
  }
  let data = []
  for idx, triangle in triangles.iter2() {
    let at = idx.to_float() / triangles.length().to_float()
    let color = if at < 0.25 {
      Color::orange()
    } else if at < 0.5 {
      Color::green()
    } else if at < 0.75 {
      Color::gray()
    } else {
      Color::blue_brigher()
    }
    let lines = triangle.lines_points()
    for point in lines {
      let v = Vertex::{ position: point.scale(80.0), color }
      data.push(v)
    }
  }
  @caterfoil.object(
    label="sphere-tessellation",
    topology=LineList,
    data=WithPoints(data),
  )
}
