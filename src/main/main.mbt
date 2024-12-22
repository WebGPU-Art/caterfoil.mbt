// import { atomClearColor } from "./global.mjs";

///|
struct Store {} derive(Default)

///|
enum Action {}

///|
let store : Atom[Store] = Atom::with_value(Store::default())

///|
fn dispatch() -> Unit {
  render_app()
}

///|
fn render_app() -> Unit {
  let tree = comp_container()
  render_caterfoil_tree(tree, dispatch)
  paint_caterfoil_tree()
}

///|
fn loaded() -> Unit {
  let _ret = initialize_context().then(fn(_ctx) {
    initialize_canvas_textures()
    // atomClearColor.reset({ r: 0.0, g: 0.0, b: 0.0, a: 0.0 });
    let window = window()
    let document = window.document()
    let canvas = document.query_selector("canvas")
    render_app()
    window.set_onresize(fn() {
      reset_canvas_size(canvas)
      initialize_canvas_textures()
      paint_caterfoil_tree()
    })
    reset_canvas_size(canvas)

    // window.__caterfoilHandleCompilationInfo = (e, code) => {
    //   if (e.messages.length) {
    //     console.error(e);
    //   }
    // };
    // // setupMouseEvents(canvas);

    load_gamepad_control()
    paint_caterfoil_tree()
    js_undefined()
  })

}

///|
fn main {
  window().set_onload(loaded)
}

// declare global {
//   /** dirty hook for extracting error messages */
//   var __caterfoilHandleCompilationInfo: (info: GPUCompilationInfo, code: string) => void;
// }
