///|
enum Tab {
  QuatCurve
  HyperCube
  HyperCubeGrid
  FlyCity
  LampTree
  QuatTree
  QuatProduct
  PrimeWalk
  SphereTessellation
  CubeGrid
}

///|
fn Tab::default() -> Tab {
  CubeGrid
}

///|
fn Tab::from_string(s : String) -> Tab {
  match s {
    "quat-curve" => QuatCurve
    "hyper-cube" => HyperCube
    "hyper-cube-grid" => HyperCubeGrid
    "fly-city" => FlyCity
    "lamp-tree" => LampTree
    "quat-tree" => QuatTree
    "quat-product" => QuatProduct
    "prime-walk" => PrimeWalk
    "sphere-tess" => SphereTessellation
    "cubic-grid" => CubeGrid
    _ => {
      println("Unknown tab: " + s)
      Tab::default()
    }
  }
}

///|
let none : @caterfoil.CaterfoilRenderObject = @caterfoil.group([])

///|
fn comp_container(
  params : SearchParams
) -> @caterfoil.CaterfoilRenderObject!@caterfoil.BuilderError {
  guard true else { raise @caterfoil.BuilderError("ok") }
  @caterfoil.group([
    match params.tab {
      QuatCurve => comp_quat_curve()
      HyperCube => comp_hyper_cube!()
      HyperCubeGrid => comp_hyper_cube_grid!()
      FlyCity => comp_fly_city(times=10)
      LampTree => comp_lamp_tree(times=10)
      QuatTree => comp_quat_tree(times=7)
      QuatProduct =>
        comp_quat_product(
          mode=Grid,
          times=400,
          width=2,
          multiplicand=@quaternion.new(w=1, x=0.01, y=0.02, z=0.0)
            .normalize()
            .scale(1.003),
        )
      PrimeWalk => comp_prime_walk!()
      SphereTessellation => comp_sphere_tessellation()
      CubeGrid => comp_cubic_gird!(width=2)
    },
    if params.show_axis {
      comp_axis!(width=4)
    } else {
      none
    },
  ])
}
