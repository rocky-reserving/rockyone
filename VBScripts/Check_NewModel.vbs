Option Explicit

Check_NewModel

Sub Check_NewModel() 

Dim xlApp 

Set xlApp = GetObject(,"Excel.Application")

With xlApp

.Visible = True

.Workbooks("Reserve Model Selections.xlsm").Activate

.Range("NewModel").Copy

End With

End Sub 

