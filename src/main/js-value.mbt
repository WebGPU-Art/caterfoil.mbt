///|
type JsValue

///|
extern "js" fn JsValue::from_string(value : String) -> JsValue =
  #| (value) => value

///|
extern "js" fn JsValue::from_number(value : Float) -> JsValue =
  #| (value) => value

///|
extern "js" fn JsValue::from_bool(value : Bool) -> JsValue =
  #| (value) => value

///|
extern "js" fn JsValue::from_object(value : JsObject) -> JsValue =
  #| (value) => value

///|
extern "js" fn JsValue::from_array(value : JsArray) -> JsValue =
  #| (value) => value

///|
extern "js" fn JsValue::from_fn(value : () -> JsValue) -> JsValue =
  #| (value) => value

///|
type JsObject

///|
extern "js" fn JsObject::new() -> JsObject =
  #| () => ({})

///|
extern "js" fn JsObject::set(
  self : JsObject,
  key : String,
  value : JsValue
) -> Unit =
  #| (self, key, value) => self[key] = value

///|
extern "js" fn JsObject::get(self : JsObject, key : String) -> JsValue =
  #| (self, key) => self[key]

///|
extern "js" fn JsObject::as_value(self : JsObject) -> JsValue =
  #| (self) => self

///|
type JsArray

///|
extern "js" fn JsArray::new() -> JsArray =
  #| () => []

///|
extern "js" fn JsArray::push(self : JsArray, value : JsValue) -> Unit =
  #| (self, value) => self.push(value)

///|
extern "js" fn JsArray::as_value(self : JsArray) -> JsValue =
  #| (self) => self
