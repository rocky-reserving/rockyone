Option Explicit

AddToLog_CopyCurrentID

Sub AddToLog_CopyCurrentID() 

Dim xlApp 

Set xlApp = GetObject(,"Excel.Application")

With xlApp

.Visible = True

.Workbooks("test.xlsx").Activate

.Worksheets("Log").Activate

.Range("NumLog").Copy

End With

End Sub 

