Option Explicit

Load_Images

Sub Load_Images() 

Dim xlApp 

Dim StartCY

Set xlApp = GetObject(,"Excel.Application")

With xlApp

.Visible = True

.Workbooks("Reserve Model Selections.xlsm").Activate

.Run "'Reserve Model Selections.xlsm'!update_all_plots"

End With

End Sub 

