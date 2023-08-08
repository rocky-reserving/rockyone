Option Explicit

Check_HasCYpt

Sub Check_HasCYpt() 

Dim xlApp 

Set xlApp = GetObject(,"Excel.Application")

With xlApp

.Visible = True

.Workbooks("Reserve Model Selections.xlsm").Activate

.Range("HasCYpt").Copy

End With

End Sub 

