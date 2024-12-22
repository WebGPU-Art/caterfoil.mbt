///|
struct Atom[T] {
  mut value : T
}

///|
pub fn Atom::with_value[T](value : T) -> Atom[T] {
  { value, }
}

///|
pub fn Atom::deref[T](self : Atom[T]) -> T {
  self.value
}

///|
pub fn Atom::reset[T](self : Atom[T], value : T) -> Unit {
  self.value = value
}
