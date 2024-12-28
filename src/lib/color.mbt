///|
pub(all) struct Color {
  r : Float
  g : Float
  b : Float
  a : Float
}

///|
pub fn Color::new(r? : Float, g? : Float, b? : Float, a? : Float) -> Color {
  Color::{
    r: r.or_default(),
    g: g.or_default(),
    b: b.or_default(),
    a: a.or_else(fn() { 1.0 }),
  }
}
