/// Using Float in this module, MoonBit does not support generics in Trait yet.
///
//! a simpler quaternion math library with traits.
//!
//! ```moonbit
//! let a = Quaternion::{ w: 1.0, x: 2.0, y: 3.0, z: 4.0 };
//! a.w;
//!
//! // quick creates
//! let b1 = q(1.0, 2.0, 3.0, 4.0);
//!
//! // quick creates with integers
//! let b2 = qi(1, 2, 3, 4);
//!
//! b1 + b2;
//! b1 - b2;
//! b1 * b2;
//! b1 / b2;
//! b1.conjugate();
//! b1.scale(1.5);
//! b1.square_length();
//! b1.length();
//! b1.inverse();
//!```
//!
//! There are also mutable APIs:
//!
//! ```moonbit
//! let mut c = Quaternion::id();
//! let b = qi(1, 2, 3, 4);
//!
//! c += b;
//! c -= b;
//! c *= b;
//! // no division
//! c.inverse_mut();
//! c.conjugate_mut();
//! c.scale_mut(1.5);
//! ```
//!

// use std::ops::{Add, AddAssign, Div, Mul, MulAssign, Neg, Sub, SubAssign};

// use num_traits::Float;

///| Quaternion {w, x, y, z}
// #[derive(Debug, Copy, Clone)]
pub(all) struct Quaternion {
  mut w : Float
  mut x : Float
  mut y : Float
  mut z : Float
}

///| shortcut of create quaternion
pub fn q(w : Float, x : Float, y : Float, z : Float) -> Quaternion {
  Quaternion::{ w, x, y, z }
}

///| shortcut of creating quaternion from integers
pub fn qi(w : Int, x : Int, y : Int, z : Int) -> Quaternion {
  q(w.to_float(), x.to_float(), y.to_float(), z.to_float())
}

///| returns an identity quaternion
pub fn Quaternion::id() -> Quaternion {
  Quaternion::{ w: 1.0, x: 0.0, y: 0.0, z: 0.0 }
}

///| returns a quaternion from xyz
pub fn Quaternion::new(
  w : Float,
  x : Float,
  y : Float,
  z : Float
) -> Quaternion {
  Quaternion::{ w, x, y, z }
}

///| Scales a quaternion (element-wise) by a scalar, returns a new one
pub fn Quaternion::scale(self : Quaternion, t : Float) -> Quaternion {
  Quaternion::{ w: self.w * t, x: self.x * t, y: self.y * t, z: self.z * t }
}

///|
pub fn Quaternion::scale_mut(self : Quaternion, t : Float) -> Unit {
  self.w = self.w * t
  self.x = self.x * t
  self.y = self.y * t
  self.z = self.z * t
}

///| return a inverse of a quaternion
pub fn Quaternion::inverse(self : Quaternion) -> Quaternion {
  self.scale(1.0.to_float() / self.square_length()).conjugate()
}

///| mutable version of inverse
pub fn Quaternion::inverse_mut(self : Quaternion) -> Unit {
  self.scale_mut(1.0.to_float() / self.square_length())
  self.conjugate_mut()
}

///| returns dot product of two quaternions
pub fn Quaternion::dot(self : Quaternion, other : Quaternion) -> Float {
  self.w * other.w + self.x * other.x + self.y * other.y + self.z * other.z
}

///| Takes the quaternion conjugate, returns a new one.
pub fn Quaternion::conjugate(self : Quaternion) -> Quaternion {
  Quaternion::{ w: self.w, x: -self.x, y: -self.y, z: -self.z }
}

///| mutable version of conjugate
pub fn Quaternion::conjugate_mut(self : Quaternion) -> Unit {
  self.x = -self.x
  self.y = -self.y
  self.z = -self.z
}

///| Computes the square length of a quaternion.
pub fn Quaternion::square_length(self : Quaternion) -> Float {
  self.w * self.w + self.x * self.x + self.y * self.y + self.z * self.z
}

///| Computes the length of a quaternion.
pub fn Quaternion::length(self : Quaternion) -> Float {
  self.square_length().sqrt()
}

///|
impl Default for Quaternion with default() {
  Quaternion::{ w: 0.0, x: 0.0, y: 0.0, z: 0.0 }
}

