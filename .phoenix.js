Phoenix.set({
  openAtLogin: true
});

var w = Window;
var a = App;
var s = Screen;
var k = Key;

var INCREMENT = 10;
var MOTION_INCREMENT = 100;
var PADDING = 10;
var MOD = ["shift", "cmd"];
var ALTMOD = ["alt", "shift"];

s.prototype.width = function () {
  return this.flippedVisibleFrame().width - PADDING * 2;
};

s.prototype.height = function () {
  return this.flippedVisibleFrame().height - PADDING * 2;
};

s.prototype.hwidth = function () {
  return (this.width() - PADDING) / 2;
};

s.prototype.hheight = function () {
  return (this.height() - PADDING) / 2;
};

s.prototype.origin = function () {
  return {
    x: this.flippedVisibleFrame().x + PADDING,
    y: this.flippedVisibleFrame().y + PADDING
  };
};

var F  = "f";
var W  = "w";
var E  = "e";
var NW = "nw";
var NE = "ne";
var SW = "sw";
var SE = "se";

var dirs = {
  "up":    F,
  "left":  W,
  "right": E,
  "a":     NW,
  "'":     NE,
  "z":     SW,
  "/":     SE
};

w.prototype.to = function (dir) {
  var screen = this.screen();
  var origin = screen.origin();
  var x = 0, y = 0, width = screen.hwidth(), height = screen.hheight();

  if ([E, NE, SE].indexOf(dir) > -1) x = screen.width() - screen.hwidth();
  if ([SE, SW].indexOf(dir) > -1)    y = screen.height() - screen.hheight();
  if (dir === F)                     width = screen.width();
  if ([F, E, W].indexOf(dir) > -1)   height = screen.height();

  this.setFrame({
    x: origin.x + x,
    y: origin.y + y,
    width: width,
    height: height
  });

  this.frame.x = origin.x + 500;
};

for (var key in dirs) {
  wbind(key, MOD, function (key) {
    curw().to(dirs[key]);
  }.bind(null, key));
}

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

Phoenix.notify("Configuration loaded.");
