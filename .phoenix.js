var w = Window;
var a = App;
var s = Screen;
var k = Key;

var INCREMENT = 10;
var MOTION_INCREMENT = 100;
var PADDING = 10;
var MOD = ["shift", "cmd"];
var ALTMOD = ["alt", "shift"];

var NORTH = "north";
var SOUTH = "south";
var EAST  = "east";
var WEST  = "west";
var ALL   = "all";

var dirs = {
  "up":    ALL,
  "left":  WEST,
  "right": EAST,
  "'":     NORTH + EAST,
  "a":     NORTH + WEST,
  "/":     SOUTH + EAST,
  "z":     SOUTH + WEST
};

var x = function (dir) {
  return dir == EAST || dir == NORTH + EAST || dir == SOUTH + EAST
    ? screenHalfXOffset()
    : 0;
};

var y = function (dir) {
  return dir == SOUTH || dir == SOUTH + EAST || dir == SOUTH + WEST
    ? screenHalfYOffset()
    : 0;
};

var width = function (dir) {
  return dir == ALL
    ? screenWidth()
    : screenHalfWidth();
};

var height = function (dir) {
  return dir == EAST || dir == WEST || dir == ALL
    ? screenHeight()
    : screenHalfHeight();
};

var snap = function (dir) {
  curw().setFrame({
    x: screenOrigin().x + (dir ? x(dir) : 0),
    y: screenOrigin().y + (dir ? y(dir) : 0),
    width: dir ? width(dir) : screenWidth(),
    height: dir ? height(dir) : screenHeight()
  });
};

for (var dir in dirs) {
  wbind(dir, MOD, snap.bind(null, dirs[dir]));
}

wbind("return", MOD, snap);

// ----- HINTS -----
var HINTMODE = false;
var HINTS = {};
var ESCBIND = null;

function cancelHints () {
  for (var ch in HINTS) {
    HINTS[ch].modal.close();
    unbind(HINTS[ch].binding);
  };
  unbind(ESCBIND);
  HINTS = {};
  HINTMODE = false;
}

bind
  ("space", MOD, function () {
    if (HINTMODE) {
      cancelHints();
    } else {
      var windows = w.all({
        visible: true
      });
      var ch = "A";
      windows.forEach(function (win) {
        var x = win.frame().x + win.frame().width / 2 - 30;
        var y = win.screen().frame().height - win.frame().y - win.frame().height / 2 - 30;
        HINTS[ch] = {
          binding: bind(ch, [], function () {
            win.focus();
            cancelHints();
          }),
          modal: modal(ch, x, y, win.app().icon())
        };
        ch = String.fromCharCode(ch.charCodeAt(0) + 1);
      });
      ESCBIND = bind("escape", [], cancelHints);
      HINTMODE = true;
    }
  });
// ----- HINTS -----

wbind
  ("h", MOD, function () {
    curw().setFrame({
      x: curw().frame().x - INCREMENT,
      y: curw().frame().y,
      width: curw().frame().width + INCREMENT,
      height: curw().frame().height
    });
  })

  ("l", ALTMOD, function () {
    curw().setFrame({
      x: curw().frame().x + INCREMENT,
      y: curw().frame().y,
      width: curw().frame().width - INCREMENT,
      height: curw().frame().height
    });
  })

  ("j", MOD, function () {
    curw().setFrame({
      x: curw().frame().x,
      y: curw().frame().y,
      width: curw().frame().width,
      height: curw().frame().height + INCREMENT
    });
  })

  ("k", ALTMOD, function () {
    curw().setFrame({
      x: curw().frame().x,
      y: curw().frame().y,
      width: curw().frame().width,
      height: curw().frame().height - INCREMENT
    });
  })
  
  ("k", MOD, function () {
    curw().setFrame({
      x: curw().frame().x,
      y: curw().frame().y - INCREMENT,
      width: curw().frame().width,
      height: curw().frame().height + INCREMENT
    });
  })

  ("j", ALTMOD, function () {
    curw().setFrame({
      x: curw().frame().x,
      y: curw().frame().y + INCREMENT,
      width: curw().frame().width,
      height: curw().frame().height - INCREMENT
    });
  })

  ("l", MOD, function () {
    curw().setFrame({
      x: curw().frame().x,
      y: curw().frame().y,
      width: curw().frame().width + INCREMENT,
      height: curw().frame().height
    });
  })

  ("h", ALTMOD, function () {
    curw().setFrame({
      x: curw().frame().x,
      y: curw().frame().y,
      width: curw().frame().width - INCREMENT,
      height: curw().frame().height
    });
  });
// WBIND

function curw () {
  return w.focused();
}

function screenWidth () {
  return curw().screen().flippedVisibleFrame().width - PADDING * 2;
}

function screenHeight () {
  return curw().screen().flippedVisibleFrame().height - PADDING * 2;
}

function screenHalfWidth () {
  return screenWidth() / 2 - PADDING / 2;
}

function screenHalfHeight () {
  return screenHeight() / 2 - PADDING / 2;
}

function screenHalfXOffset () {
  return screenWidth() - screenHalfWidth();
}

function screenHalfYOffset () {
  return screenHeight() - screenHalfHeight();
}

function screenOrigin () {
  return {
    x: curw().screen().flippedVisibleFrame().x + PADDING,
    y: curw().screen().flippedVisibleFrame().y + PADDING
  };
}

// chainable key binding function
function bind (key, modifiers, cb) {
  return k.on(key, modifiers, cb);
}

function unbind (key) {
  return k.off(key);
}

// chainable key binding function for when window is in focus
function wbind (key, modifiers, cb) {
  k.on(key, modifiers, function () {
    if (!curw()) return;
    cb();
  });
  return wbind;
}

function modal (msg, x, y, icon) {
  var modal = Modal.build({
    text: msg,
    origin: function () {
      return {
        x: x || 0,
        y: y || 0
      }
    },
    appearance: "dark",
    icon: icon
  });
  modal.show();
  return modal;
}
