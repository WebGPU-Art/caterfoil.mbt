///|
pub(open) trait JsValueTrait {
  to_value(Self) -> JsValue
  from_value(JsValue) -> Self
}

///|
pub impl JsValueTrait for String with to_value(self) -> JsValue {
  JsValue::from_string(self)
}

///|
pub impl JsValueTrait for String with from_value(value : JsValue) -> String {
  value.to_string()
}

///|
pub impl JsValueTrait for Float with from_value(value : JsValue) -> Float {
  value.to_number()
}

///|
pub impl JsValueTrait for Float with to_value(self) -> JsValue {
  JsValue::from_number(self)
}

///|
pub impl JsValueTrait for Bool with to_value(self) -> JsValue {
  JsValue::from_bool(self)
}

///|
pub impl JsValueTrait for Bool with from_value(value : JsValue) -> Bool {
  value.to_bool()
}

///|
impl JsValueTrait for JsObject with to_value(self) -> JsValue {
  JsValue::from_object(self)
}

///|
impl JsValueTrait for JsObject with from_value(value : JsValue) -> JsObject {
  value.to_object()
}

///|
impl JsValueTrait for JsArray with to_value(self) -> JsValue {
  JsValue::from_array(self)
}

///|
impl JsValueTrait for JsArray with from_value(value : JsValue) -> JsArray {
  value.to_array()
}

///|
extern "js" fn js_value_to_quaternion(
  value : JsValue,
) -> @quaternion.Quaternion =
  #| (value) => value

///|
extern "js" fn quaternion_to_js_value(
  value : @quaternion.Quaternion,
) -> JsValue =
  #| (value) => value

///|
pub impl JsValueTrait for @quaternion.Quaternion with to_value(self) -> JsValue {
  quaternion_to_js_value(self)
}

///|
pub impl JsValueTrait for @quaternion.Quaternion with from_value(
  value : JsValue,
) -> @quaternion.Quaternion {
  js_value_to_quaternion(value)
}

///|
test "use private js value trait impls" {
  let object = JsObject::new()
  let _object_value = object.to_value()
  let array = JsArray::new()
  let _array_value = array.to_value()
}
