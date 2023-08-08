Option Explicit

Load_AVPlot

Sub Load_AVPlot() 

Dim xlApp 

Dim StartCY

Set xlApp = GetObject(,"Excel.Application")

With xlApp

.Visible = True

.Workbooks("Reserve Model Selections.xlsm").Activate

.Run "'Reserve Model Selections.xlsm'!update_auto_validation_plot"

End With

End Sub 

