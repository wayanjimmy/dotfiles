// Preferences
Phoenix.set({
  daemon: true,
  openAtLogin: true,
});

Event.on("willTerminate", () => {
  Storage.remove("lastPositions");
  Storage.remove("maxHeight");
});

function frameRatio(a, b) {
  const widthRatio = b.width / a.width;
  const heightRatio = b.height / a.height;

  return ({ width, height, x, y }) => {
    width = Math.round(width * widthRatio);
    height = Math.round(height * heightRatio);
    x = Math.round(b.x + (x - a.x) * widthRatio);
    y = Math.round(b.y + (y - a.y) * heightRatio);

    return { width, height, x, y };
  };
}

// Globals
const HIDDEN_DOCK_MARGIN = 3;
const INCREMENT = 0.05;
const CONTROL_SHIFT = ["ctrl", "shift"];
const CONTROL_ALT_SHIFT = ["ctrl", "alt", "shift"];

// Relative Directions
const LEFT = "left";
const RIGHT = "right";
const CENTRE = "centre";

// Cardinal Directions
const NW = "nw";
const NE = "ne";
const SE = "se";
const SW = "sw";
const EAST = "east";
const WEST = "west";
const NORTH = "north";
const SOUTH = "south";

class ChainWindow {
  constructor(window, margin = 10) {
    this.window = window;
    this.margin = margin;
    this.frame = window.frame();
    this.parent = window.screen().flippedVisibleFrame();
  }

  // Difference frame
  difference() {
    const { parent, frame } = this;
    return {
      x: parent.x - frame.x,
      y: parent.y - frame.y,
      width: parent.width - frame.width,
      height: parent.height - frame.height,
    };
  }

  // Set frame
  set() {
    const { window, frame } = this;
    window.setFrame(frame);
    this.frame = window.frame();
    return this;
  }

  // Move to screen
  screen(screen) {
    this.parent = screen.flippedVisibleFrame();
    return this;
  }

  // Move to cardinal directions NW, NE, SE, SW or relative direction CENTRE
  to(direction) {
    const { parent, margin } = this;
    const difference = this.difference();

    // X-coordinate
    switch (direction) {
      case NW:
      case SW:
        this.frame.x = parent.x + margin;
        break;
      case NE:
      case SE:
        this.frame.x = parent.x + difference.width - margin;
        break;
      case CENTRE:
        this.frame.x = parent.x + difference.width / 2;
        break;
      default:
    }

    // Y-coordinate
    switch (direction) {
      case NW:
      case NE:
        this.frame.y = parent.y + margin;
        break;
      case SE:
      case SW:
        this.frame.y = parent.y + difference.height - margin;
        break;
      case CENTRE:
        this.frame.y = parent.y + difference.height / 2;
        break;
      default:
    }

    return this;
  }

  // Resize SE-corner by factor
  resize(factor) {
    const { parent, margin, frame } = this;
    const difference = this.difference();
    let delta;
    if (factor.width) {
      delta = Math.min(
        parent.width * factor.width,
        difference.x + difference.width - margin
      );
      this.frame.width += delta;
    } else if (factor.height) {
      delta = Math.min(
        parent.height * factor.height,
        difference.height - frame.y + margin + HIDDEN_DOCK_MARGIN
      );
      this.frame.height += delta;
    }
    return this;
  }

  // Maximise to fill whole screen
  maximise() {
    const { parent, margin } = this;

    this.frame.width = parent.width - 2 * margin;
    this.frame.height = parent.height - 2 * margin;
    return this;
  }

  // Halve width
  halve() {
    this.frame.width /= 2;
    return this;
  }

  // Fit to screen
  fit() {
    const difference = this.difference();
    if (difference.width < 0 || difference.height < 0) {
      this.maximise();
    }
    return this;
  }

  // Fill relatively to LEFT or RIGHT-side of screen, or fill whole screen
  fill(direction) {
    this.maximise();
    if (direction === LEFT || direction === RIGHT) {
      this.halve();
    }
    switch (direction) {
      case LEFT:
        this.to(NW);
        break;
      case RIGHT:
        this.to(NE);
        break;
      default:
        this.to(NW);
    }
    return this;
  }
}

// Chain a Window-object
Window.prototype.chain = function () {
  return new ChainWindow(this);
};

// To direction in screen
Window.prototype.to = function (direction, screen) {
  const window = this.chain();
  if (screen) {
    window.screen(screen).fit();
  }
  window.to(direction).set();
};

// Fill in screen
Window.prototype.fill = function (direction, screen) {
  const window = this.chain();
  if (screen) {
    window.screen(screen);
  }
  window.fill(direction).set();
  // Ensure position for windows larger than expected
  if (direction === RIGHT) {
    window.to(NE).set();
  }
};

// Resize by factor
Window.prototype.resize = function (factor) {
  this.chain().resize(factor).set();
};

/* Position Bindings */

Key.on("q", CONTROL_SHIFT, () => {
  const window = Window.focused();
  if (window) {
    window.to(NW);
  }
});

Key.on("w", CONTROL_SHIFT, () => {
  const window = Window.focused();
  if (window) {
    window.to(NE);
  }
});

Key.on("s", CONTROL_SHIFT, () => {
  const window = Window.focused();
  if (window) {
    window.to(SE);
  }
});

Key.on("a", CONTROL_SHIFT, () => {
  const window = Window.focused();
  if (window) {
    window.to(SW);
  }
});

