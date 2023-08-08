Option Explicit

Load_StartAY

Sub Load_StartAY() 

Dim xlApp 

Dim StartAY

Set xlApp = GetObject(,"Excel.Application")

With xlApp

.Visible = True

.Workbooks("Reserve Model Selections.xlsm").Activate

.Range("StartAY").Copy

End With

End Sub 

