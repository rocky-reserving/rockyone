Option Explicit

Load_StartCY

Sub Load_StartCY() 

Dim xlApp 

Dim StartCY

Set xlApp = GetObject(,"Excel.Application")

With xlApp

.Visible = True

.Workbooks("Reserve Model Selections.xlsm").Activate

.Range("StartCY").Copy

End With

End Sub 

