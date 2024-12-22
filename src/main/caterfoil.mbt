///|
struct CaterfoilObjectOptions {
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
  JsObject::set(obj, "label", JsValue::from_string(self.label))
  JsObject::set(obj, "shader", JsValue::from_string(self.shader))
  JsObject::set(
    obj,
    "topology",
    JsValue::from_string(self.topology.to_string()),
  )
  let attrs_list = JsArray::new()
  for attr in self.attrs_list {
    attrs_list.push(attr.as_value())
  }
  JsObject::set(obj, "attrsList", attrs_list.as_value())
  let data = JsArray::new()
  for val in self.data {
    let obj = JsObject::new()
    for key, value in val {
      let arr = JsArray::new()
      for v in value {
        arr.push(JsValue::from_number(v))
      }
      JsObject::set(obj, key, JsValue::from_array(arr))
    }
    data.push(JsValue::from_object(obj))
  }
  JsObject::set(obj, "data", data.as_value())
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
  JsObject::set(obj, "getParams", JsValue::from_fn(get_params))
  JsObject::as_value(obj)
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
fn ShaderPrimitiveTopology::to_string(self : ShaderPrimitiveTopology) -> String {
  match self {
    PointList => "point-list"
    LineList => "line-list"
    LineStrip => "line-strip"
    TriangleList => "triangle-list"
    TriangleStrip => "triangle-strip"
  }
}

///|
struct CaterfoilAttribute {
  field : String
  format : GPUVertexFormat
}

///|
fn CaterfoilAttribute::as_value(self : CaterfoilAttribute) -> JsValue {
  let obj = JsObject::new()
  JsObject::set(obj, "field", JsValue::from_string(self.field))
  JsObject::set(obj, "format", JsValue::from_string(self.format.to_string()))
  JsObject::as_value(obj)
}

///|
type CaterfoilRenderObject

///|
fn object(options : CaterfoilObjectOptions) -> CaterfoilRenderObject {
  caterfoil_object(options.as_value())
}

///|
pub fn group(children : Array[CaterfoilRenderObject]) -> CaterfoilRenderObject {
  caterfoil_group(children)
}
