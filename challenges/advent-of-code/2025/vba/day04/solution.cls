VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Sheet5"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Sub advCode20253a()
    Dim wb As Workbook
    Dim sh As Worksheet
    Dim rng As Range
    Dim xdir As Variant
    Dim ydir As Variant
    Dim rollDiag As Variant
    Dim maxRow As Long
    Dim i As Long, j As Long, ps As Long
    Dim rollRow As String, roll As String
    Dim xneig As Long, yneig As Long
    Dim neigRow As String, neigChar As String
    Dim neighborCount As Long
    Dim accessibleCount As Long
    
    Set wb = ThisWorkbook
    Set sh = wb.Worksheets("Adv2025_4")
    
    maxRow = sh.UsedRange.Rows.Count
    Set rng = sh.Range("A1:A" & maxRow)
    
    rollDiag = rng.Value
    xdir = Array(1, 1, 0, -1, -1, -1, 0, 1)
    ydir = Array(0, 1, 1, 1, 0, -1, -1, -1)
    
    rollCount = 0
    
    For i = 1 To UBound(rollDiag)
        rollRow = rollDiag(i, 1)
        For j = 1 To Len(rollRow)
            roll = Mid(rollRow, j, 1)
            If roll = "@" Then
                neighborCount = 0
                ' Contar vecinos @ en las 8 posiciones adyacentes
                For ps = 0 To UBound(xdir)
                    xneig = j + xdir(ps)
                    yneig = i + ydir(ps)
                    If yneig >= 1 And yneig <= UBound(rollDiag, 1) Then
                        neigRow = rollDiag(yneig, 1)
                        If xneig >= 1 And xneig <= Len(neigRow) Then
                            neigChar = Mid(neigRow, xneig, 1)
                            If neigChar = "@" Then
                                neighborCount = neighborCount + 1
                            End If
                        End If
                    End If
                Next ps
                
                ' Si tiene menos de 4 vecinos @, es accesible
                If neighborCount < 4 Then
                    rollCount = rollCount + 1
                    Debug.Print "Roll accesible en (" & i & ", " & j & ") con " & neighborCount & " vecinos"
                End If
            End If
        Next j
    Next i
    Debug.Print "Total Rolls: " & rollCount
    sh.Cells(1, 2) = "Total Rolls Part I"
    sh.Cells(2, 2) = rollCount
End Sub
    
