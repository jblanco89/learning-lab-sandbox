VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Hoja4"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Sub adv20258()
    Dim sh As Worksheet, drawSh As Worksheet
    Dim edges() As Edge
    Dim animEdges() As Edge
    Dim boxes As Long
    Dim t0 As Double, t1 As Double

    Set sh = ThisWorkbook.Worksheets("Adv2025_8")
    boxes = sh.Cells(sh.Rows.Count, 3).End(xlUp).row - 1
    
    t0 = NowSeconds
    edges = BuildEdges(sh, boxes)
    t1 = NowSeconds
    Debug.Print "BuildEdges: "; Format(t1 - t0, "0.000"); " s"
    Debug.Print "----------------------------------"
    
    t0 = NowSeconds
    SolvePart1 sh, edges, boxes
    t1 = NowSeconds
    Debug.Print "Part I time: "; Format(t1 - t0, "0.000"); " s"
    Debug.Print "----------------------------------"

    t0 = NowSeconds
    SolvePart2 sh, edges, boxes
    t1 = NowSeconds
    Debug.Print "Part II time: "; Format(t1 - t0, "0.000"); " s"
    Debug.Print "----------------------------------"
    
    t0 = NowSeconds
    ExportNodesCSV sh, 1000, ThisWorkbook.path
    ExportEdgesCSV execKruskal(1000, edges), ThisWorkbook.path
    t1 = NowSeconds
    Debug.Print "Exporting time: "; Format(t1 - t0, "0.000"); " s"
    Debug.Print "----------------------------------"
End Sub

Function BuildEdges(sh As Worksheet, boxes As Long) As Edge()
    Dim edges() As Edge
    Dim i As Long, j As Long, k As Long
    Dim x1 As Double, y1 As Double, z1 As Double
    Dim x2 As Double, y2 As Double, z2 As Double
    Dim d As Double, combs As Double
    
    combs = boxes * (boxes - 1) / 2

    ReDim edges(0 To combs - 1)
    k = 0

    For i = 0 To boxes - 2
        x1 = sh.Cells(i + 2, 3).Value
        y1 = sh.Cells(i + 2, 4).Value
        z1 = sh.Cells(i + 2, 5).Value

        For j = i + 1 To boxes - 1
            x2 = sh.Cells(j + 2, 3).Value
            y2 = sh.Cells(j + 2, 4).Value
            z2 = sh.Cells(j + 2, 5).Value

            d = Sqr((x2 - x1) ^ 2 + (y2 - y1) ^ 2 + (z2 - z1) ^ 2)
            edges(k) = creatEdge(i, j, d)
            k = k + 1
        Next j
    Next i

    BuildEdges = edges
End Function
Sub SolvePart1(sh As Worksheet, edges() As Edge, boxes As Long)
    Dim result() As Edge
    Dim sizes As Variant
    Dim totalCost As Double
    Dim i As Long

    result = execKruskalLimited(boxes, edges, 1000)

    totalCost = 0#
    For i = LBound(result) To UBound(result)
        If result(i).w > 0 Then
            sh.Cells(i + 2, 7) = result(i).u + 1
            sh.Cells(i + 2, 8) = result(i).v + 1
            sh.Cells(i + 2, 9) = result(i).w
            totalCost = totalCost + result(i).w
        End If
    Next i

    sizes = GetComponentSizes(boxes)

    Debug.Print "Part I Result: "; ProductTop3(sizes)
    sh.Cells(2, 10) = totalCost
End Sub

Sub SolvePart2(sh As Worksheet, edges() As Edge, boxes As Long)
    Dim mst() As Edge
    Dim lastEdge As Edge
    Dim x1 As Double, x2 As Double

    mst = execKruskal(boxes, edges)
    lastEdge = mst(UBound(mst))

    x1 = sh.Cells(lastEdge.u + 2, 3).Value
    x2 = sh.Cells(lastEdge.v + 2, 3).Value

    Debug.Print "Part II Result: "; x1 * x2
End Sub

Function FindFactorial(n As Long) As Double

 Dim i As Integer, result As Double
 
 result = 1

 For i = 1 To n
     result = result * i
 Next

 FindFactorial = result

End Function

Function GetComponentSizes(nodesCount As Long) As Variant
    Dim sizes() As Long
    Dim i As Long, c As Long

    ReDim sizes(0 To nodesCount - 1)
    c = 0

    For i = 0 To nodesCount - 1
        If id(i) = i Then
            sizes(c) = sz(i)
            c = c + 1
        End If
    Next i

    ReDim Preserve sizes(0 To c - 1)
    GetComponentSizes = sizes
End Function


Function ProductTop3(sizes As Variant) As Double
    If UBound(sizes) < 2 Then
        Err.Raise vbObjectError + 513, , _
            "3 values are needed. There are " & (UBound(sizes) + 1)
    End If

    Dim i As Long, j As Long, tmp As Long

    For i = LBound(sizes) To UBound(sizes) - 1
        For j = i + 1 To UBound(sizes)
            If sizes(j) > sizes(i) Then
                tmp = sizes(i)
                sizes(i) = sizes(j)
                sizes(j) = tmp
            End If
        Next j
    Next i

    ProductTop3 = sizes(0) * sizes(1) * sizes(2)
End Function

Function NowSeconds() As Double
    NowSeconds = Timer
End Function


