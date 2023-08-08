Option Explicit

PushToExcel_AYGp

Sub PushToExcel_AYGp() 

  Dim xlApp 
  Dim xlBook
  Dim StartCell, EndCell, TabName 

  Set xlApp = GetObject(,"Excel.Application")
  With xlApp
    .Visible = True
    .Windows("Excel Output.xlsx").Activate
  End With
  
  StartCell = xlApp.Range("DATA1_StartCell").Value
  TabName = xlApp.Range("DATA1_TabName").Value
  
  With xlApp
    .Sheets(TabName).Activate
    .Range(StartCell).PasteSpecial
    .Range("A1").Activate
  End With

End Sub 