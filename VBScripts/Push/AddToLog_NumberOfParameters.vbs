Option Explicit

AddToLog_NumberOfParameters

Sub AddToLog_NumberOfParameters() 

Dim xlApp 

Dim NumLog

Dim NPara_Col, NPara_Offset

Set xlApp = GetObject(,"Excel.Application")

With xlApp

.Visible = True

.Workbooks("test.xlsx").Activate

.Worksheets("Log").Activate

.Range("A1").Activate

End With

NumLog = xlApp.Range("NumLog").Value

NPara_Col = xlApp.Range("NParaCol_Log").Value

NPara_Offset = NPara_Col - 1

With xlApp

.ActiveCell.Offset(NumLog, NPara_Offset).PasteSpecial

.Range("A1").Activate

End With

End Sub 

