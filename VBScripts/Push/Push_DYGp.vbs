Option Explicit

Push_DYGp

Sub Push_DYGp() 

Dim xlApp 

Set xlApp = GetObject(,"Excel.Application")

With xlApp

.Visible = True

.ScreenUpdating = FALSE

.Workbooks("Reserve Model Selections.xlsm").Activate

.Worksheets("DYGp").Activate

.Range("A1").Activate

.ActiveCell.PasteSpecial

.ScreenUpdating = TRUE

.Range("A1").Activate

End With

End Sub 

