Option Explicit

Push_CYpt

Sub Push_CYpt() 

Dim xlApp 

Set xlApp = GetObject(,"Excel.Application")

With xlApp

.Visible = True

.ScreenUpdating = FALSE

.Workbooks("Reserve Model Selections.xlsm").Activate

.Worksheets("CYpt").Activate

.Range("A1").Activate

.ActiveCell.PasteSpecial

.ScreenUpdating = TRUE

.Worksheets("CYpt").Range("A1").Activate

End With

End Sub 

