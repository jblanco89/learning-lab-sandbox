Attribute VB_Name = "AnimationDay7"
Option Explicit

'creatGrid - set the grid from Column A
'tachyonAnimation - create the animation and export frames in png
'exportGIF_HTML - create animation GIF in HTML
'exportGIF - Try to create GIF with PowerPoint
'checkFrames - how many frames were generated
'cleanPreviousFrames - erase previous frames


' =========================
'        CONFIG
' =========================
Const GRID_START_COL As Long = 6          ' F Column
Const GRID_RANGE As String = "F1:BZ150"   ' Canva Area
Const FRAME_DELAY As Double = 0.08        ' Gif frame duration (minimized for frames smoothing)
Private Const ppSaveAsGIF As Long = 16    ' VB Library Object code for "Save As Gif" value

' ==============================================
'   SHAPE VALUE ASSIGNATION (RECTANGULE SHAPE)
' ==============================================
Sub linkCellToShape()
   Dim shp1 As Shape
   Set shp1 = ThisWorkbook.Worksheets("Adv2025_7").Shapes("rctng1")
   shp.DrawingObject.Formula = "=E2"
End Sub

' ============================
'   AUTOMATE RANGE DETECTION
' ============================
Function getRangeGrid(sh As Worksheet) As String
    Dim lastRow As Long
    Dim lastCol As Long
    Dim startCol As Long
    
    startCol = GRID_START_COL ' F Column
    
    ' Last Row
    lastRow = sh.Cells(sh.Rows.Count, 1).End(xlUp).row
    If lastRow < 1 Then lastRow = 150
    
    ' Last Column
    lastCol = sh.Cells(1, sh.Columns.Count).End(xlToLeft).Column
    
    If lastCol < startCol Then lastCol = startCol + 100
    
    ' 20 columns more
    lastCol = lastCol + 20
    
    getRangeGrid = sh.Range(sh.Cells(1, startCol), sh.Cells(lastRow, lastCol)).Address
    
    Debug.Print "Detected Range: " & getRangeGrid & " (Rows: " & lastRow & ", Cols: " & lastCol - startCol + 1 & ")"
End Function

' =========================
' GRID CREATION
' =========================
Sub creatGrid()
    Dim sh As Worksheet
    Dim lastRow As Long
    Dim i As Long, j As Long
    Dim line As String
    Dim maxLen As Long
    
    Set sh = Sheets("Adv2025_7")
    lastRow = sh.Cells(sh.Rows.Count, 1).End(xlUp).row
    
    sh.Range("F1:ZZ200").Clear
    
    sh.Columns("F:ZZ").ColumnWidth = 2.2
    sh.Rows("1:200").RowHeight = 15
    
    maxLen = 0
    For i = 1 To lastRow
        line = Trim(sh.Cells(i, 1).Value)
        If Len(line) > maxLen Then maxLen = Len(line)
        For j = 1 To Len(line)
            sh.Cells(i, j + GRID_START_COL - 1).Value = Mid(line, j, 1)
        Next j
    Next i
    
    MsgBox "Grid successfuly created." & vbCrLf & _
           "Rows: " & lastRow & vbCrLf & _
           "Max Width: " & maxLen & " caracteres" & vbCrLf & vbCrLf & _
           "Work Range: " & getRangeGrid(sh), vbInformation
End Sub

' ===============================
'    CLEANS PREVIOUS FRAMES
' ===============================

Sub cleanPreviousFrames()
    Dim i As Long
    Dim imgPath As String
    
    On Error Resume Next
    For i = 1 To 500
        imgPath = ThisWorkbook.Path & "\frame_" & Format(i, "000") & ".png"
        If Dir(imgPath) <> "" Then
            Kill imgPath
        Else
            Exit For
        End If
    Next i
    On Error GoTo 0
    
    Debug.Print "Previous frames erased"
End Sub

' =========================
'       TACHYON ANIMATION
' =========================
Sub tachyonsAnimation()
    Dim sh As Worksheet
    Dim lastRow As Long
    Dim i As Long
    Dim paths As Object, nextPaths As Object
    Dim key As Variant
    Dim currentCount As LongLong
    Dim cellValue As String
    Dim splits As LongLong
    Dim frameNum As Long
    
    Set sh = Sheets("Adv2025_7")
    lastRow = sh.Cells(sh.Rows.Count, 1).End(xlUp).row
