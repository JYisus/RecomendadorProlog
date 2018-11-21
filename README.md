# Recomendador en Prolog
Realizado para la asignatura de Inteligencia Artificial del grado de Ingeniería Informática de la ULL
Curso 2017-2018.
recomendador.pl
## Descripción 
Se trata de un recomendador de películas, libros, música... Su funcionamiento se basa en tener una puntuación interna de compatibilidad.
Esta atiende al número de géneros que tiene la película en común con los que le especificas que te gusta. De acuerdo a esto, se crea una lista ordenada de mayor a menor puntuación.
## ¿Cómo se usa?
la sentencia principal es:
```
recomienda(Medio,ListaDeGustos,Recomendacion).
```
donde:
- *Medio = peĺicula o libro o musica (lo que quiere que te recomiende)*
- *ListaDeGustos = Una lista de géneros que te gustan.*
- *Recomendacion = Variable donde se mostrará la recomendación que se te está haciendo*
