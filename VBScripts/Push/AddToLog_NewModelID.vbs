Option Explicit

AddToLog_NewModelID

Sub AddToLog_NewModelID() 

Dim xlApp 

Set xlApp = GetObject(,"Excel.Application")

With xlApp

.Visible = True

.Workbooks("test.xlsx").Activate

.Worksheets("Log").Activate

.Range("A2").Value = 1

.Range("A1").Activate

End With

End Sub 

