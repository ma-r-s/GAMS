* Definición de conjuntos
Set
* Conjunto de científicos
    i 'scientists' /scientist1*scientist6/  
* Conjunto de técnicas
    j 'techniques' /supervised, unsupervised, deep_learning, reinforcement_learning/;  

* Definición de tabla de puntuaciones
Table score(i,j) 'score of each scientist for each technique'
                    supervised unsupervised deep_learning reinforcement_learning
    scientist1          85           78           82             84
    scientist2          88           77           81             84
    scientist3          87           77           82             88
    scientist4          82           76           80             83
    scientist5          91           79           86             84
    scientist6          86           78           81             85;

* Definición de variables binarias
Binary Variable x(i,j) '1 if scientist i is assigned to technique j, 0 otherwise';

* Definición de variable de puntuación total
Variable total_score 'total score of the team';

* Definición de ecuaciones
Equation
    def_total_score 'definition of total_score'  
    one_scientist_per_technique(j) 'each technique is covered by exactly one scientist'  
    one_technique_per_scientist(i) 'each scientist is assigned to at most one technique'; 
* Definición de la ecuación de puntuación total
def_total_score.. total_score =e= sum((i,j), score(i,j)*x(i,j));

* Restricción: cada técnica debe ser cubierta por exactamente un científico
one_scientist_per_technique(j).. sum(i, x(i,j)) =e= 1;

* Restricción: cada científico debe ser asignado a lo sumo a una técnica
one_technique_per_scientist(i).. sum(j, x(i,j)) =l= 1;

* Definición del modelo
Model team_selection /all/;

* Resolución del modelo utilizando programación entera mixta (MIP) y maximizando la puntuación total
Solve team_selection using mip maximizing total_score;

* Mostrar los valores de las variables y la puntuación total obtenida
Display x.l, total_score.l;