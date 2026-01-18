Attribute VB_Name = "KappaFleiss"
Sub FleissKappaCalc(N_subjects As Integer)
    ' Fleiss' Kappa calculation subroutine
    Dim Rng As Range
    Dim n As Integer, k As Integer
    Dim Pi As Double, Pe As Double, Pbar As Double, PeBar As Double
    Dim SumPi As Double, SumPj As Double
    Dim VarK As Double, SEk As Double, ZScore As Double

    ' Range definition
    ' For this experiment we set 24 subjects on three ordinal categories (CatA, CatB, CatC)
    
    Set Rng = Range("D3:F" & (2 + N_subjects))
'    N_subjects = Rng.Rows.Count ' Subjects
    k = Rng.Columns.Count ' Categories
    n = Application.WorksheetFunction.Sum(Rng.Rows(1)) ' Raters
    
    ' P_i calculation (Actual agreement by row)
    SumPi = 0
    For i = 1 To N_subjects
        RowSumSq = 0
        For j = 1 To k
            RowSumSq = RowSumSq + (Rng.Cells(i, j).Value ^ 2)
        Next j
        SumPi = SumPi + (1 / (n * (n - 1))) * (RowSumSq - n)
    Next i
    Pbar = SumPi / N_subjects
    
    ' P_e calculation (Expected agreement by chance)
    PeBar = 0
    For j = 1 To k
        SumCol = Application.WorksheetFunction.Sum(Rng.Columns(j))
        PeBar = PeBar + (SumCol / (N_subjects * n)) ^ 2
    Next j
    
    ' Final Kappa
    Kappa = (Pbar - PeBar) / (1 - PeBar)
    
    ' Variance
    VarK = 2 / (N_subjects * n * (n - 1))
    SEk = Sqr(VarK)
    
    ' Z-score
    ZScore = Kappa / SEk
    
    ' Write Z-Score
    Range("H9").Value = ZScore
    
    ' Write Kappa
    Range("H3").Value = Kappa
    
    ' Write Variance
    Range("H12").Value = VarK
    
    ' Run Normal Data Distribution subroutine
    NormalDataDistGen
    
End Sub

Sub NormalDataDistGen()
    ' Performs Normal Data Distribution for Gaussian Chart and z-score
    Dim Kappa As Double, SEk As Double, ZScore As Double, h As Double
    Dim N_subjects As Integer, n_raters As Integer
    Dim i As Integer, targetIndex As Integer
    Dim x As Double, xStart As Double
    Dim beginRow As Integer: beginRow = 11
    Dim beginCol As Integer: beginCol = 23 ' Column W
    
    Kappa = Range("H3").Value ' Get Kappa
    N_subjects = 24
    n_raters = Range("H6").Value
    h = 0.1 'step size
    xStart = -4
    ' Get Z-Score
    ZScore = Range("H9").Value
    
    Range("W11:Y100").ClearContents
    ' Data table for gaussian chart x € [-4, 4]
    ' Header
    Range("W10:Y10").Value = Array("X Axis", "Gaussian F", "Z position")
    
    ' If Z score is too large
    Dim ZVisual As Double
    If ZScore > 3.3 Then
        ZVisual = 3.5 ' Right border
    ElseIf ZScore < -2# Then
        ZVisual = -2.2   ' Left border
    Else
        ZVisual = ZScore
    End If
    
    
    targetIndex = Round((ZVisual - xStart) / h, 0)
    
    ' data table
    x = xStart
    For i = 0 To 80
        Cells(beginRow + i, beginCol).Value = x
        Cells(beginRow + i, beginCol + 1).FormulaR1C1 = "=NORM.DIST(RC[-1], 0, 1, FALSE)"
'        If Abs(x - ZVisual) < 0.06 Then 'Confidence at 95% or p-value < 0.05
        If i = targetIndex Then
            Cells(beginRow + i, beginCol + 2).Value = Cells(beginRow + i, beginCol + 1).Value
        Else
            Cells(beginRow + i, beginCol + 2).Value = 0
        End If
        x = x + h
    Next i
End Sub
