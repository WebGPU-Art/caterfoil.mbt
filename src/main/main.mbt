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
struct Store {} derive(Default)

///|
enum Action {}

///|
let store : Atom[Store] = Atom::new(Store::default())

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
  println("hello world")
  let ctx = initialize_context().then(fn(content) {
    // initializeCanvasTextures();
    // atomClearColor.reset({ r: 0.0, g: 0.0, b: 0.0, a: 0.0 });
    println("initialized")
    let document = document()
    let canvas = document.query_selector("canvas")
    render_app()
    println("loaded")
    let window = window()
    window.set_onresize(fn() {
      reset_canvas_size(canvas)
      // initializeCanvasTextures()
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
  println("hello world")
}

///|
fn main {
  window().set_onload(loaded)
}

// declare global {
//   /** dirty hook for extracting error messages */
//   var __caterfoilHandleCompilationInfo: (info: GPUCompilationInfo, code: string) => void;
// }
