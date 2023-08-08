Option Explicit

AddToLog_G_f

Sub AddToLog_G_f() 

Dim xlApp 

Dim NumLog

Dim Gf_Col, Gf_Offset

Set xlApp = GetObject(,"Excel.Application")

With xlApp

.Visible = True

.Workbooks("test.xlsx").Activate

.Worksheets("Log").Activate

.Range("A1").Activate

End With

NumLog = xlApp.Range("NumLog").Value

Gf_Col = xlApp.Range("FutureDYCol_Log").Value

Gf_Offset = Gf_Col - 1

With xlApp

.ActiveCell.Offset(NumLog, Gf_Offset).PasteSpecial

.Range("A1").Activate

End With

End Sub 

