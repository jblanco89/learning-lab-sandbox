VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Hoja3"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Sub advCode2025_7()
    Dim wb As Workbook
    Dim sh As Worksheet
    Dim rng As Range
    Dim i As Long, j As Long
    Dim maxRow As Long
    Dim grid As Variant
    Dim line As String
    Dim c As String
    Dim splits As Long
    Dim paths As Object
    Dim pathsTotal As LongLong
    Dim currentCount As LongLong
    Dim key As Variant
    
    Set wb = ThisWorkbook
    Set sh = wb.Worksheets("Adv2025_7")
      
    maxRow = sh.Cells(sh.Rows.Count, 1).End(xlUp).row
    Set rng = sh.Range("A1:A" & maxRow)
    grid = rng.Value
    
    splits = 0
    Set paths = CreateObject("Scripting.Dictionary")
    
    For i = 1 To UBound(grid, 1)
        line = Trim(grid(i, 1))
'        Debug.Print (line)
        ' Every char in the line
        For j = 1 To Len(line)
            c = Mid(line, j, 1)
            
            Select Case c
                Case "S"
                    ' Origin Point (j is 1-based)
                    paths(j) = 1
                    
                Case "^"
                    ' if paths exists then count as splitted ray
                    If paths.Exists(j) Then
                        splits = splits + 1
                        currentCount = paths(j)
                        
                        ' Left path
                        If paths.Exists(j - 1) Then
                            paths(j - 1) = paths(j - 1) + currentCount
                        Else
                            paths(j - 1) = currentCount
                        End If
                        
                        ' Right Path
                        If paths.Exists(j + 1) Then
                            paths(j + 1) = paths(j + 1) + currentCount
                        Else
                            paths(j + 1) = currentCount
                        End If
                        
                        ' Important: previous path must be deleted after division
                        paths.Remove (j)
                    End If
            End Select
        Next j
    Next i
    
    ' Total Paths (part II)
    pathsTotal = 0
    For Each key In paths.Keys
        pathsTotal = pathsTotal + paths(key)
    Next key


    Debug.Print "Splits: " & splits
    Debug.Print "Total Paths: " & pathsTotal
    sh.Cells(1, 3).Value = "Splits Part I:"
    sh.Cells(2, 3).Value = splits
    sh.Cells(1, 4).Value = "Total Rays Part II:"
    sh.Cells(2, 4).Value = pathsTotal
    
End Sub



