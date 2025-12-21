Attribute VB_Name = "AnimationDay7Test"
' =========================
'     SCREENSHOT TEST
' =========================
Sub screenShotTest()
    Dim sh As Worksheet
    Dim testPath As String
    Dim rng As Range
    Dim cht As ChartObject
    Dim rangoStr As String
    
    Set sh = Sheets("Adv2025_7")
    
    If ThisWorkbook.Path = "" Then
        MsgBox "IMPORTANT: Firtly save the Excel Workbook" & vbCrLf & vbCrLf, vbExclamation
        Exit Sub
    End If
    
    testPath = ThisWorkbook.Path & "\frame_test.png"
    rangeStr = getRangeGrid(sh)
    
    MsgBox "Range will get captured: " & rangeStr & vbCrLf & vbCrLf & _
           "File: " & testPath, vbInformation
    
    ' Try
    On Error GoTo ErrorHandler
    
    Set rng = sh.Range(rangeStr)
    
    rng.CopyPicture Appearance:=xlScreen, Format:=xlBitmap
    
    Set cht = sh.ChartObjects.Add(0, 0, rng.Width, rng.Height)
    
    cht.Activate
    ActiveChart.Paste
    cht.Chart.Export Filename:=testPath, FilterName:="PNG"
    cht.Delete
    
    If Dir(testPath) <> "" Then
        MsgBox "? SUCCESS: test frame created" & vbCrLf & vbCrLf & _
               testPath & vbCrLf & vbCrLf & _
               "Check if whole canva is seen", vbInformation
        
        ' Open the img
        CreateObject("WScript.Shell").Run """" & testPath & """"
    Else
        MsgBox "? ERROR: test frame was not created.", vbCritical
    End If
    
    Exit Sub
    
ErrorHandler:
    MsgBox "Error Test: " & Err.Description, vbCritical
    On Error Resume Next
    If Not cht Is Nothing Then cht.Delete
End Sub



