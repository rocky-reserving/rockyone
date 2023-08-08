Option Explicit

AddToLog_I_f

Sub AddToLog_I_f() 

Dim xlApp 

Dim NumLog

Dim If_Col, If_Offset

Set xlApp = GetObject(,"Excel.Application")

With xlApp

.Visible = True

.Workbooks("test.xlsx").Activate

.Worksheets("Log").Activate

.Range("A1").Activate

End With

NumLog = xlApp.Range("NumLog").Value

If_Col = xlApp.Range("FutureCYCol_Log").Value

If_Offset = If_Col - 1

With xlApp

.ActiveCell.Offset(NumLog, If_Offset).PasteSpecial

.Range("A1").Activate

End With

End Sub 

