Option Explicit

Push_CYGp

Sub Push_CYGp() 

Dim xlApp 

Set xlApp = GetObject(,"Excel.Application")

With xlApp

.Visible = True

.ScreenUpdating = FALSE

.Workbooks("Reserve Model Selections.xlsm").Activate

.Worksheets("CYGp").Activate

.Range("A1").Activate

.ActiveCell.PasteSpecial

.ScreenUpdating = TRUE

.Worksheets("CYGp").Range("A1").Activate

End With

End Sub 

