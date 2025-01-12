# Carterfoil Crafts

### Usage

_TODO_

URL params:

- `tab` content to draw, options(defaults to last one):

  - `quat-curve` a curve
  - `hyper-cube` hyper cube
  - `hyper-cube-grid` a grid of hyper cubes
  - `fly-city` quternion fractal
  - `lamp-tree` quternion fractal
  - `quat-tree` quaternion tree
  - `quat-product` quaternion product curve
  - `prime-walk` some walk path
  - `sphere-tess` sphere tessellation folded to 2 dimensions
  - `cubic-array` array and grid in cubic space

- `read` to read from storage, options(defaults to `true`):

  - `true`
  - `false`

- `axis` to draw axis, options(defaults to `true`):

  - `true`
  - `false`

- `times` for expand times, only works on some demos, 0~10

### Development

Watch build MoonBit:

```bash
moon build --target js --debug --watch
```

Watch serve page:

```bash
yarn vite
```

### Licence

Apache 2.0
