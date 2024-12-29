///|
fn comp_container() -> @caterfoil.CaterfoilRenderObject!@caterfoil.BuilderError {
  guard true else { raise @caterfoil.BuilderError("ok") }
  @caterfoil.group([
      // comp_quat_curve(),
      // comp_hyper_cube!(),
      // comp_fly_city(),
      comp_lamp_tree(),
      // comp_quat_tree(),
      comp_quat_product(
        mode=Grid,
        times=400,
        width=2,
        multiplicand=@quaternion.new(w=1, x=0.04, y=0.01, z=0.02)
          .normalize()
          .scale(1.004),
      ),
      comp_axis!(width=4),
    ],
    //
  )
}
