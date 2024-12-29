///|
fn comp_container() -> @caterfoil.CaterfoilRenderObject!@caterfoil.BuilderError {
  guard true else { raise @caterfoil.BuilderError("ok") }
  @caterfoil.group([
      comp_axis!(width=4),
      // comp_lamp_tree(),
      comp_hyper_cube!(),
    ],
    // comp_fly_city(),
    // comp_quat_tree(),
    // comp_quat_curve(),
    // comp_quat_product(),
    //
  )
}
