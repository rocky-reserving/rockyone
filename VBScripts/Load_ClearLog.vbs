Option Explicit

On Error Resume Next

Load_ClearLog

Sub Load_ClearLog() 

Dim xlApp 

Set xlApp = GetObject(,"Excel.Application")

With xlApp

.Visible = True

.Workbooks("Reserve Model Selections.xlsm").Activate

.Worksheets("Log").Activate

.Range("A1").Activate

End With

With xlApp

.Range("Log").ClearContents

.Range("A1").Activate

End With

End Sub 