'    If lastRow < 2 Then
'        MsgBox "Error: No hay datos en la columna A. Ejecuta PrepararGrilla primero.", vbCritical
'        Exit Sub
'    End If
    
    cleanPreviousFrames
    
    Set paths = CreateObject("Scripting.Dictionary")
    
    Application.ScreenUpdating = False
    Application.EnableEvents = False
    Application.Calculation = xlCalculationManual
    
'    InicializarPanel
    splits = 0
    frameNum = 1
    
    ' Buscar S (inicio)
    Dim colStart As Long
    colStart = 0
    For i = GRID_START_COL To sh.Cells(1, sh.Columns.Count).End(xlToLeft).Column
        If sh.Cells(1, i).Value = "S" Then
            colStart = i
            paths(colStart) = 1
            Exit For
        End If
    Next i
    
    If colStart = 0 Then
        Application.ScreenUpdating = True
        Application.EnableEvents = True
        Application.Calculation = xlCalculationAutomatic
        MsgBox "Error: 'S' initial point was not found in row 1.", vbCritical
        Exit Sub
    End If
    
    Debug.Print "Animation Initialization: " & colStart & ", Rows: " & lastRow
    
    getFrame sh, frameNum
    Debug.Print "Frame " & frameNum & " capturado"
    frameNum = frameNum + 1
    
    ' Animación fila por fila
    For i = 2 To lastRow
        Set nextPaths = CreateObject("Scripting.Dictionary")
        
        For Each key In paths.Keys
            cellValue = sh.Cells(i, key).Value
            
            Select Case cellValue
                Case "^"
                    splits = splits + 1
                    sh.Range("E2").Value = splits
                    
                    currentCount = paths(key)
                    
                    ' Split izquierda
                    cumulativePath nextPaths, key - 1, currentCount
                    If i > 1 Then drawBeam sh.Cells(i, key - 1), True
                    
                    ' Split derecha
                    cumulativePath nextPaths, key + 1, currentCount
                    If i > 1 Then drawBeam sh.Cells(i, key + 1), True
                
                Case "."
                    cumulativePath nextPaths, key, paths(key)
                    drawBeam sh.Cells(i, key), False
            End Select
        Next key
        
        Set paths = nextPaths
        
        ' Capturar frame
        getFrame sh, frameNum
        Debug.Print "Frame " & frameNum & " screened (fila " & i & ")"
        frameNum = frameNum + 1
        
        DoEvents
    Next i
    
    Application.ScreenUpdating = True
    Application.EnableEvents = True
    Application.Calculation = xlCalculationAutomatic
    
    MsgBox "Animation Finished" & vbCrLf & _
           "Frames screened: " & (frameNum - 1) & vbCrLf & _
           "Total splits: " & splits, vbInformation
End Sub

' =========================
'        UTILS
' =========================
Sub cumulativePath(dic As Object, ByVal pos As Long, ByVal amount As LongLong)
    If dic.Exists(pos) Then
        dic(pos) = dic(pos) + amount
    Else
        dic(pos) = amount
    End If
End Sub

Sub drawBeam(c As Range, esSplit As Boolean)
    With c
        .Value = "|"
        If esSplit Then
            .Interior.Color = RGB(255, 160, 0) ' Orange
        Else
            .Interior.Color = RGB(0, 200, 255) ' Blue
        End If
    End With
End Sub

' =========================
'     GET FRAMES (IMG)
' =========================
Sub getFrame(sh As Worksheet, frameNum As Long)
    Dim rng As Range
    Dim imgPath As String
    Dim cht As ChartObject
    Dim rangeStr As String
    
    ' Dynamic range
    rangeStr = getRangeGrid(sh)
    Set rng = sh.Range(rangeStr)
    
    imgPath = ThisWorkbook.Path & "\frame_" & Format(frameNum, "000") & ".png"
    
    ' Dir validation
    If ThisWorkbook.Path = "" Then
        Debug.Print "ERROR: Workbook was not found. Save file first."
        Exit Sub
    End If
    
    ' Forzar actualización de pantalla
    Application.ScreenUpdating = True
    DoEvents
    DoEvents
    
    On Error GoTo ErrorHandler
    
    ' Step 1: Copy range as image
    rng.CopyPicture Appearance:=xlScreen, Format:=xlBitmap
    
    ' Step 2: ChartObject temp chart to image pasting
    Set cht = sh.ChartObjects.Add(0, 0, rng.Width, rng.Height)
    cht.Activate
    
    ' Step 3: Image paste in chart
    ActiveChart.Paste
    
    ' Step 4: Export chart as PNG
    cht.Chart.Export Filename:=imgPath, FilterName:="PNG"
    
    ' Step 5: Delete temporal chart
    cht.Delete
    
    Application.ScreenUpdating = False
    
    ' Verifying if it is saved
    If Dir(imgPath) <> "" Then
        If frameNum = 1 Then Debug.Print "? Screening frames with range: " & rangeStr
        If frameNum Mod 10 = 0 Then Debug.Print "? Frame " & frameNum & " saved"
    Else
        Debug.Print "? ERROR: Frame " & frameNum & " was not saved"
    End If
    
    Exit Sub
    