///|
pub let max_value : Float = (0x7F7FFFFF).reinterpret_as_float()

///| Returns true if the two quaternions very cloase, compared like:
/// ```ignore
/// |a-b|^2 < epsilon
/// ```
fn Quaternion::op_eq(self : Quaternion, other : Quaternion) -> Bool {
  (self - other).square_length() < 1.0.to_float() / max_value
}

///| Adds two quaternions, returns a new one.
fn Quaternion::add(self : Quaternion, other : Quaternion) -> Quaternion {
  Quaternion::{
    w: self.w + other.w,
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
  }
}

///| Adds two quaternions, returns a new one.
fn Quaternion::op_add_assign(self : Quaternion, other : Quaternion) -> Unit {
  self.w = self.w + other.w
  self.x = self.x + other.x
  self.y = self.y + other.y
  self.z = self.z + other.z
}

///| Multiplies two quaternions, returns a new one.
fn Quaternion::op_mul(self : Quaternion, other : Quaternion) -> Quaternion {
  Quaternion::{
    w: self.w * other.w - self.x * other.x - self.y * other.y - self.z * other.z,
    x: self.w * other.x + self.x * other.w + self.y * other.z - self.z * other.y,
    y: self.w * other.y - self.x * other.z + self.y * other.w + self.z * other.x,
    z: self.w * other.z + self.x * other.y - self.y * other.x + self.z * other.w,
  }
}

///| Multiplies two quaternions, returns a new one.
fn Quaternion::op_mul_assign(self : Quaternion, other : Quaternion) -> Unit {
  let w = self.w * other.w -
    self.x * other.x -
    self.y * other.y -
    self.z * other.z
  let x = self.w * other.x +
    self.x * other.w +
    self.y * other.z -
    self.z * other.y
  let y = self.w * other.y -
    self.x * other.z +
    self.y * other.w +
    self.z * other.x
  let z = self.w * other.z +
    self.x * other.y -
    self.y * other.x +
    self.z * other.w
  self.w = w
  self.x = x
  self.y = y
  self.z = z
}

///|
fn Quaternion::op_div(self : Quaternion, b : Quaternion) -> Quaternion {
  self.op_mul(b.inverse())
}

///| substraction of two quaternions, returning new value
fn Quaternion::op_sub(self : Quaternion, other : Quaternion) -> Quaternion {
  Quaternion::{
    w: self.w - other.w,
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
  }
}

///| substraction of two quaternions, returning new value
fn Quaternion::op_sub_assign(self : Quaternion, other : Quaternion) -> Unit {
  self.w = self.w - other.w
  self.x = self.x - other.x
  self.y = self.y - other.y
  self.z = self.z - other.z
}

///| negate number
fn Quaternion::op_neg(self : Quaternion) -> Quaternion {
  Quaternion::{ w: -self.w, x: -self.x, y: -self.y, z: -self.z }
}

///| Construct a quaternion representing the given euler angle rotations (in radians)
pub fn Quaternion::from_euler_angles(
  x : Float,
  y : Float,
  z : Float
) -> Quaternion {
  let two : Float = 2.0
  let half_x = x / two
  let half_y = y / two
  let half_z = z / two
  let cos_x_2 = @math.cos(half_x.to_double()).to_float()
  let cos_y_2 = @math.cos(half_y.to_double()).to_float()
  let cos_z_2 = @math.cos(half_z.to_double()).to_float()
  let sin_x_2 = @math.sin(half_x.to_double()).to_float()
  let sin_y_2 = @math.sin(half_y.to_double()).to_float()
  let sin_z_2 = @math.sin(half_z.to_double()).to_float()
  Quaternion::{
    w: cos_x_2 * cos_y_2 * cos_z_2 + sin_x_2 * sin_y_2 * sin_z_2,
    x: sin_x_2 * cos_y_2 * cos_z_2 + cos_x_2 * sin_y_2 * sin_z_2,
    y: cos_x_2 * sin_y_2 * cos_z_2 + sin_x_2 * cos_y_2 * sin_z_2,
    z: cos_x_2 * cos_y_2 * sin_z_2 + sin_x_2 * sin_y_2 * cos_z_2,
  }
}
