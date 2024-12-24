///|
type Promise

///|
pub extern "js" fn Promise::then(
  self : Promise,
  f : (JsValue) -> JsValue
) -> Promise =
  #| (self, f) => self.then(f)

///|
pub extern "js" fn Promise::catch_error(
  self : Promise,
  f : (JsValue) -> Unit
) -> Promise =
  #| (self, f) => self.catch(f)

///|
pub extern "js" fn js_undefined() -> JsValue =
  #| () => undefined

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

///|
pub(all) type Window

///|
pub extern "js" fn window() -> Window =
  #| () => window

///| set_onresize
pub extern "js" fn Window::set_onresize(self : Window, f : () -> Unit) -> Unit =
  #| (window, f) => window.onresize = f

///|onload
pub extern "js" fn Window::set_onload(self : Window, f : () -> Unit) -> Unit =
  #| (window, f) => window.onload = f

///|
pub(all) type Document

///|
pub extern "js" fn Window::document(self : Window) -> Document =
  #| () => document

///|
type Element

///| query_selector
pub extern "js" fn Document::query_selector(
  self : Document,
  selector : String
) -> Element =
  #| (document, selector) => document.querySelector(selector)

///|
extern "js" fn caterfoil_object(options : JsValue) -> CaterfoilRenderObject =
  #| (options) => Caterfoil.object(options)

///|
extern "js" fn caterfoil_group(children : JsArray) -> CaterfoilRenderObject =
  #| (children) => ({type: "group", children})

///| log_js_value
extern "js" fn log_js_value(value : JsValue) -> Unit =
  #| (value) => console.log(value)
