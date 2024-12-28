///|
pub(all) struct CaterfoilObjectOptions {
  label : String
  shader : String
  topology : ShaderPrimitiveTopology
  attrs_list : Array[CaterfoilAttribute]
  data : Array[@moonbitlang/core/hashmap.T[String, Array[Float]]] // not sure
  indices : Array[UInt]?
  get_params : (() -> Array[Float])?
}

///|
fn CaterfoilObjectOptions::as_value(self : CaterfoilObjectOptions) -> JsValue {
  let obj = JsObject::new()
  obj.set("label", JsValue::from_string(self.label))
  obj.set("shader", JsValue::from_string(self.shader))
  obj.set("topology", JsValue::from_string(self.topology.to_string()))
  let attrs_list = JsArray::new()
  for attr in self.attrs_list {
    attrs_list.push(attr.as_value())
  }
  obj.set("attrsList", attrs_list.as_value())
  let data = JsArray::new()
  for val in self.data {
    let obj = JsObject::new()
    for key, value in val {
      let arr = JsArray::new()
      for v in value {
        arr.push(JsValue::from_number(v))
      }
      obj.set(key, JsValue::from_array(arr))
    }
    data.push(JsValue::from_object(obj))
  }
  obj.set("data", data.as_value())
  // indices
  let get_params = fn() -> JsValue {
    match self.get_params {
      Some(f) =>
        JsValue::from_fn(fn() {
          let ret = f()
          let arr = JsArray::new()
          for val in ret {
            arr.push(JsValue::from_number(val))
          }
          arr.as_value()
        })
      None => JsValue::from_bool(false)
    }
  }
  obj.set("getParams", JsValue::from_fn(get_params))
  obj.as_value()
}

///|
pub(all) enum ShaderPrimitiveTopology {
  PointList
  LineList
  LineStrip
  TriangleList
  TriangleStrip
}

///|
fn ShaderPrimitiveTopology::default() -> ShaderPrimitiveTopology {
  LineList
}

///|
fn ShaderPrimitiveTopology::to_string(self : ShaderPrimitiveTopology) -> String {
  match self {
    PointList => "point-list"
    LineList => "line-list"
    LineStrip => "line-strip"
    TriangleList => "triangle-list"
    TriangleStrip => "triangle-strip"
  }
}

///| Converts the vertex format to its WebGPU string representation.
/// These strings match the format names in the WebGPU specification.
/// See: https://www.w3.org/TR/webgpu/#vertex-formats
pub(all) struct CaterfoilAttribute {
  field : String
  format : GPUVertexFormat
}

///|
fn CaterfoilAttribute::as_value(self : CaterfoilAttribute) -> JsValue {
  let obj = JsObject::new()
  obj.set("field", JsValue::from_string(self.field))
  obj.set("format", JsValue::from_string(self.format.to_string()))
  JsObject::as_value(obj)
}

///|
type CaterfoilRenderObject

///|
extern "js" fn CaterfoilRenderObject::as_value(
  self : CaterfoilRenderObject
) -> JsValue =
  #| (self) => self

///|
pub fn object(options : CaterfoilObjectOptions) -> CaterfoilRenderObject {
  caterfoil_object(options.as_value())
}

///|
pub fn group(children : Array[CaterfoilRenderObject]) -> CaterfoilRenderObject {
  let arr = JsArray::new()
  for child in children {
    arr.push(child.as_value())
  }
  caterfoil_group(arr)
}

///|
pub(all) struct Point4D {
  x : Float
  y : Float
  z : Float
  w : Float
}

///|
pub fn Point4D::new(x? : Float, y? : Float, z? : Float, w? : Float) -> Point4D {
  Point4D::{
    x: x.or_default(),
    y: y.or_default(),
    z: z.or_default(),
    w: w.or_default(),
  }
}

///|
pub fn Point4D::scale(self : Point4D, t : Float) -> Point4D {
  Point4D::{ x: self.x * t, y: self.y * t, z: self.z * t, w: self.w * t }
}

///|
pub fn Point4D::to_array(self : Point4D) -> Array[Float] {
  [self.x, self.y, self.z, self.w]
}

///|
pub fn Point4D::from_quaternion(q : @quaternion.Quaternion) -> Point4D {
  Point4D::new(x=q.x, y=q.y, z=q.z, w=q.w)
}

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
pub(all) struct Vertex {
  position : Point4D
  color : Color
}

///|
pub fn Vertex::attrs() -> Array[CaterfoilAttribute] {
  [
    { field: "position", format: Float32x4 },
    { field: "color", format: Float32x4 },
  ]
}

///|
pub fn Vertex::to_value(
  self : Vertex
) -> @moonbitlang/core/hashmap.T[String, Array[Float]] {
  let dict : @moonbitlang/core/hashmap.T[String, Array[Float]] = @moonbitlang/core/hashmap.new()
  dict["position"] = [
    self.position.x,
    self.position.y,
    self.position.z,
    self.position.w,
  ]
  dict["color"] = [self.color.r, self.color.g, self.color.b, self.color.a]
  dict
}

///|
pub(all) struct PolylineVertex {
  position : Point4D
  color : Color
  direction : Point4D
  side : Int
}

///|
pub fn PolylineVertex::to_value(
  self : PolylineVertex
) -> @moonbitlang/core/hashmap.T[String, Array[Float]] {
  let dict : @moonbitlang/core/hashmap.T[String, Array[Float]] = @moonbitlang/core/hashmap.new()
  dict["position"] = self.position.to_array()
  dict["color"] = [self.color.r, self.color.g, self.color.b, self.color.a]
  dict["direction"] = self.direction.to_array()
  dict["side"] = [self.side.to_float()] // need int but JavaScript auto converts
  dict
}
