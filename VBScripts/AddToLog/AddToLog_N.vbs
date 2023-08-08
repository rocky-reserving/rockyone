Option Explicit

AddToLog_N

Sub AddToLog_N() 

Dim xlApp 

Dim NumLog

Dim N_Col, N_Offset

Set xlApp = GetObject(,"Excel.Application")

With xlApp

.Visible = True

.Workbooks("Reserve Model Selections.xlsm").Activate

.Worksheets("Log").Activate

.Range("A1").Activate

End With

NumLog = xlApp.Range("NumLog").Value

N_Col = xlApp.Range("NCol_Log").Value

N_Offset = N_Col - 1

With xlApp

.ActiveCell.Offset(NumLog, N_Offset).PasteSpecial

.Range("A1").Activate

End With

End Sub 

