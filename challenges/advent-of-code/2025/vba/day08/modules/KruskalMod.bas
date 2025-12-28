Attribute VB_Name = "KruskalMod"
Public Type Edge
    u As Integer      ' root node
    v As Integer      ' destination node
    w As Double       ' weight
End Type

Function execKruskal(nodesCount As Long, ByRef edgesList() As Edge) As Edge()
    Dim mst() As Edge
    Dim mstIndex As Long
    Dim i As Long
    
    ' 1. Union-Find initializaton
    initUnionFind nodesCount
    
    ' 2. order list by weight (Quick sort)
    QuickSortEdges edgesList, LBound(edgesList), UBound(edgesList)
    
    ReDim mst(0 To nodesCount - 2) ' A MST has n-1 edges
    mstIndex = 0
    
    ' 3. Union-Find structure as a Kruskal's algorithm engine
    For i = LBound(edgesList) To UBound(edgesList)
        If Not connected(edgesList(i).u, edgesList(i).v) Then
            union edgesList(i).u, edgesList(i).v
            mst(mstIndex) = edgesList(i)
            mstIndex = mstIndex + 1
            If mstIndex = nodesCount - 1 Then Exit For
        End If
    Next i
    
    execKruskal = mst
End Function

Sub BubbleSortEdges(ByRef arr() As Edge)
    ' Recommended for n < 50 edges, otherwise use quick sort
    Dim i As Long, j As Long
    Dim temp As Edge

    For i = LBound(arr) To UBound(arr) - 1
        For j = i + 1 To UBound(arr)
            If arr(i).w > arr(j).w Then
                temp = arr(i)
                arr(i) = arr(j)
                arr(j) = temp
            End If
        Next j
    Next i
End Sub
Sub QuickSortEdges(ByRef arr() As Edge, ByVal first As Long, ByVal last As Long)
    Dim i As Long, j As Long
    Dim pivot As Double
    Dim tmp As Edge
    
    i = first
    j = last
    
    ' Select central element based on its weight (w) as a pivot
    pivot = arr((first + last) \ 2).w
    
    Do While i <= j
        ' Looks for elements that must change of place respect to pivote
        Do While arr(i).w < pivot: i = i + 1: Loop
        Do While arr(j).w > pivot: j = j - 1: Loop
        
        If i <= j Then
            tmp = arr(i)
            arr(i) = arr(j)
            arr(j) = tmp
            i = i + 1
            j = j - 1
        End If
    Loop
    
    ' Recursivity for the rest of halves
    ' Note for me: "recursivity should be studied more in depth by me"
    If first < j Then QuickSortEdges arr, first, j
    If i < last Then QuickSortEdges arr, i, last
End Sub

Sub KruskalExample()
    Dim myEdges(0 To 6) As Edge
    Dim result() As Edge
    Dim i As Long
    Dim costoTotal As Double
    
    ' Conextions (Origin, Destination, Weight)
    myEdges(0) = creatEdge(1, 2, 4)
    myEdges(1) = creatEdge(1, 3, 7)
    myEdges(2) = creatEdge(2, 3, 2)
    myEdges(3) = creatEdge(2, 4, 6)
    myEdges(4) = creatEdge(3, 4, 3)
    myEdges(5) = creatEdge(3, 5, 5)
    myEdges(6) = creatEdge(4, 5, 4)

    'nodes count >= Ubound(myEdges)
    result = execKruskal(UBound(myEdges), myEdges)
    
    Debug.Print "=== KRUSKAL ALGORITHM RESULTS ==="
    For i = LBound(result) To UBound(result)
        If result(i).w > 0 Then
            Debug.Print "Node " & result(i).u & " <---> Node " & result(i).v & " | Weight: " & result(i).w
            totalCost = totalCost + result(i).w
        End If
    Next i
    
    Debug.Print "-------------------------------------------"
    Debug.Print "MST Total Cost: " & totalCost
    Debug.Print "Are they all connected?: " & IIf(numComponents = 1, "YES", "NO")
End Sub
Function execKruskalLimited(nodesCount As Long, _
                            ByRef edgesList() As Edge, _
                            maxPairs As Long) As Edge()

    Dim usedEdges() As Edge
    Dim pairCount As Long
    Dim i As Long

    initUnionFind nodesCount
    QuickSortEdges edgesList, LBound(edgesList), UBound(edgesList)

    ReDim usedEdges(0 To maxPairs - 1)
    pairCount = 0

    For i = LBound(edgesList) To UBound(edgesList)
        If pairCount = maxPairs Then Exit For

        usedEdges(pairCount) = edgesList(i)
        pairCount = pairCount + 1

        If Not connected(edgesList(i).u, edgesList(i).v) Then
            union edgesList(i).u, edgesList(i).v
        End If
    Next i

    execKruskalLimited = usedEdges
End Function
' Aux fuction to create Edges quickly
Function creatEdge(u As Long, v As Long, w As Double) As Edge
    creatEdge.u = u
    creatEdge.v = v
    creatEdge.w = w
End Function


