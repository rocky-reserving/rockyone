Option Explicit

Check_HasCYGp

Sub Check_HasCYGp() 

Dim xlApp 

Set xlApp = GetObject(,"Excel.Application")

With xlApp

.Visible = True

.Workbooks("Reserve Model Selections.xlsm").Activate

.Range("HasCYGp").Copy

End With

End Sub 

