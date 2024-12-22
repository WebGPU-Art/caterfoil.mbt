// import { atomClearColor } from "./global.mjs";

///|
struct Store {} derive(Default)

///|
enum Action {}

///|
let store : @caterfoil.Atom[Store] = @caterfoil.Atom::with_value(
  Store::default(),
)

///|
fn dispatch() -> Unit {
  render_app()
}

///|
fn render_app() -> Unit {
  let tree = comp_container()
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
    render_app()
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
  @caterfoil.window().set_onload(loaded)
}

// declare global {
//   /** dirty hook for extracting error messages */
//   var __caterfoilHandleCompilationInfo: (info: GPUCompilationInfo, code: string) => void;
// }
