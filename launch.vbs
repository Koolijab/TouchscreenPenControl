Set oShell = CreateObject ("Wscript.Shell") 
Dim strArgs
strArgs = "cmd /c setTouchscreen.bat"
oShell.Run strArgs, 0, false