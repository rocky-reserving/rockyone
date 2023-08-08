Option Explicit

Check_HasDYGp

Sub Check_HasDYGp() 

Dim xlApp 

Set xlApp = GetObject(,"Excel.Application")

With xlApp

.Visible = True

.Workbooks("Reserve Model Selections.xlsm").Activate

.Range("HasDYGp").Copy

End With

End Sub 

