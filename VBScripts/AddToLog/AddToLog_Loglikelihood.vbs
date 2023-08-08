Option Explicit

AddToLog_Loglikelihood

Sub AddToLog_Loglikelihood() 

Dim xlApp 

Dim NumLog

Dim LLCol, LLOffset

Set xlApp = GetObject(,"Excel.Application")

With xlApp

.Visible = True

.Workbooks("Reserve Model Selections.xlsm").Activate

.Worksheets("Log").Activate

.Range("A1").Activate

End With

NumLog = xlApp.Range("NumLog").Value

LLCol = xlApp.Range("LoglikelihoodCol").Value

LLOffset = LLCol - 1

With xlApp

.ActiveCell.Offset(NumLog, LLOffset).PasteSpecial

.Range("A1").Activate

End With

End Sub 

