*************************************************************************
***      Lab 2                                                        ***
***      Ejercicio 3                                                  ***
***      Felipe Arias Russi - 201914996                               ***
***      Mario Ruiz - 201920695                                       ***
*************************************************************************
Sets
    i "Zonas" / zona1*zona12 /;

Alias(j,i);

* La variable x(i) representa si se coloca una antena en la zona i (1 si se coloca, 0 en caso contrario).
* La variable z es la función objetivo que se desea minimizar.
Variables
  x(i)    
  z;  

Binary Variable x(i) "1 si se coloca una antena en la zona i, 0 en caso contrario";

Parameter a(i,j) "1 si la zona i es adyacente a la zona j, 0 en caso contrario";
a(i,j) = 0;
a('zona1','zona2') = 1;
a('zona1','zona3') = 1;
a('zona1','zona5') = 1;

a('zona2','zona1') = 1;
a('zona2','zona5') = 1;

a('zona3','zona1') = 1;
a('zona3','zona5') = 1;
a('zona3','zona4') = 1;
a('zona3','zona6') = 1;
a('zona3','zona8') = 1;
a('zona3','zona7') = 1;

a('zona4','zona5') = 1;
a('zona4','zona3') = 1;
a('zona4','zona6') = 1;
a('zona4','zona11') = 1;

a('zona5','zona2') = 1;
a('zona5','zona1') = 1;
a('zona5','zona3') = 1;
a('zona5','zona4') = 1;
a('zona5','zona11') = 1;
a('zona5','zona10') = 1;

a('zona6','zona4') = 1;
a('zona6','zona3') = 1;
a('zona6','zona8') = 1;
a('zona6','zona11') = 1;

a('zona7','zona3') = 1;
a('zona7','zona8') = 1;
a('zona7','zona12') = 1;

a('zona8','zona11') = 1;
a('zona8','zona6') = 1;
a('zona8','zona3') = 1;
a('zona8','zona7') = 1;
a('zona8','zona12') = 1;
a('zona8','zona9') = 1;

a('zona9','zona10') = 1;
a('zona9','zona11') = 1;
a('zona9','zona8') = 1;
a('zona9','zona12') = 1;

a('zona10','zona5') = 1;
a('zona10','zona11') = 1;
a('zona10','zona9') = 1;

a('zona11','zona5') = 1;
a('zona11','zona4') = 1;
a('zona11','zona6') = 1;
a('zona11','zona8') = 1;
a('zona11','zona9') = 1;
a('zona11','zona10') = 1;

a('zona12','zona7') = 1;
a('zona12','zona8') = 1;
a('zona12','zona9') = 1;


* La ecuación cover(i) asegura que cada zona esté cubierta por al menos una antena.
Equations
cover(i) "Cada zona debe estar cubierta por al menos una antena"
objectiveFunction;


* La restricción indica que la suma de las variables x(j) para todas las zonas adyacentes a la zona i,
* más la variable x(i) debe ser mayor o igual a 1.
objectiveFunction                                  ..  z =e= sum(i, x(i));


cover(i) ..  sum(j$(a(i,j) = 1), x(j)) + x(i) =g= 1;

Model antenna /all/ ;

Solve antenna using mip minimizing z;

Display x.l;