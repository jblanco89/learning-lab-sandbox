VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Sheet2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Sub advCode20251b()
    Dim wb As Workbook
    Dim sh As Worksheet
    Dim rng As Range
    Dim inrng As Range
    Dim carea As Integer
    Dim cini As Integer
    Dim cini_start As Integer
    Dim v As Variant
    Dim data As Variant
    Dim i As Integer, n As Long, c As Long
    Dim rot As String
    Dim pzero As Boolean
    Dim pasbyzero As Long
    
    Set wb = ThisWorkbook
    Set sh = wb.Worksheets("Adv2025_1")
    Set rng = sh.Range("A1")
    Set inrng = wb.Worksheets("input_1").UsedRange
    
    inrng.Copy rng
    maxRow = sh.Cells(sh.Rows.Count, 1).End(xlUp).row
    data = sh.Range("A2:A" & maxRow).Value
    
    carea = 100
    cini = 50
    c = 0
    pzero = False
    For i = 1 To UBound(data, 1)
        v = Trim(data(i, 1))
        If v <> "" And Len(v) > 1 Then
            rot = Left(v, 1)
            n = CLng(Mid(v, 2))
            cini_start = cini
            pasbyzero = 0
            pzero = False
            
            If rot = "L" Then
                
                If cini_start = 0 Then
                    pasbyzero = n \ carea
                Else
                    If n >= cini_start Then
                        pzero = True
                        pasbyzero = 1
                        Dim stepre_l As Long
                        stepre_l = n - cini_start
                        If stepre_l > 0 Then
                            pasbyzero = pasbyzero + (stepre_l \ carea)
                        End If
                    End If
                End If
                
                cini = cini - n
                
            Else
                Dim stefr_zer As Long
                stefr_zer = carea - cini_start
                
                If n >= stefr_zer Then
                    pzero = True
                    pasbyzero = 1
                    Dim stepre_r As Long
                    stepre_l = n - stefr_zer
                    If stepre_l > 0 Then
                        pasbyzero = pasbyzero + (stepre_l \ carea)
                    End If
                End If
                
                cini = cini + n
                
            End If
            
            c = c + pasbyzero
            
            Do While cini < 0
                cini = cini + carea
            Loop
    
            If cini >= carea Then
                cini = cini Mod carea
            End If
            
            Debug.Print (cini)
        End If
    Next i
    Debug.Print ("------")
    Debug.Print (c)
    sh.Cells(1, 3) = "Pasword Part II"
    sh.Cells(2, 3) = c
End Sub

Sub advCode20251a()
    Dim wb As Workbook
    Dim sh As Worksheet
    Dim rng As Range
    Dim inrng As Range
    Dim carea As Integer
    Dim cini As Integer
    Dim v As Variant
    Dim data As Variant
    Dim i As Integer, n As Integer, c As Integer
    Dim rot As String
    
    Set wb = ThisWorkbook
    Set sh = wb.Worksheets("Adv2025_1")
    Set rng = sh.Range("A1")
    Set inrng = wb.Worksheets("input_1").UsedRange
    
    inrng.Copy rng
    maxRow = sh.Cells(sh.Rows.Count, 1).End(xlUp).row
    data = sh.Range("A2:A" & maxRow).Value
    
    'carea = 10
    'cini = 5
    
    ' simulation
    '    ->5
    'L6  ->9
    'R1  ->0
    'R2  ->2
    'L8  ->4
    'R4  ->8
    'R8  ->6
    'L6  ->0
    'R12 ->2
    'L2  ->0
    
    'data = Array("L6", "R1", "R2", "L8", "R4", "R8", "L6", "R12", "L2")
    
    carea = 100
    cini = 50
    c = 0
    For i = 1 To UBound(data, 1)
'    For i = 0 To 8
        v = Trim(data(i, 1))
    '    v = data(i)
         If v <> "" And Len(v) > 1 Then
            rot = Left(v, 1)
            n = CInt(Mid(v, 2))
            If rot = "L" Then
                cini = cini - n
            Else
                cini = cini + n
            End If
            Do While cini < 0
                cini = cini + carea
            Loop
    
            If cini >= carea Then
                cini = cini Mod carea
            End If
            If cini = 0 Then
                c = c + 1
            End If
        Debug.Print (cini)
        End If
    Next i
    Debug.Print ("------")
    Debug.Print (c)
    sh.Cells(1, 2) = "Pasword Part I"
    sh.Cells(2, 2) = c
End Sub

