Attribute VB_Name = "KruskalMod"
Public Type Edge
    u As Integer      ' root node
    v As Integer      ' destination node
    w As Double       ' weight
End Type

Function execKruskal(nodesCount As Integer, ByRef edgesList() As Edge) As Edge()
    Dim mst() As Edge
    Dim mstIndex As Long
    Dim i As Long
    
    ' 1. Union-Find initializaton
    initUnionFind nodesCount
    
    ' 2. order list by weight (bubble sort)
    sortEdges edgesList
    
    ReDim mst(0 To nodesCount - 2) ' Un MST siempre tiene N-1 aristas
    mstIndex = 0
    
    ' 3. Union-Find Algorithm as Kruskal's engine
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

Sub sortEdges(ByRef arr() As Edge)
    Dim i As Long, j As Long
    Dim temp As Edge
    ' Bubble Sort simple for now
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

' Aux fuction to create Edges quickly
Function creatEdge(u As Long, v As Long, w As Double) As Edge
    creatEdge.u = u
    creatEdge.v = v
    creatEdge.w = w
End Function
