PADDING := 10
F := "fill"
N := "north"
S := "south"
W := "west"
E := "east"
NW := "nw"
NE := "ne"
SW := "sw"
SE := "se"

MOD := "+#"

; Snap bindings
snap_dirs := { "Up":    F
             , "Left":  W
             , "Right": E
             , "a":     NW
             , "'":     NE
             , "z":     SW
             , "/":     SE}

; Padded screen size helpers
screenOrigin := { x: PADDING - 4 ; this is ugly because windows seem to have an invisible left border
                , y: PADDING}
screenWidth  := A_ScreenWidth - PADDING * 2 + 4 ; and I have to account for it here :(
screenHeight := A_ScreenHeight - PADDING * 2

; Snap a window in the given direction
snapwin(dir) {
  global
  wingetactivetitle, title

  local x := screenOrigin.x
  local y := screenOrigin.y
  local width := (screenWidth - PADDING) / 2
  local height := (screenHeight - PADDING) / 2

  if (dir = E OR dir = NE OR dir = SE)
    x := x + screenWidth - width
  if (dir = SE OR dir = SW)
    y := y + screenHeight - height
  if (dir = F)
    width := screenWidth
  if (dir = F OR dir = E OR dir = W)
    height := screenHeight

  winmove, %title%, , %x%, %y%, %width%, %height%
}

for key, dir in snap_dirs {
  bind(MOD . key, "snapwin", dir)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Custom dynamic binding of hotkeys ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

bind(key, f, a*) {
  static hotkeys := {}
  hotkeys[key] := {}
  hotkeys[key].f := f
  hotkeys[key].a := a
  Hotkey, %key%, handler
  return

  handler:
    hotkeys[A_ThisHotkey].f(hotkeys[A_ThisHotkey].a*)
  return
}