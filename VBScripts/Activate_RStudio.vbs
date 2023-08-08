Option Explicit

Activate_RStudio

Sub Activate_RStudio()

  Dim WshShell

  Set WshShell = WScript.CreateObject("WScript.Shell")
  WshShell.AppActivate "RStudio"


End Sub