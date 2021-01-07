#NoEnv
#Warn
#SingleInstance Force

SendMode Input
SetWorkingDir %A_ScriptDir%

ClipCursor(Confines := True, Left := 100, Top := 200, Right := 800, Bottom := 900)
{
    if !(Confines)
        return DllCall("user32.dll\ClipCursor")
    static RECT, init := VarSetCapacity(RECT, 16, 0)
    NumPut(Left, RECT, 0, "Int"), NumPut(Top, RECT, 4, "Int"), NumPut(Right, RECT, 8, "Int"), NumPut(Bottom, RECT, 12, "Int")
    if !(DllCall("user32.dll\ClipCursor", "Ptr", &RECT))
        return DllCall("kernel32.dll\GetLastError")
    return 1
}

XButton1::
CoordMode, Mouse, Screen
MouseGetPos, , y
ClipCursor(True, 0, y, A_ScreenWidth, y + 1)	; lock to horizontal axis
KeyWait XButton1
ClipCursor(False)
Return

XButton2::
CoordMode, Mouse, Screen
MouseGetPos, x
ClipCursor(True, x, 0, x + 1, A_ScreenHeight)	; lock to vertical axis
KeyWait XButton2
ClipCursor(False)
Return
