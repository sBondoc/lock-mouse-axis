clipCursor(confines := True, left := 0, top := 0, right := 1080, bottom := 1) {
	if (!confines) {
		return DllCall("user32.dll\ClipCursor")
	}
	static RECT, init := VarSetCapacity(RECT, 16, 0)
	NumPut(left, RECT, 0, "Int"), NumPut(top, RECT, 4, "Int"), NumPut(right, RECT, 8, "Int"), NumPut(bottom, RECT, 12, "Int")
	if !(DllCall("user32.dll\ClipCursor", "Ptr", &RECT)) {
		return DllCall("kernel32.dll\GetLastError")
	}
	return 1
}

#NoEnv
#Warn
#SingleInstance Force

SendMode Input
SetWorkingDir %A_ScriptDir%

yLock := "XButton1"	; button to lock y-axis, allowing only horizontal movement on the x-axis
xLock := "XButton2"	; button to lock x-axis, allowing only vertical movement on the y-axis

clip := 0
xMin := 0
yMin := 0
xMax := A_ScreenWidth
yMax := A_ScreenHeight

Hotkey, %yLock%, LockX
Hotkey, %xLock%, LockY
Hotkey, %yLock% Up, UnlockX
Hotkey, %xLock% Up, UnlockY

Return

LockX:
clip++
CoordMode, Mouse, Screen
MouseGetPos, , y
yMin := y
yMax := y + 1
Goto, ClipRefresh

UnlockX:
clip--
yMin := 0
yMax := A_ScreenHeight
Goto, ClipRefresh

LockY:
clip++
CoordMode, Mouse, Screen
MouseGetPos, x
xMin := x
xMax := x + 1
Goto, ClipRefresh

UnlockY:
clip--
xMin := 0
xMax := A_ScreenWidth
Goto, ClipRefresh

ClipRefresh:
if (0 < clip) {
	clipCursor(True, xMin, yMin, xMax, yMax)
} else {
	clipCursor(False)
}
Return
