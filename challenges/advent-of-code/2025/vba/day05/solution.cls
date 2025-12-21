VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Hoja1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Sub advCode20255a()
    Dim wb As Workbook
    Dim sh As Worksheet
    Dim rngA As Range
    Dim rngB As Range
    Dim invRng As Variant
    Dim ingre As Variant
    Dim rngsSp As Variant
    Dim i As Long, j As Long, k As Long
    Dim maxRowA As Long, maxRowB As Long
    
    
    Set wb = ThisWorkbook
    Set sh = wb.Worksheets("Adv2025_5")
    
    maxRowA = sh.Cells(sh.Rows.Count, 1).End(xlUp).row
    maxRowB = sh.Cells(sh.Rows.Count, 2).End(xlUp).row
    Set rngA = sh.Range("A1:A" & maxRowA)
    Set rngB = sh.Range("B1:B" & maxRowB)
    
    invRng = rngA.Value
    ingre = rngB.Value
    c = 0
    For i = 1 To UBound(ingre)
        v = CLngLng(ingre(i, 1))
        For k = 1 To UBound(invRng)
            rngs = invRng(k, 1)
            rngsSp = Split(rngs, "-")
            a = rngsSp(0)
            b = rngsSp(1)
            r = Abs(b - a)
            If v >= CLngLng(a) And v <= CLngLng(b) Then
                Debug.Print ("value: " & v & " In range " & rngs & " -> " & "Fresh")
                c = c + 1
                Exit For
            End If
        Next k
    Next i
    Debug.Print (c)
    sh.Cells(1, 3) = "Total Fresh Part I"
    sh.Cells(2, 3) = c
End Sub


Sub advCode20255b()
    Dim wb As Workbook
    Dim sh As Worksheet
    Dim rngA As Range
    Dim invRng As Variant
    Dim rngsSp As Variant
    Dim k As Long
    Dim maxRowA As Long
    Dim rngs As String
    Dim a As LongLong, b As LongLong
    Dim c As LongLong
    Dim i As Long, j As Long
    
    ' Arrays para almacenar los rangos
    Dim ranges() As Variant
    Dim numRanges As Long
    Dim temp As Variant
    Dim merged() As Variant
    Dim mergedCount As Long
    
    Set wb = ThisWorkbook
    Set sh = wb.Worksheets("Adv2025_5")
    maxRowA = sh.Cells(sh.Rows.Count, 1).End(xlUp).row
    Set rngA = sh.Range("A1:A" & maxRowA)
    
    invRng = rngA.Value
    numRanges = UBound(invRng)
    
    ' Paso 1: Leer todos los rangos
    ReDim ranges(1 To numRanges, 1 To 2)
    For k = 1 To numRanges
        rngs = invRng(k, 1)
        rngsSp = Split(rngs, "-")
        ranges(k, 1) = CLngLng(rngsSp(0)) ' inicio
        ranges(k, 2) = CLngLng(rngsSp(1)) ' fin
    Next k
    
    ' Paso 2: Ordenar rangos por inicio (Bubble Sort simple)
    For i = 1 To numRanges - 1
        For j = i + 1 To numRanges
            If ranges(i, 1) > ranges(j, 1) Then
                ' Intercambiar
                temp = ranges(i, 1)
                ranges(i, 1) = ranges(j, 1)
                ranges(j, 1) = temp
                
                temp = ranges(i, 2)
                ranges(i, 2) = ranges(j, 2)
                ranges(j, 2) = temp
            End If
        Next j
    Next i
    
    ' Paso 3: Fusionar rangos solapados
    ReDim merged(1 To numRanges, 1 To 2)
    merged(1, 1) = ranges(1, 1)
    merged(1, 2) = ranges(1, 2)
    mergedCount = 1
    
    For k = 2 To numRanges
        ' Si el rango actual se solapa con el último fusionado
        If ranges(k, 1) <= merged(mergedCount, 2) + 1 Then
            ' Fusionar: extender el fin si es necesario
            If ranges(k, 2) > merged(mergedCount, 2) Then
                merged(mergedCount, 2) = ranges(k, 2)
            End If
        Else
            ' No se solapa, añadir nuevo rango
            mergedCount = mergedCount + 1
            merged(mergedCount, 1) = ranges(k, 1)
            merged(mergedCount, 2) = ranges(k, 2)
        End If
    Next k
    
    ' Paso 4: Contar total de IDs en rangos fusionados
    c = 0
    For k = 1 To mergedCount
        a = merged(k, 1)
        b = merged(k, 2)
        c = c + (b - a + 1)
        Debug.Print "Merged range: " & a & "-" & b & " contains " & (b - a + 1) & " IDs"
    Next k
    
    Debug.Print "========================================="
    Debug.Print "Total fresh IDs: " & c
    sh.Cells(1, 4) = "Total fresh ID's Part II"
    sh.Cells(2, 4) = c
End Sub
