Attribute VB_Name = "UnionFindTest"
Sub TestUnionFind()
    ' Comments in Spanish
    ' 1. Inicializar con 5 elementos (0 a 4)
    initUnionFind 5
    
    ' 2. Realizar uniones
    union 0, 1
    union 2, 3
    
    ' 3. Pruebas logicas
    Debug.Print "Prueba 1 (Conectados 0 y 1): " & connected(0, 1) ' Debe ser True
    Debug.Print "Prueba 2 (Conectados 0 y 2): " & connected(0, 2) ' Debe ser False
    
    ' 4. Unir los grupos
    union 1, 2
    Debug.Print "Prueba 3 (Conectados 0 y 3 tras Union 1,2): " & connected(0, 3) ' Debe ser True
    
    ' 5. Verificar numero de componentes
    ' Deben quedar 2 componentes: {0,1,2,3} y {4}
    Debug.Print "Componentes restantes: " & numComponents
    
    union 0, 4
    Debug.Print "Prueba 4 (Conectados 0 y 4 tras Union 3,4): " & connected(0, 4) ' Debe ser True
    Debug.Print "Componentes restantes: " & numComponents
    ' Debe quedar 1 componente: {0, 1, 2, 3, 4}
End Sub



