VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Sheet4"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
' ====================================================================
' FUNCIÓN AUXILIAR: SUMARCADENAS
' Suma dos números representados como cadenas (String) para manejar
' valores que exceden la capacidad de las variables numéricas estándar de VBA.
' Simula la suma manual con acarreo.
' ====================================================================
Function SumarCadenas(ByVal Num1 As String, ByVal Num2 As String) As String
    Dim len1 As Integer, len2 As Integer
    Dim result As String
    Dim carry As Integer ' El acarreo (carry)
    Dim digitSum As Integer
    Dim d1 As Integer, d2 As Integer
    Dim i As Integer

    ' 1. Asegurar que Num1 sea la cadena más larga
    If Len(Num2) > Len(Num1) Then
        Dim temp As String
        temp = Num1
        Num1 = Num2
        Num2 = temp
    End If

    len1 = Len(Num1)
    len2 = Len(Num2)
    result = ""
    carry = 0 ' Inicializar el acarreo

    ' 2. Iterar sobre la longitud del número más largo (de derecha a izquierda)
    For i = 1 To len1
        ' Obtener el dígito d1 del primer número
        d1 = CInt(Mid(Num1, len1 - i + 1, 1))
        
        ' Obtener el dígito d2 del segundo número (o 0 si ya terminó)
        If i <= len2 Then
            d2 = CInt(Mid(Num2, len2 - i + 1, 1))
        Else
            d2 = 0
        End If

        ' 3. Calcular la suma, incluyendo el acarreo
        digitSum = d1 + d2 + carry

        ' 4. Calcular el nuevo acarreo y el dígito resultante
        carry = Int(digitSum / 10)         ' Nuevo acarreo
        result = CStr(digitSum Mod 10) & result ' Dígito resultante se agrega al inicio
    Next i

    ' 5. Si queda un acarreo final, agregarlo
    If carry > 0 Then
        result = CStr(carry) & result
    End If

    SumarCadenas = result
End Function


' ====================================================================
' Implementa el algoritmo Greedy para seleccionar la cadena de 12 dígitos
' que produce el máximo valor, manteniendo el orden relativo.
' ====================================================================
Sub advCode20253b()
    
    Const DIGITS_REQUIRED As Integer = 12 ' El requerimiento del problema
    
    Dim wb As Workbook
    Dim sh As Worksheet
    Dim rng As Range
    Dim banks As Variant        ' Array que contiene las cadenas de los bancos (Columna A)
    Dim bn As String            ' Cadena de dígitos del banco actual
    Dim maxRow As Long
    
    Dim sumMaxJoltageTotal As String ' Suma final como String (para números largos)
    
    Dim bankIndex As Long
    Dim lenBank As Integer
    Dim outputString As String
    
    ' Variables del Algoritmo Greedy
    Dim i As Integer
    Dim startSearch As Integer
    Dim endSearch As Integer
    Dim outputDigitIndex As Integer
    Dim maxDigit As Integer
    Dim maxPos As Integer
    Dim currentDigit As Integer
    
    ' ??? Inicialización y Carga de Datos
    Set wb = ThisWorkbook
    Set sh = wb.Worksheets("Adv2025_3") ' Asegúrate que el nombre de la hoja sea correcto
    
    maxRow = sh.UsedRange.Rows.Count
    Set rng = sh.Range("A1:A" & maxRow)
    banks = rng.Value
    
    sumMaxJoltageTotal = "0" ' Inicializar la suma con el String "0"
    
    ' Greedy
    For bankIndex = LBound(banks, 1) To UBound(banks, 1)
        bn = CStr(banks(bankIndex, 1))
        lenBank = Len(bn)
        
        ' Validación de datos de entrada
        If lenBank < DIGITS_REQUIRED Or Not IsNumeric(bn) Then
            sh.Cells(bankIndex, 2).Value = "ERROR: Datos inválidos."
            GoTo NextBank
        End If
        
        outputString = ""
        startSearch = 1
        
        ' Bucle Greedy: Construye la cadena de 12 dígitos
        For outputDigitIndex = 1 To DIGITS_REQUIRED
            ' Calculamos el límite derecho de la búsqueda (endSearch)
            ' para asegurar que siempre queden suficientes dígitos para completar los 12.
            endSearch = lenBank - (DIGITS_REQUIRED - outputDigitIndex)
            
            maxDigit = -1
            maxPos = -1
            
            ' Búsqueda del mejor dígito para la posición actual
            For i = startSearch To endSearch
                currentDigit = CInt(Mid(bn, i, 1)) ' Convertir el carácter a número
                
                If currentDigit > maxDigit Then
                    maxDigit = currentDigit
                    maxPos = i
                End If
                
                ' Optimización: Si encontramos un 9, es el mejor posible, salimos.
                If maxDigit = 9 Then Exit For
            Next i
            
            outputString = outputString & CStr(maxDigit)
            startSearch = maxPos + 1 ' El inicio de la próxima búsqueda es después del dígito seleccionado
        Next outputDigitIndex
        
        ' --- Almacenamiento y Acumulación de Resultados ---
        
        ' Guarda el joltage máximo (cadena) en la Columna B
        sh.Cells(bankIndex, 3).Value = "'" & outputString ' El apóstrofo fuerza a Excel a tratarlo como texto
        
        ' Llamada a la función SumarCadenas para acumular el total
        sumMaxJoltageTotal = SumarCadenas(sumMaxJoltageTotal, outputString)
        
NextBank:
    Next bankIndex
    
    ' ?? Mostrar el Resultado Final
    sh.Cells(1, 5).Value = "Max Joltage Part II (Total Sum)"
    sh.Cells(2, 5).Value = "'" & sumMaxJoltageTotal ' El resultado final, como String largo (Texto)
End Sub

Sub advCode20253a()
    Dim wb As Workbook
    Dim sh As Worksheet
    Dim rng As Range
    Dim banks As Variant
    Dim bn As Variant
    Dim maxRow As Long
    Dim maxJoltageTotal As Long
    Dim sumMaxJoltageTotal As Long
    Dim currentJoltage As Long
    Dim bankIndex As Long
    Dim i As Integer, j As Integer
    Dim digitA As Integer, digitB As Integer
    Dim lenBank As Integer

    Set wb = ThisWorkbook
    Set sh = wb.Worksheets("Adv2025_3")
    
    maxRow = sh.UsedRange.Rows.Count
    Set rng = sh.Range("A2:A" & maxRow)
    banks = rng.Value
    sumMaxJoltageTotal = 0

    For bankIndex = LBound(banks, 1) To UBound(banks, 1)
        bn = banks(bankIndex, 1)
        lenBank = Len(bn)
        maxJoltageTotal = 0
        For i = 1 To lenBank - 1
            digitA = CInt(Mid(bn, i, 1))
            For j = i + 1 To lenBank
                digitB = CInt(Mid(bn, j, 1))
                '(A * 10) + B
                currentJoltage = (digitA * 10) + digitB
                If currentJoltage > maxJoltageTotal Then
                    maxJoltageTotal = currentJoltage
                End If
            Next j
        Next i
        sh.Cells(bankIndex + 1, 2).Value = maxJoltageTotal
        sumMaxJoltageTotal = sumMaxJoltageTotal + maxJoltageTotal
    Next bankIndex
    sh.Cells(1, 4).Value = "Sum Max Joltage Part I"
    sh.Cells(2, 4).Value = sumMaxJoltageTotal
End Sub
