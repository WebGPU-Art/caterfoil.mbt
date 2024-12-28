///|
fn comp_container() -> @caterfoil.CaterfoilRenderObject!BuilderError {
  @caterfoil.group([
    // comp_lamp_tree(),
    // comp_fly_city(),
    comp_axis!(),
    // comp_quat_tree(),
    comp_quat_curve(),
  ])
}
