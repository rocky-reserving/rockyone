Option Explicit

AddToLog_ReserveStats

Sub AddToLog_ReserveStats() 

Dim xlApp 

Dim NumLog

Dim ForecastCol, ForecastOffset

Set xlApp = GetObject(,"Excel.Application")

With xlApp

.Visible = True

.Workbooks("Reserve Model Selections.xlsm").Activate

.Worksheets("Log").Activate

.Range("A1").Activate

End With

NumLog = xlApp.Range("NumLog").Value

ForecastCol = xlApp.Range("ForecastCol").Value

ForecastOffset = ForecastCol - 1

With xlApp

.ActiveCell.Offset(NumLog, ForecastOffset).PasteSpecial

.Range("A1").Activate

End With

End Sub 

