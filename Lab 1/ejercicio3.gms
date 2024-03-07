*************************************************************************
***      Lab 1                                                        ***
***      Ejercicio 2                                                  ***
***      Felipe Arias Russi - 201914996                               ***
***      Mario Ruiz - 201920695                                       ***
*************************************************************************

Sets
    i "Procesadores origen" / origen1*origen3 /
    j "Procesadores destino" / destino1*destino4 /;

Variables
* Función objetivo para minimizar el costo total de transporte.
  z    
* Variable para cantidad de procesos mandados entre origen i y destino j.
  x(i,j);
  
* Asegura que las cantidades de envios sean positivas y enteras.
Integer Variable x(i,j);

* Define la oferta y demanda de cada procesador.
Parameters
    oferta(i) "Cantidad de procesos a suministrar por cada procesador origen"
    / origen1 300, origen2 500, origen3 200 /
    
    demanda(j) "Cantidad de procesos demandada por cada procesador destino"
    / destino1 200, destino2 300, destino3 100, destino4 400 /;


* Define los costos de envio entre procesadores
Table c(i, j)
                    destino1    destino2  destino3  destino4
    origen1          8              6        10        9
    origen2          9              12       13        7
    origen3          14             9        16        5;

* Define las ecuaciones del modelo.
Equations
objectiveFunction        * Función objetivo.
restriction_fila             * Restricciones nutricionales.
restriction_columna;
* Especifica la función objetivo.
objectiveFunction                ..  z =e= sum((i),sum((j), c(i,j)*x(i,j)));

* Establece las restricciones asegurar la oferta y demanda
restriction_fila(i)                   ..  sum((j), x(i,j)) =e= oferta(i);
restriction_columna(j)                   ..  sum((i), x(i,j)) =e= demanda(j);

* Define y resuelve el modelo.
Model model1 /all/ ;
* Utiliza CPLEX como solver.
option lp=CPLEX;
* Minimiza el costo de la dieta.
Solve model1 using mip minimizing z;

* Muestra los resultados de las variables de decisión.
Display x.l;  
