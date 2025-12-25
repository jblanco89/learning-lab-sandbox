Attribute VB_Name = "ExportCSVDay8Mod"
Sub ExportNodesCSV(sh As Worksheet, boxes As Long, path As String)
    Dim f As Integer, i As Long

    f = FreeFile
    Open path & "\nodes.csv" For Output As #f
    Print #f, "id,x,y,z"

    For i = 0 To boxes - 1
        Print #f, i & "," & _
                  sh.Cells(i + 2, 3).Value & "," & _
                  sh.Cells(i + 2, 4).Value & "," & _
                  sh.Cells(i + 2, 5).Value
    Next i

    Close #f
End Sub

Sub ExportEdgesCSV(edges() As Edge, path As String)
    Dim f As Integer, i As Long

    f = FreeFile
    Open path & "\edges.csv" For Output As #f
    Print #f, "step,u,v"

    For i = LBound(edges) To UBound(edges)
        If edges(i).w > 0 Then
            Print #f, i & "," & edges(i).u & "," & edges(i).v
        End If
    Next i

    Close #f
End Sub


