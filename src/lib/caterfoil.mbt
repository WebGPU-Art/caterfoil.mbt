///|
pub extern "js" fn initialize_context() -> Promise =
  #| () => Caterfoil.initializeContext()

///|
pub extern "js" fn paint_caterfoil_tree() -> Unit =
  #| () => Caterfoil.paintCaterfoilTree()

///|
pub extern "js" fn render_caterfoil_tree(
  el : CaterfoilRenderObject,
  dispatch : () -> Unit
) -> Unit =
  #| (el, dispatch) => Caterfoil.renderCaterfoilTree(el, dispatch)

///|
pub extern "js" fn reset_canvas_size(canvas : Element) -> Unit =
  #| (canvas) => Caterfoil.resetCanvasSize(canvas)

///|
pub extern "js" fn initialize_canvas_textures() -> Unit =
  #| () => Caterfoil.initializeCanvasTextures()

///|
pub extern "js" fn setup_mouse_events() -> Unit =
  #| () => Caterfoil.setupMouseEvents()

///|
pub extern "js" fn load_gamepad_control() -> Unit =
  #| () => Caterfoil.loadGamepadControl()

///| need a better name from Caterfoil
pub extern "js" fn lines_wgsl() -> String =
  #| () => Caterfoil.triangleWgsl

///|
pub extern "js" fn polyline_wgsl() -> String =
  #| () => Caterfoil.polylineWgsl

///| get viewer states saved in localStorage so that it can be restored
pub fn connect_retained_atom_to_srorage(
  name : String,
  /// false to disable loading from localStorage
  read? : Bool,
  /// false to disable saving to localStorage
  write? : Bool
) -> Unit {
  caterfoil_connect_retained_atom_to_srorage(
    name,
    read.or(true),
    write.or(true),
  )
}

///| get viewer states saved in localStorage so that it can be restored
extern "js" fn caterfoil_connect_retained_atom_to_srorage(
  name : String,
  read : Bool,
  write : Bool
) -> Unit =
  #| (name, read, write) => Caterfoil.connectRetainedAtomToStorage(name, {read, write})

///|
pub(all) enum ObjectData {
  WithPoints(Array[Vertex])
  WithTriangles(Array[PolylineVertex])
}

///|
fn ObjectData::to_data(
  self : ObjectData
) -> Array[@hashmap.T[String, Array[Float]]] {
  match self {
    ObjectData::WithPoints(data) => {
      let ret = []
      for vertex in data {
        ret.push(vertex.to_value())
      }
      ret
    }
    ObjectData::WithTriangles(data) => {
      let ret = []
      for vertex in data {
        ret.push(vertex.to_value())
      }
      ret
    }
  }
}

///|
pub(all) struct CaterfoilObjectOptions {
  label : String
  shader : String
  topology : ShaderPrimitiveTopology
  data : ObjectData
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
  let attrs = match self.data {
    WithPoints(_) => Vertex::attrs()
    WithTriangles(_) => PolylineVertex::attrs()
  }
  for attr in attrs {
    attrs_list.push(attr.as_value())
  }
  obj.set("attrsList", attrs_list.as_value())
  let data = JsArray::new()
  for val in self.data.to_data() {
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
pub fn object(
  data~ : ObjectData,
  /// by default, pick the shader based on the data type
  shader? : String,
  /// default to "object"
  label? : String,
  /// default to TriangleList
  topology? : ShaderPrimitiveTopology,
  /// default to None
  get_params? : (() -> Array[Float])?,
  /// default to None
  indices? : Array[UInt]?
) -> CaterfoilRenderObject {
  let pick_shader = match data {
    WithPoints(_) => lines_wgsl()
    WithTriangles(_) => polyline_wgsl()
  }
  caterfoil_object(
    CaterfoilObjectOptions::{
      label: label.or("object"),
      shader: shader.or(pick_shader),
      topology: topology.or(TriangleList),
      data,
      indices: indices.or(None),
      get_params: get_params.or(None),
    }.as_value(),
  )
}

///|
pub fn group(children : Array[CaterfoilRenderObject]) -> CaterfoilRenderObject {
  let arr = JsArray::new()
  for child in children {
    arr.push(child.as_value())
  }
  caterfoil_group(arr)
}
