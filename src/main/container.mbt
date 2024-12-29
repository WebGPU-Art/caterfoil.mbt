///|
fn comp_container() -> @caterfoil.CaterfoilRenderObject!@caterfoil.BuilderError {
  guard true else { raise @caterfoil.BuilderError("ok") }
  @caterfoil.group([
    // comp_quat_curve(),
    comp_hyper_cube!(),
    // comp_fly_city(times=10),
    comp_lamp_tree(times=10),
    comp_quat_tree(times=7),
    comp_quat_product(
      mode=Grid,
      times=400,
      width=1,
      multiplicand=@quaternion.new(w=1, x=0.01, y=0.02, z=0.0)
        .normalize()
        .scale(1.003),
    ),
    comp_axis!(width=4),
  ])
}
