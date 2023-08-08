Option Explicit

AddToLog_LoadModel

Sub AddToLog_LoadModel() 

Dim xlApp 

Set xlApp = GetObject(,"Excel.Application")

With xlApp

.Visible = True

.Workbooks("Reserve Model Selections.xlsm").Activate

.Worksheets("Log").Activate

.Range("A2").PasteSpecial

.Range("A1").Activate

End With

End Sub 