ErrorHandler:
    Debug.Print "Error screening frame " & frameNum & ": " & Err.Description
    Debug.Print "Dir: " & imgPath
    On Error Resume Next
    If Not cht Is Nothing Then cht.Delete
    Application.ScreenUpdating = False
End Sub


'' ===========================
''    EXPORT GIF WITH PPT
'' ===========================

Sub exportGif()
    Dim ppt As Object
    Dim pres As Object
    Dim slide As Object
    Dim i As Long
    Dim imgPath As String
    Dim gifPath As String
    Dim pptxPath As String
    Dim frameCount As Long

    gifPath = ThisWorkbook.Path & "\tachyons.gif"
    pptxPath = ThisWorkbook.Path & "\tachyons_temp.pptx"

    ' Count frames
    frameCount = 0
    For i = 1 To 500
        imgPath = ThisWorkbook.Path & "\frame_" & Format(i, "000") & ".png"
        If Dir(imgPath) <> "" Then
            frameCount = frameCount + 1
        Else
            Exit For
        End If
    Next i

    If frameCount = 0 Then
        MsgBox "Frames not found." & vbCrLf & vbCrLf & _
               "Dir found: " & ThisWorkbook.Path & vbCrLf & vbCrLf & _
               "Run tachyonAnimation first", vbExclamation
        Exit Sub
    End If

    Debug.Print "Frames found: " & frameCount

    On Error GoTo ErrorHandler

    Set ppt = CreateObject("PowerPoint.Application")
    ppt.Visible = True
    Set pres = ppt.Presentations.Add

    With pres.SlideShowSettings
        .LoopUntilStopped = True
    End With

    For i = 1 To frameCount
        imgPath = ThisWorkbook.Path & "\frame_" & Format(i, "000") & ".png"

        Set slide = pres.Slides.Add(i, 12) ' Blank layout
        
        With slide.Shapes.AddPicture(imgPath, False, True, 0, 0, pres.PageSetup.SlideWidth, pres.PageSetup.SlideHeight)
            .LockAspectRatio = False
        End With

        With slide.SlideShowTransition
            .AdvanceOnTime = True
            .AdvanceTime = FRAME_DELAY
            .Speed = 1 ' Fast
            .EntryEffect = 0 ' No effect
        End With

        Debug.Print "Slide " & i & " agregado"
    Next i

    pres.SaveAs pptxPath
    Debug.Print "Slides saved: " & pptxPath

    On Error Resume Next
        Kill gifPath
    On Error GoTo ErrorHandler

    pres.SaveAs gifPath, ppSaveAsGIF

    If Dir(gifPath) <> "" Then
        Debug.Print "? GIF exported: " & gifPath
        MsgBox "GIF successfuly done:" & vbCrLf & gifPath & vbCrLf & vbCrLf & _
               "Frames: " & frameCount & vbCrLf & vbCrLf & _
               "NOTE: If GIF is not animated, use ExportGIF_HTML", vbInformation
    Else
        Debug.Print "? GIF not created"
        MsgBox "PowerPoint could not be able to create GIF" & vbCrLf & vbCrLf & _
               "Use ExportGIF_HTML.", vbExclamation
    End If

    MsgBox "Check PowerPoint slides." & vbCrLf & _
           "Close PowerPoint", vbInformation

    Exit Sub

ErrorHandler:
    MsgBox "Error: " & Err.Description & vbCrLf & vbCrLf & _
           "Try ExportGIF_HTML", vbCritical
    On Error Resume Next
    If Not pres Is Nothing Then pres.Close
    If Not ppt Is Nothing Then ppt.Quit
