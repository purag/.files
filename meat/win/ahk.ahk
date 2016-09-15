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
ALTMOD := "+!"

INCREMENT := 50

; Snap bindings
snap_dirs := { "Up": F
             , "s":  W
             , ";":  E
             , "a":  NW
             , "'":  NE
             , "x":  SW
             , ".":  SE}

size_dirs := { "h": W
             , "j": S
             , "k": N
             , "l": E}

opposite(dir) {
  global

  if (dir = N)
    return S
  else if (dir = S)
    return N
  else if (dir = W)
    return E
  else if (dir = E)
    return W
  else if (dir = NW)
    return SE
  else if (dir = NE)
    return SW
  else if (dir = SW)
    return NE
  else if (dir = SE)
    return NW
}

getScreenDimensions(ByRef x, ByRef y, ByRef width, ByRef height, wintitle) {
  global
  winHandle := WinExist(wintitle) ; The window to operate on

  ; https://autohotkey.com/boards/viewtopic.php?p=78862#p78862
  VarSetCapacity(monitorInfo, 40), NumPut(40, monitorInfo)
  monitorHandle := DllCall("MonitorFromWindow", "Ptr", winHandle, "UInt", 0x2)
  DllCall("GetMonitorInfo", "Ptr", monitorHandle, "Ptr", &monitorInfo)

  left   := NumGet(monitorInfo, 20, "Int")
  top    := NumGet(monitorInfo, 24, "Int")
  right  := NumGet(monitorInfo, 28, "Int")
  bottom := NumGet(monitorInfo, 32, "Int")

  x := left + PADDING
  y := top + PADDING
  width := right - left - PADDING * 2
  height := bottom - top - PADDING * 2
}

; Snap a window in the given direction
snapwin(dir) {
  global
  wingetactivetitle, title
  getScreenDimensions(x, y, scrwidth, scrheight, title)

  local width := (scrwidth - PADDING) / 2
  local height := (scrheight - PADDING) / 2

  if (dir = E OR dir = NE OR dir = SE)
    x := x + scrwidth - width
  if (dir = SE OR dir = SW)
    y := y + scrheight - height
  if (dir = F OR dir = M)
    width := scrwidth
  if (dir = F OR dir = M OR dir = E OR dir = W)
    height := scrheight

  winmove, %title%, , %x%, %y%, %width%, %height%
}

resizewin(dir, coeff) {
  global
  wingetactivetitle, title

  wingetpos, x, y, width, height, %title%

  if (dir = W)
    x := x + coeff * -1
  if (dir = N)
    y := y + coeff * -1
  if (dir = E OR dir = W)
    width := width + coeff
  if (dir = N OR dir = S)
    height := height + coeff

  winmove, %title%, , %x%, %y%, %width%, %height%
}

; Snap bindings
for key, dir in snap_dirs {
  bind(MOD . key, "snapwin", dir)
}

; Size bindings
for key, dir in size_dirs {
  opp := opposite(dir)
  bind(MOD . key, "resizewin", dir, INCREMENT)
  bind(ALTMOD . key, "resizewin", opp, -INCREMENT)
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
