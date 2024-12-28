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

///|
pub fn Color::white() -> Color {
  Color::new(r=1.0, g=1.0, b=1.0)
}

///|
pub fn Color::black() -> Color {
  Color::new(r=0.0, g=0.0, b=0.0)
}

///|
pub fn Color::red() -> Color {
  Color::new(r=1.0, g=0.0, b=0.0)
}

///|
pub fn Color::green() -> Color {
  Color::new(r=0.0, g=1.0, b=0.0)
}

///|
pub fn Color::blue() -> Color {
  Color::new(r=0.0, g=0.0, b=1.0)
}

///|
pub fn Color::yellow() -> Color {
  Color::new(r=1.0, g=1.0, b=0.0)
}

///|
pub fn Color::magenta() -> Color {
  Color::new(r=1.0, g=0.0, b=1.0)
}

///|
pub fn Color::cyan() -> Color {
  Color::new(r=0.0, g=1.0, b=1.0)
}

///|
pub fn Color::gray() -> Color {
  Color::new(r=0.5, g=0.5, b=0.5)
}

// orange
///|
pub fn Color::orange() -> Color {
  Color::new(r=1.0, g=0.5, b=0.0)
}

///|
pub fn Color::blue_brigher() -> Color {
  Color::new(r=0.5, g=0.5, b=1.0)
}
