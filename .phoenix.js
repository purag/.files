var w = Window;
var a = App;
var s = Screen;
var k = Key;

var INCREMENT = 40;

bind
  // maximize
  ("up", ["cmd", "shift"], function () {
    if (!curw()) return;
    curw().maximize();
  })

  // left half
  ("left", ["cmd", "shift"], function () {
    if (!curw()) return;
    curw().setFrame({
      x: 0,
      y: 0,
      width: screenWidth() / 2,
      height: screenHeight()
    });
  })

  // right half
  ("right", ["cmd", "shift"], function () {
    if (!curw()) return;
    curw().setFrame({
      x: screenWidth() / 2,
      y: 0,
      width: screenWidth() / 2,
      height: screenHeight()
    });
  })

  // minimize
  ("down", ["cmd", "shift"], function () {
    if (!curw()) return;
    curw().minimize();
  })

  // upper left quarter
  ("a", ["cmd", "shift"], function () {
    if (!curw()) return;
    curw().setFrame({
      x: 0,
      y: 0,
      width: screenWidth() / 2,
      height: screenHeight() / 2
    });
  })

  // lower left quarter
  ("z", ["cmd", "shift"], function () {
    if (!curw()) return;
    curw().setFrame({
      x: 0,
      y: screenHeight() / 2 + 24,
      width: screenWidth() / 2,
      height: screenHeight() / 2
    });
  })

  // upper right quarter
  (";", ["cmd", "shift"], function () {
    if (!curw()) return;
    curw().setFrame({
      x: screenWidth() / 2,
      y: 0,
      width: screenWidth() / 2,
      height: screenHeight() / 2
    });
  })

  // lower right quarter
  (".", ["cmd", "shift"], function () {
    if (!curw()) return;
    curw().setFrame({
      x: screenWidth() / 2,
      y: screenHeight() / 2 + 24,
      width: screenWidth() / 2,
      height: screenHeight() / 2
    });
  })

  // center
  ("return", ["cmd", "shift"], function () {
    if (!curw()) return;
    curw().setFrame({
      x: screenWidth() / 8,
      y: screenHeight() / 8,
      width: 3 * (screenWidth() / 4),
      height: 3 * (screenHeight() / 4)
    });
  })

  // increase size
  ("]", ["cmd", "shift"], function () {
    if (!curw()) return;
    curw().setFrame({
      x: curw().frame().x - (INCREMENT / 2),
      y: curw().frame().y - (INCREMENT / 2),
      width: curw().frame().width + INCREMENT,
      height: curw().frame().height + INCREMENT
    });
  })

  // decrease size
  ("[", ["cmd", "shift"], function () {
    if (!curw()) return;
    curw().setFrame({
      x: curw().frame().x + (INCREMENT / 2),
      y: curw().frame().y + (INCREMENT / 2),
      width: curw().frame().width - INCREMENT,
      height: curw().frame().height - INCREMENT
    });
  })
// BIND

function curw () {
  return w.focusedWindow();
}

function screenWidth () {
  return curw().screen().visibleFrameInRectangle().width;
}

function screenHeight () {
  return curw().screen().visibleFrameInRectangle().height;
}

// chainable key binding function
function bind (key, modifiers, cb) {
  k.on(key, modifiers, cb);
  return bind;
}

function alert (msg) {
  var modal = new Modal();
  modal.message = msg;
  modal.duration = 2;
  modal.show();
}