End Sub

' =========================
'    EXPORT GIF AS HTML
' =========================
Sub exportGIF_HTML()
    Dim i As Long
    Dim frameCount As Long
    Dim imgPath As String
    Dim htmlPath As String
    Dim htmlContent As String
    Dim fso As Object
    Dim fileStream As Object
    
    htmlPath = ThisWorkbook.Path & "\tachyons_animation.html"
    
    ' Contar frames
    frameCount = 0
    For i = 1 To 500
        imgPath = ThisWorkbook.Path & "\frame_" & Format(i, "000") & ".png"
        If Dir(imgPath) <> "" Then
            frameCount = frameCount + 1
        Else
            Exit For
        End If
    Next i
    
    If frameCount = 0 Then
        MsgBox "Frames was not found", vbExclamation
        Exit Sub
    End If
    
    ' HTML and JS animation
    htmlContent = "<!DOCTYPE html>" & vbCrLf
    htmlContent = htmlContent & "<html><head><meta charset='utf-8'>" & vbCrLf
    htmlContent = htmlContent & "<title>Tachyons Animation</title>" & vbCrLf
    htmlContent = htmlContent & "<style>" & vbCrLf
    htmlContent = htmlContent & "body { margin: 0; background: #000; display: flex; justify-content: center; align-items: center; height: 100vh; }" & vbCrLf
    htmlContent = htmlContent & "img { max-width: 90%; max-height: 90vh; image-rendering: smooth; }" & vbCrLf
    htmlContent = htmlContent & "</style></head><body>" & vbCrLf
    htmlContent = htmlContent & "<img id='frame' src='frame_001.png'>" & vbCrLf
    htmlContent = htmlContent & "<script>" & vbCrLf
    htmlContent = htmlContent & "const frames = [" & vbCrLf
    
    For i = 1 To frameCount
        htmlContent = htmlContent & "  'frame_" & Format(i, "000") & ".png'"
        If i < frameCount Then htmlContent = htmlContent & ","
        htmlContent = htmlContent & vbCrLf
    Next i
    
    htmlContent = htmlContent & "];" & vbCrLf
    htmlContent = htmlContent & "let currentFrame = 0;" & vbCrLf
    htmlContent = htmlContent & "const img = document.getElementById('frame');" & vbCrLf
    htmlContent = htmlContent & "setInterval(() => {" & vbCrLf
    htmlContent = htmlContent & "  currentFrame = (currentFrame + 1) % frames.length;" & vbCrLf
    htmlContent = htmlContent & "  img.src = frames[currentFrame];" & vbCrLf
    htmlContent = htmlContent & "}, " & CStr(FRAME_DELAY * 1500) & ");" & vbCrLf
    htmlContent = htmlContent & "</script></body></html>" & vbCrLf
    
    ' Save HTML
    Set fso = CreateObject("Scripting.FileSystemObject")
    Set fileStream = fso.CreateTextFile(htmlPath, True)
    fileStream.Write htmlContent
    fileStream.Close
    
    MsgBox "HTML succesfuly done:" & vbCrLf & htmlPath & vbCrLf & vbCrLf & _
           "Open this file in the browser." & vbCrLf & vbCrLf & _
           "You can also use online tools like:" & vbCrLf & _
           "• ezgif.com/video-to-gif" & vbCrLf & _
           "• gifmaker.me", vbInformation
    
    ' Abrir en navegador
    CreateObject("WScript.Shell").Run """" & htmlPath & """"
End Sub

' =========================
'   CHECK FRAMES
' =========================
Sub checkFrames()
    Dim i As Long
    Dim imgPath As String
    Dim frameCount As Long
    
    frameCount = 0
    For i = 1 To 500
        imgPath = ThisWorkbook.Path & "\frame_" & Format(i, "000") & ".png"
        If Dir(imgPath) <> "" Then
            frameCount = frameCount + 1
            Debug.Print "Frame " & i & " found: " & imgPath
        Else
            Exit For
        End If
    Next i
    
    If frameCount > 0 Then
        MsgBox "Frames found: " & frameCount & vbCrLf & vbCrLf & _
               "Path: " & ThisWorkbook.Path, vbInformation
    Else
        MsgBox "Frames was not found in:" & vbCrLf & ThisWorkbook.Path, vbExclamation
    End If
End Sub

