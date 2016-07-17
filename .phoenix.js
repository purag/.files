var w = Window;
var a = App;
var s = Screen;
var k = Key;

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
      y: screenHeight() / 2,
      width: screenWidth() / 2 + 24,
      height: screenHeight() / 2
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
