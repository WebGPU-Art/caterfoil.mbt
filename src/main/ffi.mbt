// import { paintCaterfoilTree } from "./paint.mjs";
// import { renderCaterfoilTree, resetCanvasSize } from "./renderer.mjs";
// import { initializeCanvasTextures, initializeContext } from "./initialize.js";
// import { createTextureFromSource } from "./util.mjs";

// import { compContainer } from "./app/container.mjs";
// import { loadGamepadControl } from "./control.mjs";
// import { setupMouseEvents } from "./events.mjs";
// import { Atom } from "@triadica/touch-control";
// import { V4 } from "./primes.mjs";
// import { atomClearColor } from "./global.mjs";

///|
type Promise

///|
extern "js" fn Promise::then(
  self : Promise,
  f : (JsValue) -> JsValue
) -> Promise =
  #| (self, f) => self.then(f)

///|
extern "js" fn Promise::catch_error(
  self : Promise,
  f : (JsValue) -> Unit
) -> Promise =
  #| (self, f) => self.catch(f)

///|
extern "js" fn js_undefined() -> JsValue =
  #| () => undefined

///|
extern "js" fn initialize_context() -> Promise =
  #| () => Caterfoil.initializeContext()

///|
extern "js" fn paint_caterfoil_tree() -> Unit =
  #| () => Caterfoil.paintCaterfoilTree()

///|
extern "js" fn render_caterfoil_tree(
  el : CaterfoilRenderObject,
  dispatch : () -> Unit
) -> Unit =
  #| (el, dispatch) => Caterfoil.renderCaterfoilTree(el, dispatch)

///|
extern "js" fn reset_canvas_size(canvas : Element) -> Unit =
  #| (canvas) => Caterfoil.resetCanvasSize(canvas)

///|
pub extern "js" fn initialize_canvas_textures() -> Unit =
  #| () => Caterfoil.initializeCanvasTextures()

///|
pub extern "js" fn setup_mouse_events() -> Unit =
  #| () => Caterfoil.setupMouseEvents()

///|
extern "js" fn load_gamepad_control() -> Unit =
  #| () => Caterfoil.loadGamepadControl()

///|
type Window

///|
extern "js" fn window() -> Window =
  #| () => window

///| set_onresize
extern "js" fn Window::set_onresize(self : Window, f : () -> Unit) -> Unit =
  #| (window, f) => window.onresize = f

///|onload
extern "js" fn Window::set_onload(self : Window, f : () -> Unit) -> Unit =
  #| (window, f) => window.onload = f

///|
type Document

///|
pub extern "js" fn Window::document(self : Window) -> Document =
  #| () => document

///|
type Element

///| query_selector
extern "js" fn Document::query_selector(
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
