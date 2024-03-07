*************************************************************************
***      Lab 2                                                        ***
***      Ejercicio 1                                                  ***
***      Felipe Arias Russi - 201914996                               ***
***      Mario Ruiz - 201920695                                       ***
*************************************************************************
* Definición de conjuntos
Sets
    i "Procesadores origen" / origen1*origen3 /
    j "Procesadores destino" / destino1*destino2 /
    k "Tipos de procesos" / kernel, usuario /;

* Definición de variables
Variables
    z "Función objetivo para minimizar el costo total de transporte"
    x(i,j,k) "Cantidad de procesos mandados entre origen i y destino j de tipo k";

* Declaración de variables enteras
Integer Variable x(i,j,k);

* Definición de parámetros
Parameters
    oferta(i,k) "Cantidad de procesos a suministrar por cada procesador origen"
    / origen1.kernel 60, origen1.usuario 80,
      origen2.kernel 80, origen2.usuario 50,
      origen3.kernel 50, origen3.usuario 50 /

    demanda(j,k) "Cantidad de procesos demandada por cada procesador destino"
    / destino1.kernel 100, destino1.usuario 60,
      destino2.kernel 90, destino2.usuario 120 /;

* Definición de tabla de costos
Table c(i, j) "Costos de envio entre procesadores"
                destino1    destino2
    origen1      300         500
    origen2      200         300
    origen3      600         300;

* Definición de ecuaciones
Equations
    objectiveFunction
    restriction_fila(i,k)
    restriction_columna(j,k);

* Definición de la función objetivo
objectiveFunction ..  z =e= sum((i,j,k), c(i,j)*x(i,j,k));

* Restricción de suministro por procesador origen
restriction_fila(i,k) ..  sum((j), x(i,j,k)) =e= oferta(i,k);

* Restricción de demanda por procesador destino
restriction_columna(j,k) ..  sum((i), x(i,j,k)) =e= demanda(j,k);

* Definición del modelo
Model model1 /all/ ;

* Configuración del solver
option lp=CPLEX;

* Resolución del modelo
Solve model1 using mip minimizing z;

* Mostrar los valores de las variables de decisión
Display x.l;