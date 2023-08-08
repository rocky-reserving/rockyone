Option Explicit

PastePlot_AVResults

Sub PastePlot_AVResults() 

Dim xlApp 

Set xlApp = GetObject(,"Excel.Application")

With xlApp

.Visible = True

.ScreenUpdating = FALSE

.Workbooks("Reserve Model Selections.xlsm").Activate

.Worksheets("Validation").Activate

.Range("A12").Activate

.ActiveCell.PasteSpecial

.ScreenUpdating = TRUE

.Range("A1").Activate

End With

End Sub 

