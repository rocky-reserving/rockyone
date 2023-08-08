Option Explicit

SaveWorkbook

Sub SaveWorkbook() 

Dim xlApp 

Set xlApp = GetObject(,"Excel.Application")

With xlApp

.ActiveWorkbook.Save

End With

End Sub 

