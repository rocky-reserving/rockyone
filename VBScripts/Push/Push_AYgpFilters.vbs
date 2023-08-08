Option Explicit

Push_AYgpFilters

Sub Push_AYgpFilters() 

Dim xlApp 

Set xlApp = GetObject(,"Excel.Application")

With xlApp

.Visible = True

.ScreenUpdating = FALSE

.Workbooks("Reserve Model Selections.xlsm").Activate

.Worksheets("AYgpFilters").Activate

.Range("A1").Activate

.ActiveCell.PasteSpecial

.ScreenUpdating = TRUE

.Worksheets("Log").Activate

.Range("A1").Activate

End With

End Sub 

