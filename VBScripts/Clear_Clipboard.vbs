Option Explicit

Clear_Clipboard

Sub Clear_Clipboard()

  Dim WshShell

  Set WshShell = WScript.CreateObject("WScript.Shell")
  WshShell.Run "cmd.exe /c echo. >NUL  | clip", 0, True

End Sub