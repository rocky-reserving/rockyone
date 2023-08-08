Option Explicit

Push_SummaryOutput

Sub Push_SummaryOutput() 

Dim xlApp

Dim PasteLoc

Set xlApp = GetObject(,"Excel.Application")

With xlApp

.Visible = True

.ScreenUpdating = FALSE

.Workbooks("Reserve Model Selections.xlsm").Activate

End With

PasteLoc = xlApp.Range("SummaryPasteLoc").Value

With xlApp

.Worksheets("Summary Output").Activate

.Range("A" & PasteLoc).PasteSpecial

.ScreenUpdating = TRUE

.Range("A1").Activate

End With

End Sub 

