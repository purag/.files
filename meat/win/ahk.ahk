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

; Disable default bindings
!space :: return

; Snap bindings
snap_cells := { "a":  0
              , "s":  1
              , ";":  2
              , "'":  3
              , "z":  4
              , "x":  5
              , ".":  6
              , "/":  7}
snap_start_cell := ""

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
  global PADDING
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

PositionInGrid(cells, start, end) {
  global PADDING
  getScreenDimensions(x, y, width, height, "A")

  cols := cells / 2
  cellwidth := (width - ((cols - 1) * PADDING)) / cols
  cellheight := (height - PADDING) / 2

  startc := Mod(start, cols)
  startw := start // cols
  startl := x + (cellwidth + PADDING) * startc
  startt := y + (cellheight + PADDING) * startw
  startr := startl + cellwidth
  startb := startt + cellheight

  endc := Mod(end, cols)
  endw := end // cols
  endl := x + (cellwidth + PADDING) * endc
  endt := y + (cellheight + PADDING) * endw
  endr := endl + cellwidth
  endb := endt + cellheight

  left := (startl < endl ? startl : endl)
  top  := (startt < endt ? startt : endt)
  right := (startr > endr ? startr : endr)
  bottom := (startb > endb ? startb : endb)

  winmove, %snap_win_title%, , left, top, right - left, bottom - top
}

; Snap a window in the given direction
snapwin(cell) {
  global snap_start_cell
  if (snap_start_cell = "") {
    snap_start_cell := cell
  } else {
    PositionInGrid(8, snap_start_cell, cell)
    snap_start_cell := ""
  }
}

resizewin(dir, coeff) {
  global
  local x, y, scrwidth, scrheight, title, width, height
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
for key, cell in snap_cells {
  bind(MOD . key, "snapwin", cell)
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
