Attribute VB_Name = "UnionFindModule"
' Global variables declaration
Public id() As Integer
Public sz() As Integer
Public numComponents As Integer


Sub initUnionFind(n As Long)
' Initializes total components is going to be processed by UnionFind subroutine
    Dim i As Integer

    numComponents = n
    ReDim sz(0 To n - 1) As Integer
    ReDim id(0 To n - 1) As Integer
    
    For i = 0 To n - 1
        id(i) = i
        sz(i) = 1
    Next i
    
End Sub

Function find(p As Integer) As Integer
' Returns the root of the tree containing p
' Simply assign the pointer associated with p to be find(p) at the end of the find operation.

' Helpful source:
' https://activities.tjhsst.edu/sct/lectures/1516/SCT_DSU.pdf
' https://github.com/williamfiset/Algorithms/blob/master/src/main/java/com/williamfiset/algorithms/datastructures/unionfind/UnionFind.java
    Dim root As Integer
    Dim current As Integer
    Dim nxt As Integer
    
    ' Verificación de seguridad
    If p < LBound(id) Or p > UBound(id) Then
        Debug.Print "ERROR en find(): p=" & p & " fuera de rango"
        find = p
        Exit Function
    End If
    
    root = p
    
    ' Find root (sin modificar nada todavía)
    Do While root <> id(root)
        root = id(root)
    Loop
    
    ' Path compression (usando variable temporal)
    current = p
    Do While current <> root
        nxt = id(current)
        id(current) = root
        current = nxt
    Loop
    
    find = root
End Function

Function connected(p As Integer, q As Integer) As Boolean
' Check if two component tree are connected. If it so, union-find subroutine exit
    connected = (find(p) = find(q))
End Function




