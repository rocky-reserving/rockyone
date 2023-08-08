Option Explicit

AddToLog_ID

Sub AddToLog_ID() 

Dim xlApp 

Dim PrevID, NewID

Dim NumLog

Set xlApp = GetObject(,"Excel.Application")

With xlApp

.Visible = True

.Workbooks("test.xlsx").Activate

.Worksheets("Log").Activate

.Range("A1").Activate

End With

NumLog = xlApp.Range("NumLog").Value

With xlApp

.ActiveCell.Offset(NumLog, 0).Activate

End With

PrevID = xlApp.ActiveCell.Value

NewID = PrevID + 1

With xlApp

.ActiveCell.Offset(1, 0).Activate

.ActiveCell.Value = NewID

.Range("A1").Activate

End With

End Sub 

