Option Explicit

Check_HasDYwGp

Sub Check_HasDYwGp() 

Dim xlApp 

Set xlApp = GetObject(,"Excel.Application")

With xlApp

.Visible = True

.Workbooks("Reserve Model Selections.xlsm").Activate

.Range("HasDYwGp").Copy

End With

End Sub 

