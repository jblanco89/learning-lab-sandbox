VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Hoja2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Sub advCode20256a()
    Dim wb As Workbook
    Dim sh As Worksheet
    Dim i As Long, j As Long
    Dim maxRow As Long
    Dim rowData As String
    Dim values() As String
    Dim operators() As String
    Dim colResults() As Variant
    Dim numCols As Long
    Dim sumRes As LongLong
     
    Set wb = ThisWorkbook
    Set sh = wb.Worksheets("Adv2025_6")
     
    maxRow = sh.Cells(sh.Rows.Count, 1).End(xlUp).row
     
    rowData = Trim(sh.Cells(maxRow, 1).Value)
    rowData = Application.WorksheetFunction.Trim(rowData) ' Erase multiple blanks
    operators = Split(rowData, " ")
    numCols = UBound(operators) + 1
    
    ReDim colResults(0 To UBound(operators))
    For j = 0 To UBound(operators)
        If Trim(operators(j)) = "*" Then
            colResults(j) = 1
        Else
            colResults(j) = 0
        End If
    Next j
     
    For i = 1 To maxRow - 1
        rowData = Trim(sh.Cells(i, 1).Value)
        rowData = Application.WorksheetFunction.Trim(rowData) ' Erase multiple blanks
        values = Split(rowData, " ")
         
        For j = 0 To UBound(values)
            If j <= UBound(operators) And IsNumeric(values(j)) Then
                If Trim(operators(j)) = "*" Then
                    colResults(j) = colResults(j) * CLngLng(values(j))
                ElseIf Trim(operators(j)) = "+" Then
                    colResults(j) = colResults(j) + CLngLng(values(j))
                End If
            End If
        Next j
    Next i
     
    sumRes = 0
    Debug.Print "Total Sum all operations:"
    For j = 0 To UBound(operators)
        sumRes = sumRes + colResults(j)
    Next j
    Debug.Print (sumRes)
    sh.Cells(1, 2) = "Total Sum all operations Part I"
    sh.Cells(2, 2) = sumRes
End Sub
    



