Option Explicit

Check_HasAYgpFilters

Sub Check_HasAYgpFilters() 

Dim xlApp 

Set xlApp = GetObject(,"Excel.Application")

With xlApp

.Visible = True

.Workbooks("Reserve Model Selections.xlsm").Activate

.Range("HasAYgpFilters").Copy

End With

End Sub 

