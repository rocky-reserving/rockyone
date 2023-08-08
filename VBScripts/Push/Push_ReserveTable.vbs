Option Explicit

Push_ReserveTable

Sub Push_ReserveTable()

Dim xlApp

Set xlApp = GetObject(,"Excel.Application")

With xlApp

.Visible = True

.ScreenUpdating = FALSE

.Workbooks("Reserve Model Selections.xlsm").Activate

.Run "'Reserve Model Selections.xlsm'!ClearResTable.clearReserveTable"

.Worksheets("Reserve Table").Activate

.Range("AM1").Activate

.ActiveCell.PasteSpecial

.ScreenUpdating = TRUE

.Range("A1").Activate

.Worksheets("Log").Activate

End With

End Sub