Key.on("z", CONTROL_SHIFT, () => {
  const window = Window.focused();
  if (window) {
    window.to(CENTRE);
  }
});

Key.on("q", CONTROL_ALT_SHIFT, () => {
  const window = Window.focused();
  if (window) {
    window.to(NW, window.screen().next());
  }
});

Key.on("w", CONTROL_ALT_SHIFT, () => {
  const window = Window.focused();
  if (window) {
    window.to(NE, window.screen().next());
  }
});

Key.on("s", CONTROL_ALT_SHIFT, () => {
  const window = Window.focused();
  if (window) {
    window.to(SE, window.screen().next());
  }
});

Key.on("a", CONTROL_ALT_SHIFT, () => {
  const window = Window.focused();
  if (window) {
    window.to(SW, window.screen().next());
  }
});

Key.on("z", CONTROL_ALT_SHIFT, () => {
  const window = Window.focused();
  if (window) {
    window.to(CENTRE, window.screen().next());
  }
});

/* Fill Bindings */

Key.on("o", CONTROL_SHIFT, () => {
  const window = Window.focused();
  if (window) {
    window.fill(LEFT);
  }
});

Key.on("p", CONTROL_SHIFT, () => {
  const window = Window.focused();
  if (window) {
    window.fill(RIGHT);
  }
});

/* Size Bindings */

Key.on("'", CONTROL_SHIFT, () => {
  const window = Window.focused();
  if (window) {
    window.resize({ height: INCREMENT });
  }
});

Key.on(";", CONTROL_SHIFT, () => {
  const window = Window.focused();
  if (window) {
    window.resize({ height: -INCREMENT });
  }
});

/* Focus Bindings */

Key.on("<", CONTROL_SHIFT, () => {
  const last = _.last(Window.recent());
  if (last) {
    last.focus();
  }
});

Key.on(".", CONTROL_SHIFT, () => {
  const window = Window.focused();
  if (!window) {
    return;
  }

  const oldScreen = window.screen();
  const newScreen = oldScreen.next();

  if (oldScreen.isEqual(newScreen)) {
    return;
  }

  const ratio = frameRatio(
    oldScreen.flippedVisibleFrame(),
    newScreen.flippedVisibleFrame()
  );

  window.setFrame(ratio(window.frame()));
});

/** toggle max screen **/
Key.on("f", CONTROL_SHIFT, () => {
  const window = Window.focused();

  if (!window) return;

  const margin = window.chain().margin;

  const windowId = window.hash();

  const screen = window.screen().flippedVisibleFrame();

  let lastPositions = Storage.get("lastPositions") || {};

  if (!lastPositions[windowId]) {
    lastPositions[windowId] = {
      x: window.topLeft().x,
      y: window.topLeft().y,
      width: window.size().width,
      height: window.size().height,
    };
  }

  const maxHeight = Storage.get("maxHeight") || screen.height - 2 * margin;

  const maxWidth = Storage.get("maxWidth") || screen.width - margin;

  if (window.size().width !== maxWidth || window.size().height !== maxHeight) {
    lastPositions[windowId] = {
      x: window.topLeft().x,
      y: window.topLeft().y,
      width: window.size().width,
      height: window.size().height,
    };

    Storage.set("lastPositions", lastPositions);

    window.setTopLeft({
      x: screen.x + margin,
      y: screen.y + margin,
    });

    window.setSize({
      height: screen.height - 2 * margin,
      width: screen.width - 1.6 * margin,
    });

    Storage.set("maxHeight", window.size().height);
    Storage.set("maxWidth", window.size().width);

    return;
  }

  if (window) {
    window.setSize({
      width: lastPositions[windowId].width,
      height: lastPositions[windowId].height,
    });

    window.setTopLeft({
      x: lastPositions[windowId].x,
      y: lastPositions[windowId].y,
    });
  }
});

Key.on("h", CONTROL_SHIFT, function () {
  const window = Window.focused();

  if (window) {
    window.focusClosestNeighbor(WEST);
  }
});

Key.on("j", CONTROL_SHIFT, function () {
  const window = Window.focused();

  if (window) {
    window.focusClosestNeighbor(SOUTH);
  }
});

Key.on("k", CONTROL_SHIFT, function () {
  const window = Window.focused();

  if (window) {
    window.focusClosestNeighbor(NORTH);
  }
});

Key.on("l", CONTROL_SHIFT, function () {
  const window = Window.focused();

  if (window) {
    window.focusClosestNeighbor(EAST);
  }
});

Key.on("/", CONTROL_SHIFT, function () {
  const window = Window.focused();

  window.setSize({
    height: window.size().height / 2,
    width: window.size().width,
  });
});

Key.on("t", CONTROL_SHIFT, function () {
  App.launch("Alacritty").focus();
});

/**
 * Move window to space on the right
 */
Key.on("right", CONTROL_SHIFT, function () {
  const window = Window.focused();

  const space = Space.active();

  if (!window || !space) return;

  const nextSpace = space.next();

  space.removeWindows([window]);
  nextSpace.addWindows([window]);

  window.focus();
});

/**
 * Move window to space on the left
 */
Key.on("left", CONTROL_SHIFT, function () {
  const window = Window.focused();

  const space = Space.active();

  if (!window || !space) return;

  const previousSpace = space.previous();

  space.removeWindows([window]);
  previousSpace.addWindows([window]);

  window.focus();
});

