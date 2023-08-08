Option Explicit

Check_HasDYw

Sub Check_HasDYw() 

Dim xlApp 

Set xlApp = GetObject(,"Excel.Application")

With xlApp

.Visible = True

.Workbooks("Reserve Model Selections.xlsm").Activate

.Range("HasDYw").Copy

End With

End Sub 

