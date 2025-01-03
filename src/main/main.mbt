// import { atomClearColor } from "./global.mjs";

///|
struct Store {} derive(Default)

///|
pub(all) enum Action {}

///|
pub let store : @caterfoil.Atom[Store] = @caterfoil.Atom::with_value(
  Store::default(),
)

///|
fn dispatch() -> Unit {
  render_app?().unwrap()
}

///|
struct SearchParams {
  tab : Tab
  read : Bool
  show_axis : Bool
}

///|
fn read_params() -> SearchParams {
  let location = @dom_ffi.window().location()
  let params = @dom_ffi.new_url_search_params(location.search())
  let tab = params.get("tab")
  let read = match params.get("read") {
    "true" => true
    "false" => false
    _ => true
  }
  let show_axis = match params.get("axis") {
    "true" => true
    "false" => false
    _ => true
  }
  { tab: Tab::from_string(tab), read, show_axis }
}

///|
fn render_app() -> Unit!@caterfoil.BuilderError {
  let params = read_params()
  let tree = comp_container!(params)
  @caterfoil.render_caterfoil_tree(tree, dispatch)
  @caterfoil.paint_caterfoil_tree()
}

///|
fn loaded() -> Unit {
  let _ret = @caterfoil.initialize_context().then(fn(_ctx) {
    @caterfoil.initialize_canvas_textures()
    // atomClearColor.reset({ r: 0.0, g: 0.0, b: 0.0, a: 0.0 });
    let window = @caterfoil.window()
    let document = window.document()
    let canvas = document.query_selector("canvas")
    render_app?().unwrap()
    window.set_onresize(fn() {
      @caterfoil.reset_canvas_size(canvas)
      @caterfoil.initialize_canvas_textures()
      @caterfoil.paint_caterfoil_tree()
    })
    @caterfoil.reset_canvas_size(canvas)

    // window.__caterfoilHandleCompilationInfo = (e, code) => {
    //   if (e.messages.length) {
    //     console.error(e);
    //   }
    // };
    // // setupMouseEvents(canvas);

    @caterfoil.load_gamepad_control()
    @caterfoil.paint_caterfoil_tree()
    @caterfoil.js_undefined()
  })

}

///|
fn main {
  @caterfoil.connect_retained_atom_to_srorage(
    "caterfoil.mbt",
    read=read_params().read,
  )
  @caterfoil.window().set_onload(loaded)
}

// declare global {
//   /** dirty hook for extracting error messages */
//   var __caterfoilHandleCompilationInfo: (info: GPUCompilationInfo, code: string) => void;
// }
