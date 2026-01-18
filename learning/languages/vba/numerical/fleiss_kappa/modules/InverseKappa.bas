Attribute VB_Name = "InverseKappa"
Sub main()
    ' tests function given a kappa value
    Dim numSubjects As Integer: numSubjects = 24
    RatersByKappa 0.3, 3, 3, numSubjects
    FleissKappaCalc numSubjects
End Sub

Sub RatersByKappa(KappaTarget As Double, TotalRaters As Integer, NumCategories As Integer, numSubjects As Integer)
    
    Dim i As Integer, j As Integer
    Dim RngData As Range
    Dim KappaAdjusted As Double
    Dim finalCat As Integer, chanceCat As Integer
    Dim assignedRaters As Integer, agreedRaters As Integer
    
'    Set RngData = Range("D3:F26") ' data Matrix
    Set RngData = Range("D3:F" & (2 + numSubjects)) ' data Matrix
'    numSubjects = RngData.Rows.Count - 1 ' header discarded
    
    Range("D3:F26").Value = 0 ' Assign 0's
    Randomize 'set seed equivalent
    
    KappaAdjusted = KappaTarget + (1 - KappaTarget) * (1 / NumCategories)

    For i = 1 To numSubjects
        assignedRaters = 0
        agreedRaters = Round(TotalRaters * KappaAdjusted)
        If agreedRaters > TotalRaters Then agreedRaters = TotalRaters
        
        finalCat = Int((NumCategories * Rnd) + 1)
        RngData.Cells(i, finalCat).Value = agreedRaters
        assignedRaters = agreedRaters
        
        While assignedRaters < TotalRaters
            chanceCat = Int((NumCategories * Rnd) + 1)
            RngData.Cells(i, chanceCat).Value = RngData.Cells(i, chanceCat).Value + 1
            assignedRaters = assignedRaters + 1
        Wend
    Next i
End Sub
