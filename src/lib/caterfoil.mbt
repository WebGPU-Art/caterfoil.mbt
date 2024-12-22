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
