Option Explicit

AddToLog_R2

Sub AddToLog_R2() 

Dim xlApp 

Dim NumLog

Dim R2_Col, R2_Offset

Set xlApp = GetObject(,"Excel.Application")

With xlApp

.Visible = True

.Workbooks("Reserve Model Selections.xlsm").Activate

.Worksheets("Log").Activate

.Range("A1").Activate

End With

NumLog = xlApp.Range("NumLog").Value

R2_Col = xlApp.Range("RSqCol_Log").Value

R2_Offset = R2_Col - 1

With xlApp

.ActiveCell.Offset(NumLog, R2_Offset).PasteSpecial

.Range("A1").Activate

End With

End Sub 

