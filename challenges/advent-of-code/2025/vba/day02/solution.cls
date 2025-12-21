VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Sheet3"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Sub advCode20252b()
' Advent of code 2025. Day 2 part II
' Unsolved yet
' to be completed

    Dim wb As Workbook
    Dim sh As Worksheet
    Dim rng As Range
    Dim i As Long, j As Long, c As Long
    Dim sq As LongLong, rg As Long
    Dim n1 As Long, n2 As Long, sm As LongLong
    Dim pt As Long
    Dim sz As Long
    Dim s As String
    Dim ids As Variant
    Dim idstr As Variant
    Dim r As Variant
    
    
    Set wb = ThisWorkbook
    Set sh = wb.Worksheets("Adv2025_2")
    Set rng = sh.Range("A1")
    
    ids = rng.Value
    idstr = Split(Trim(CStr(ids)), ",") ' get range data separating by colon
    c = 0
    sm = 0
    For i = LBound(idstr) To UBound(idstr)
        r = Split(idstr(i), "-") 'split every range by hyphen
        rg = Abs(r(1) - r(0))
        For j = 0 To rg
            sq = r(0) + j  ' creting a sequence of numbers
            s = CStr(sq)
            sz = Len(s)
            If sz Mod 2 = 0 Then
                pt = sz \ 2
                n1 = Mid(s, 1, pt)
                n2 = Mid(s, pt + 1)
                If n1 = n2 Then
                    Debug.Print ("number id:" & sq & " Invalid ")
                    c = c + 1
                    sm = sm + sq
                End If
            End If
        Next j
    Next i
    Debug.Print ("-----")
    Debug.Print ("Total invalid IDs: " & c)
    Debug.Print ("Sum invalid IDs: " & sm)
End Sub


Sub advCode20252a()
    Dim wb As Workbook
    Dim sh As Worksheet
    Dim rng As Range
    Dim i As Long, j As Long, c As Long
    Dim sq As LongLong, rg As Long
    Dim n1 As Long, n2 As Long, sm As LongLong
    Dim pt As Long
    Dim sz As Long
    Dim s As String
    Dim ids As Variant
    Dim idstr As Variant
    Dim r As Variant
    
    
    Set wb = ThisWorkbook
    Set sh = wb.Worksheets("Adv2025_2")
    Set rng = sh.Range("A1")
    
    ids = rng.Value
    idstr = Split(Trim(CStr(ids)), ",") ' get range data separating by colon
    c = 0
    sm = 0
    For i = LBound(idstr) To UBound(idstr)
        r = Split(idstr(i), "-") 'split every range by hyphen
        rg = Abs(r(1) - r(0))
        For j = 0 To rg
            sq = r(0) + j  ' creting a sequence of numbers
            s = CStr(sq)
            sz = Len(s)
            If sz Mod 2 = 0 Then
                pt = sz \ 2
                n1 = Mid(s, 1, pt)
                n2 = Mid(s, pt + 1)
                If n1 = n2 Then
                    Debug.Print ("number id:" & sq & " Invalid ")
                    c = c + 1
                    sm = sm + sq
                End If
            End If
        Next j
    Next i
    Debug.Print ("-----")
    Debug.Print ("Total invalid IDs: " & c)
    Debug.Print ("Sum invalid IDs: " & sm)
    sh.Cells(1, 2) = "Sum Invalid IDs Part I"
    sh.Cells(2, 2) = sm
End Sub
