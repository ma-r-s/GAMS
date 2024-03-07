*************************************************************************
***      Lab 1                                                        ***
***      Ejercicio 2                                                  ***
***      Felipe Arias Russi - 201914996                               ***
***      Mario Ruiz - 201920695                                       ***
*************************************************************************

* Define el conjunto de filas de empleados
Sets
  i filas / Empleado1*Empleado4 / 
  
* Define el conjunto de trabajos
  j columnas / Trabajo1*Trabajo4 / ; 
  
* Define la función objetivo y la variable binaria para seleccionar cada empleado
* para cada trabajo
Variables
* Función objetivo para minimizar el tiempo.
  z    
* Variable binaria
  b(i,j);
  
* Asegura que la variable sea binaria
Binary Variable b(i,j);

* Define los tiempos en los que cada trabajador hace cada trabajo
Table t(i, j)
                Trabajo1  Trabajo2  Trabajo3  Trabajo4
    Empleado1    14        5         8         7
    Empleado2    2        12         6         5
    Empleado3    7         8         3         9
    Empleado4    2         4         6        10;

* Define las ecuaciones del modelo.
Equations
objectiveFunction        * Función objetivo.
* Restricciones de fila no puede haber un empleado haciendo varios trabajos.
restriction_fila
* Restricciones de columna, no puede haber un trabajo realizado por más de un empleado.
restriction_columna;

* Especifica la función objetivo.
objectiveFunction                ..  z =e= sum((i),sum((j), t(i,j)*b(i,j)));

* Establece las restricciones de cada fila
restriction_fila(i)                   ..  sum((j), b(i,j)) =e= 1;
restriction_columna(j)                   ..  sum((i), b(i,j)) =e= 1;

* Define y resuelve el modelo.

Model model1 /all/ ;
* Utiliza CPLEX como solver.
option lp=CPLEX;

* Minimiza el costo de la dieta.
Solve model1 using mip minimizing z;

* Muestra los resultados de las variables de decisión.
Display b.l;  
