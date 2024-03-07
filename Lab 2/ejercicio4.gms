*************************************************************************
***      Lab 2                                                        ***
***      Ejercicio 4                                                  ***
***      Felipe Arias Russi - 201914996                               ***
***      Mario Ruiz - 201920695                                       ***
*************************************************************************
Sets
* Conjunto de nodos
  i 'nodos' /nodo1*nodo7/  
  
* Alias para iterar sobre los nodos
alias(j,i);  

* Tabla con las coordenadas de cada nodo
Table coord(i,*) 'coordenadas de cada nodo'
            x  y
  nodo1     20 6
  nodo2     22 1
  nodo3     9  2
  nodo4     3  25
  nodo5     21 10
  nodo6     29 2
  nodo7     14 12;  

* Calcular la distancia entre cada par de nodos
Parameter dist(i,j) 'distancia entre cada par de nodos';
dist(i,j) = sqrt(sqr(coord(i,'x') - coord(j,'x')) + sqr(coord(i,'y') - coord(j,'y')));  

* Establecer el costo de los enlaces propios a un valor grande
Parameter cost(i,j) 'costo de cada enlace';
loop((i,j),
  if(dist(i,j) <= 20,
    cost(i,j) = dist(i,j);
  else
    cost(i,j) = 99999;
  );
);
cost(i,i) = 9999;  

Variables
  x(i,j)      Indica si el enlace i-j está seleccionado o no.
  z           Función objetivo;

Binary Variable x;

Equations
  objectiveFunction        función objetivo
  sourceNode(i)            nodo fuente
  destinationNode(j)       nodo destino
  intermediateNode(i)      nodo intermedio;

* Definir la función objetivo
objectiveFunction..  z =e= sum((i,j), cost(i,j) * x(i,j));  

* Restricción para seleccionar un nodo fuente
sourceNode(i)$(ord(i) = 4)                         ..  sum((j), x(i,j)) =e= 1;  

* Restricción para seleccionar un nodo destino
destinationNode(j)$(ord(j) = 6)                    ..  sum((i), x(i,j)) =e= 1;  

* Restricción para nodos intermedios
intermediateNode(i)$(ord(i) <> 4 and ord(i) ne 6)  ..  sum((j), x(i,j)) - sum((j), x(j,i)) =e= 0;  

Model model1 /all/ ;
* Establecer la opción del solucionador a CPLEX
option mip=CPLEX  
* Resolver el modelo
Solve model1 using mip minimizing z;  

* Mostrar el costo de cada enlace
Display cost;  
* Mostrar los enlaces seleccionados
Display x.l;  
* Mostrar el valor de la función objetivo
Display z.l;  
