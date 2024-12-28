///|
fn comp_container() -> @caterfoil.CaterfoilRenderObject!@caterfoil.BuilderError {
  @caterfoil.group([
    comp_axis!(),
    // comp_lamp_tree(),
    // comp_fly_city(),
    // comp_quat_tree(),
    // comp_quat_curve(),
    comp_quat_product(),
  ])
}
