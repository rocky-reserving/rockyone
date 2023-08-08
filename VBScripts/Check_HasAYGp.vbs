Option Explicit

Check_HasAYGp

Sub Check_HasAYGp() 

Dim xlApp 

Set xlApp = GetObject(,"Excel.Application")

With xlApp

.Visible = True

.Workbooks("Reserve Model Selections.xlsm").Activate

.Range("HasAYGp").Copy

End With

End Sub 

