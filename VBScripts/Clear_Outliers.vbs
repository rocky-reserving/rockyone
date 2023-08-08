Option Explicit

On Error Resume Next

Clear_Outliers

Sub Clear_Outliers() 

Dim xlApp 

Set xlApp = GetObject(,"Excel.Application")

With xlApp

.Visible = True

.Workbooks("Reserve Model Selections.xlsm").Activate

.Worksheets("Outliers").Activate

.Range("Outliers").ClearContents

.Range("A2").Activate

.Worksheets("Log").Activate

.Range("A2").Activate

End With

End Sub 

