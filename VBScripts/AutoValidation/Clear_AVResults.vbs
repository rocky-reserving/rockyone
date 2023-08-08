Option Explicit

Clear_AVResults

Sub Clear_AVResults() 

Dim xlApp 

Set xlApp = GetObject(,"Excel.Application")

With xlApp

.Visible = True

.ScreenUpdating = FALSE

.Workbooks("Reserve Model Selections.xlsm").Activate

.Worksheets("Validation").Activate

.Range("A2").Activate

.ActiveCell.PasteSpecial

.ScreenUpdating = TRUE

.Range("A1").Activate

End With

End Sub 

