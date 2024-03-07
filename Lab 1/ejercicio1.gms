*************************************************************************
***      Lab 1                                                        ***
***      Ejercicio 1                                                  ***
***      Felipe Arias Russi - 201914996                               ***
***      Mario Ruiz - 201920695                                       ***
*************************************************************************

* Define el conjunto de objetos disponibles para la mochila.
Sets
  i objetos / 0*4 / ; 
  
* Define la función objetivo y la variable binaria para selección de objetos.
Variables
* Función objetivo para maximizar el valor de la mochila.
  z    
* Variable binaria, representando si se toma un objeto o no.
  b(i);
  
* Asegura que b sea binaria
Binary Variable b(i);

* Define los pesos de cada objeto
Parameters p(i)
    / 0     9 
      1     2 
      2     2
      3     1
      4     3 /;
      
* Define el valor de cada objeto
Parameters v(i)
    / 0     12 
      1     5 
      2     9
      3     6
      4     4/;

* Define las ecuaciones del modelo.
Equations
objectiveFunction        * Función objetivo.
restriction             * Restricciones de peso de la mochila.;

* Especifica la función objetivo.
objectiveFunction                ..  z =e= sum((i), b(i)*v(i));

* Establece las restricciones para no exceder que el peso se mayor a 10
restriction                   ..  sum((i), b(i)*p(i)) =l= 10;

* Define y resuelve el modelo.
Model model1 /all/ ;
* Utiliza CPLEX como solver.
option lp=CPLEX;
* Minimiza el costo de la dieta.
Solve model1 using mip maximizing z;

* Muestra los resultados de las variables de decisión.
Display b.l;  
