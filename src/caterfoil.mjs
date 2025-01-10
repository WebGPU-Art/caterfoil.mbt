import * as Caterfoil from "@webgpu-art/caterfoil";

window.Caterfoil = Caterfoil;

console.log("Caterfoil loaded", Caterfoil);

// load js code which Vite does not detect
import("../target/js/debug/build/main/main.js")
  .then((module) => {
    console.log("Main loaded", module);
  })
  .catch((error) => {
    console.error("Main error", error);
  });
