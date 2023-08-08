Option Explicit

Push_Outliers

Sub Push_Outliers() 

Dim xlApp 

Set xlApp = GetObject(,"Excel.Application")

With xlApp

.Visible = True

.ScreenUpdating = FALSE

.Workbooks("Reserve Model Selections.xlsm").Activate

.Worksheets("Outliers").Activate

.Range("A2").Activate

.ActiveCell.PasteSpecial

.ScreenUpdating = TRUE

.Worksheets("Log").Activate

.Range("A2").Activate

End With

End Sub 

