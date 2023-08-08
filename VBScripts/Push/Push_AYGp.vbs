Option Explicit

Push_AYGp

Sub Push_AYGp()

Dim xlApp

Set xlApp = GetObject(,"Excel.Application")

With xlApp

.Visible = True

.ScreenUpdating = FALSE

.Workbooks("Reserve Model Selections.xlsm").Activate

.Worksheets("AYGp").Activate

.Range("A1").Activate

.ActiveCell.PasteSpecial

.ScreenUpdating = TRUE

.Range("A1").Activate

End With

End Sub

