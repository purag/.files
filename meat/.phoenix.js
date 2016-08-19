Phoenix.set({
  openAtLogin: true
});

var w = Window;
var s = Screen;
var m = Mouse;
var k = Key;
var e = Event;

var INCREMENT = 50;
var PADDING = 10;
var MOD = ["shift", "cmd"];
var ALTMOD = ["alt", "shift"];

var HINT_APPEARANCE = "dark";
var HINT_BUTTON = "space";
var HINT_CANCEL = "escape";
var HINT_CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";

// DIRECTIONS
var F  = "fill";
var N  = "north";
var S  = "south";
var W  = "west";
var E  = "east";
var NW = "nw";
var NE = "ne";
var SW = "sw";
var SE = "se";

// KEYS + DIRECTION MAPPINGS
var snap_dirs = {
  "up":    F,
  "left":  W,
  "right": E,
  "a":     NW,
  "'":     NE,
  "z":     SW,
  "/":     SE
};

var size_dirs = {
  "h": W,
  "j": S,
  "k": N,
  "l": E
};

var space_dirs = {
  ",": W,
  ".": E
};

// +---------+
// | HELPERS |
// +---------+
function curw () {
  return w.focused();
}

// Conditional key binding -- execute cb only if cond_f returns truthy
function onif (cond_f, key, modifiers, cb) {
  k.on(key, modifiers, function () {
    if (!cond_f()) return;
    cb();
  });
};

// Screen prototype extension -- subtract padding
s.prototype.width = function () {
  return this.flippedVisibleFrame().width - PADDING * 2;
};

s.prototype.height = function () {
  return this.flippedVisibleFrame().height - PADDING * 2;
};

s.prototype.origin = function () {
  return {
    x: this.flippedVisibleFrame().x + PADDING,
    y: this.flippedVisibleFrame().y + PADDING
  };
};

function opposite (dir) {
  switch (dir) {
    case N: return S;
    case S: return N;
    case E: return W;
    case W: return E;
    case NW: return SE;
    case NE: return SW;
    case SW: return NE;
    case SE: return NW;
  }
}

// Snap a window in a given direction
w.prototype.to = function (dir) {
  var screen = this.screen();
  var frame = {};
  frame.x = screen.origin().x;
  frame.y = screen.origin().y;
  frame.width = (screen.width() - PADDING) / 2;
  frame.height = (screen.height() - PADDING) / 2;

  if ([E, NE, SE].indexOf(dir) > -1) frame.x += screen.width() - frame.width;
  if ([SE, SW].indexOf(dir) > -1)    frame.y += screen.height() - frame.height;
  if (dir === F)                     frame.width = screen.width();
  if ([F, E, W].indexOf(dir) > -1)   frame.height = screen.height();

  this.setFrame(frame);
};

// Resize a window by coeff units in the given direction
// coeff: -n shrinks by pixels units, +n grows by n pixels.
w.prototype.resize = function (dir, coeff) {
  var frame = this.frame();

  if (dir === W)                frame.x += coeff * -1;
  if (dir === N)                frame.y += coeff * -1;
  if ([E, W].indexOf(dir) > -1) frame.width += coeff;
  if ([N, S].indexOf(dir) > -1) frame.height += coeff;

  this.setFrame(frame);
};

w.prototype.toSpace = function (dir) {
  var curSpace = this.spaces()[0];
  var newSpace = curSpace.next();
  if (dir === W) newSpace = curSpace.previous();

  curSpace.removeWindows([this]);
  newSpace.addWindows([this]);
  this.focus();
};

// Snap bindings
for (var key in snap_dirs) {
  onif(curw, key, MOD, function (dir) {
    curw().to(dir);
  }.bind(null, snap_dirs[key]));
}

// Resize bindings
for (var key in size_dirs) {
  onif(curw, key, MOD, function (dir) {
    curw().resize(dir, INCREMENT);
  }.bind(null, size_dirs[key]));

  onif(curw, key, ALTMOD, function (dir) {
    curw().resize(dir, -INCREMENT);
  }.bind(null, opposite(size_dirs[key])));
}

for (var key in space_dirs) {
  onif(curw, key, MOD, function (dir) {
    curw().toSpace(dir);
  }.bind(null, space_dirs[key]));
}

// Hints
var hintsActive = false;
var hints = {};
var escbind = null;

function cancelHints () {
  for (var ch in hints) {
    hints[ch].modal.close();
    k.off(hints[ch].binding);
  };
  k.off(escbind);
  hints = {};
  hintsActive = false;
}

k.on(HINT_BUTTON, MOD, function () {
  if (hintsActive) {
    cancelHints();
  } else {
    var windows = w.all({
      visible: true
    });
    var i = 0;
    windows.forEach(function (win) {
      var helper = win.app().windows().length > 1
        ? "  |  " + win.title().substr(0, 15) + (win.title().length > 15 ? "…" : "")
        : "";
      var hint = buildhint(HINT_CHARS[i] + helper, win, win.app().icon());

      for (var ch in hints) {
        var hint2 = hints[ch].modal;
        if (
          hint.origin.x < hint2.origin.x + hint2.frame().width
          && hint.origin.x + hint.frame().width > hint2.origin.x
          && hint.origin.y < hint2.origin.y + hint2.frame().height
          && hint.origin.y + hint.frame().width > hint2.origin.y
        ) {
          hint.origin = {
            x: hint.origin.x,
            y: hint.origin.y - hint.frame().height - PADDING
          };
        }
      }

      hints[HINT_CHARS[i]] = {
        binding: k.on(HINT_CHARS[i], [], function () {
          win.focus();
          m.move({
            x: hint.origin.x + hint.frame().width / 2,
            y: s.all()[0].frame().height - hint.origin.y - hint.frame().height / 2
          });
          cancelHints();
        }),
        modal: hint
      };
      i++;
    });
    escbind = k.on(HINT_CANCEL, [], cancelHints);
    hintsActive = true;
  }
});

e.on("mouseDidLeftClick", cancelHints);
e.on("screenDidChange", cancelHints);

function buildhint (msg, win, icon) {
  var wf = win.frame();
  var wsf = win.screen().frame();
  var modal = Modal.build({
    text: msg,
    appearance: HINT_APPEARANCE,
    icon: icon,
    weight: 16
  });
  var mf = modal.frame();
  modal.origin = {
    x: Math.min(
      Math.max(wf.x + wf.width / 2 - mf.width / 2, wsf.x),
      wsf.x + wsf.width - mf.width
    ),
    y: Math.min(
      Math.max(s.all()[0].frame().height - (wf.y + wf.height / 2 + mf.height / 2), wsf.y),
      wsf.y + wsf.height - mf.height
    )
  };
  modal.show();
  return modal;
}

Phoenix.notify("Configuration loaded.");
