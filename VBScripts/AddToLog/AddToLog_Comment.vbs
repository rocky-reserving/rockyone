Option Explicit

AddToLog_Comment

Sub AddToLog_Comment() 

Dim xlApp 

Dim NumLog

Dim CommentCol, CommentOffset

Set xlApp = GetObject(,"Excel.Application")

With xlApp

.Visible = True

.Workbooks("Reserve Model Selections.xlsm").Activate

.Worksheets("Log").Activate

.Range("A1").Activate

.ScreenUpdating = FALSE

End With

NumLog = xlApp.Range("NumLog").Value

CommentCol = xlApp.Range("CommentCol").Value

CommentOffset = CommentCol - 1

With xlApp

.ActiveCell.Offset(NumLog, CommentOffset).PasteSpecial

.Range("A1").Activate

.ScreenUpdating = TRUE

End With

End Sub 

