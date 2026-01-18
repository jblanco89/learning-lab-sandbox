Attribute VB_Name = "Animation"

' Important for sleep command
#If VBA7 Then
    Public Declare PtrSafe Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As LongPtr)
#Else
    Public Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
#End If

Sub Animation()
    Dim targetKappa As Double, calcKappa As Double
    Dim currentStep As Integer
    Dim totalSteps As Integer
    Dim Sh As Shape
    Dim numRaters As Integer
    Dim numSubjects As Integer
    
    ' Animation config
    totalSteps = 75
    ' Screen smooth sensation
    Application.ScreenUpdating = True
    Application.Calculation = xlCalculationManual
    
    For currentStep = 1 To totalSteps
        ' Smooth progression from 0.3 to 0.90
        targetKappa = 0.3 + (0.6 * (currentStep / totalSteps))
        
        ' raters: 3 to 10
        numRaters = 3 + Int(7 * (currentStep / totalSteps))
        
        ' subjects: 8 to 24 (playing with z-score and statistic significance
        numSubjects = 8 + Int(16 * (currentStep / totalSteps))
        
        Range("H6").Value = numRaters
        
        RatersByKappa targetKappa, numRaters, 3, numSubjects
        
        FleissKappaCalc numSubjects
        calcKappa = Range("H3").Value
        
        ActiveSheet.Calculate
        Application.Calculate
        
        ' Refresh all charts
        For Each Sh In ActiveSheet.Shapes
            If Sh.Type = msoChart Then
                Sh.Chart.Refresh
                Sh.Chart.ChartArea.Select
                ActiveChart.Refresh
            End If
        Next Sh
        
        Range("G2").Select
        ' Current information
        Range("A1").Value = "Step: " & currentStep & "/" & totalSteps & _
                           " | Kappa: " & Format(calcKappa, "0.000") & _
                           " | Raters: " & numRaters & _
                           " | Subjects: " & numSubjects & _
                           " | Z-score: " & Format(Range("H9").Value, "0.00")
        
        DoEvents
        Application.ScreenUpdating = True
        DoEvents
        
        Sleep 150
        
    Next currentStep
    
    Application.Calculation = xlCalculationAutomatic
    Application.ScreenUpdating = True
    Range("G2").Select
End Sub
