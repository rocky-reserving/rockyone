Option Explicit

On Error Resume Next

Clear_AYFilters

Sub Clear_AYFilters() 

Dim xlApp 

Set xlApp = GetObject(,"Excel.Application")

With xlApp

.Visible = True

.Workbooks("Reserve Model Selections.xlsm").Activate

.Worksheets("AYgpFilters").Activate

.Range("AY_gp_Filters").ClearContents

.Range("A2").Activate

End With

End Sub 

