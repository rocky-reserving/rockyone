Option Explicit

AddToLog_NewModelID

Sub AddToLog_NewModelID() 

Dim xlApp 

Set xlApp = GetObject(,"Excel.Application")

With xlApp

.Visible = True

.Workbooks("Reserve Model Selections.xlsm").Activate

.Worksheets("Log").Activate

.Range("A2").Value = 1

.Range("A1").Activate

End With

End Sub 

