:- use_module(library(pairs)).
/********************************************************************************
 * recomendador.pl 																*
 * Autores: Juan Jesús Padrón Hernández											*
 * 			Daniel Valle Rodríguez												*
 * Curso: 2017/18																*
 * Descripción: Se trata de un recomendador de películas, libros, música...		*
 * Su funcionamiento se basa en tener una puntuación interna de compatibilidad.	*
 * Esta atiende al número de géneros que tiene la película en común con los que	*
 * le especificas que te gusta. De acuerdo a esto, se crea una lista			*
 * ordenada de mayor a menor puntuación.										*
 *																				*
 * ¿Cómo se usa?: la sentencia principal es:									*
 *	recomienda(Medio,ListaDeGustos,Recomendacion).								*
 *	donde Medio = peĺicula o libro o musica (lo que quiere que te recomiende)	*
 *	ListaDeGustos = Una lista de géneros que te gustan.							*
 *	Recomendacion = Variable donde se mostrará la recomendación que se te 		*
 *					está haciendo												*
 ********************************************************************************/
recomienda(musica,Gustos,Recomendacion):-
	findall(Musica,musica(Musica),Musicos),						%Crea una lista con todas los musicos en la base de conocimiento
	make_recomendation(Gustos,Musicos,Recomendaciones),			%make_recomendation filtra musicos de acuerdo a los gustos y las ordena
	member(Recomendacion,Recomendaciones).	

recomienda(libro,Gustos,Recomendacion):-
	findall(Libro,libro(Libro),Libros),							%Crea una lista con todos los libros en la base de conocimiento
	make_recomendation(Gustos,Libros,Recomendaciones),			%make_recomendation filtra los libros de acuerdo a los gustos y las ordena
	member(Recomendacion,Recomendaciones).						%Se coge un elemento de la lista de libros

recomienda(pelicula,Gustos,Recomendacion):-
	findall(Pelicula,pelicula(Pelicula),Peliculas),				%Crea una lista con todas las películas en la base de conocimiento
	make_recomendation(Gustos,Peliculas,Recomendaciones),		%make_recomendation filtra las películas de acuerdo a los gustos y las ordena
	member(Recomendacion,Recomendaciones).						%Se coge un elemento de la lista de perlículas

make_recomendation(Gustos,[],[]).								%Función para recursividad.
make_recomendation(Gustos,Elementos,SortedRecomendaciones):-	
	findall(Calidad-Elemento,(member(Elemento,Elementos),calidad(Elemento,Gustos,Calidad),Calidad>0),Pairs),
	%Crea una lista de pares Calidad-Elemento donde Calidad > 0	(al menos tiene que tener un género en común para incluirse en la lista)
	sort(Pairs,AuxPairs),										%Ordena la lista de acuerdo con la Calidad pero de manera ascendente																						
	invert(AuxPairs,SortedPairs),								%Invierte la lista para que quede ordenado de forma descendente
	pairs_values(SortedPairs,SortedRecomendaciones).			%Crea una lista solo con las peliculas, eliminando la calidad


calidad(Elemento,Gustos,Calidad):-
	genero(Elemento,Generos),
	my_intersect(Gustos,Generos,Comunes),
	tam(Comunes,Calidad).
/****************************************************************************
UTILIDADES
----------
my_intersect/3: devuelve la intersección de dos listas (elementos comunes) 
invert/2:		invierte el orden de la lista
addend/3:		añade elemento al final de una lista
tam/2: 			devuelve el tamaño de una lista
*****************************************************************************/
my_intersect([],_,[]).
my_intersect([A|As],Bs,[A|Cs]):-
    member(A,Bs),
    !,
    my_intersect(As,Bs,Cs).
my_intersect([_|As],Bs,Cs):-
	my_intersect(As,Bs,Cs).

invert([],[]).
invert([H|L],L2):-
	invert(L,L3),
	addend(H,L3,L2).

addend(X,[],[X]).
addend(X,[C|R],[C|R1]):-
	addend(X,R,R1). 

tam([],0).
tam([_|L],N):-
	tam(L,X),
	N is X + 1.

/****************************************************************************
Base de conocimiento - Películas
--------------------
Cotiene diferentes películas de diferentes géneros.
*****************************************************************************/

pelicula(sagaStarWars).
director(sagaStarWars,georgeLucas).
genero(sagaStarWars,[spaceOpera,cienciaFiccion,blockbuster,accion]).

pelicula(titanic).
director(titanic,jamesCameron).
genero(titanic,[romance,catastrofe,drama]).

pelicula(everithingIsIlluminated).
director(everithingIsIlluminated,lievSchreiber).
genero(everithingIsIlluminated,[comediaDramatica,comedia,drama,]).

pelicula(intoTheWild).
director(intoTheWild,seanPenn).
genero(intoTheWild,[drama,roadMovie,hechosReales]).

pelicula(ghostInTheShell).
director(ghostInTheShell,mamoruOshii).
genero(ghostInTheShell,[cienciaFiccion,cyberpunk,ciberpunk,thrillerPsicologico,thriller,animacion]).

pelicula(alien).
director(alien,ridleyScott).
genero(alien,[terror,cienciaFiccion,suspense]).

pelicula(lesMiserables).
director(lesMiserables,tomHooper).
genero(lesMiserables,[musical,historico,drama,romance]).

pelicula(moulinRouge).
director(moulinRouge,bazLuhrmann).
genero(moulinRouge,[musical,drama,romance]).

pelicula(amelie).
director(amelie,jeanPierreJeunet).
genero(amelie,[comedia,romance]).

pelicula(theFightClub).
director(theFightClub,davidFincher).
genero(theFightClub,[drama,comediaNegra,accion]).

pelicula(senToChihiroNoKamikakushi).
director(senToChihiroNoKamikakushi,hayaoMiyazaki).
genero(senToChihiroNoKamikakushi,[animacion,aventura,fantasía,drama]).




/****************************************************************************
Base de conocimiento - Libros
--------------------
Cotiene diferentes libros de diferentes géneros.
*****************************************************************************/

libro(amanecerRojo).
autor(amanecerRojo,pierceBrown).
genero(amanecerRojo,[novela,cienciaFiccion,distopia,juvenil]).

libro(lordOfTheRings).
autor(lordOfTheRings,jRRTolkien).
genero(lordOfTheRings,[fantasía,aventura,medieval,novelaCortes]).

libro(sagaEragon).
autor(sagaEragon,christopherPaolini).
genero(sagaEragon,[fantasía,aventura,dragones]).

libro(elResplandor).
autor(elResplandor,stephenKing).
genero(elResplandor,[novela,novelaNegra,terror,intriga,suspense]).

libro(laMillaVerde).
autor(laMillaVerde,stephenKing).
genero(laMillaVerde,[novela,suspense,drama,misterio]).

libro(elNombreDelViento).
autor(elNombreDelViento,patrickRothfuss).
genero(elNombreDelViento,[novela,fantasia,fantasiaHeroica,juvenil]).

libro(sagaNacidosDeLaBruma).
autor(sagaNacidosDeLaBruma,brandomSanderson).
genero(sagaNacidosDeLaBruma,[novela,fantasia,cienciaFiccion,juvenil]).

libro(sagaDelBrujo).
autor(sagaDelBrujo,andrzejSapkowski).
genero(sagaDelBrujo,[novela,fantasia,fantasiaHeroica]).

libro(laMaquinaDelTiempo).
autor(laMaquinaDelTiempo,herbertGeorgeWells).
genero(laMaquinaDelTiempo,[novela,cienciaFiccion,aventura]).

libro(guiaDelAutoestopistaGalactico).
autor(guiaDelAutoestopistaGalactico,douglasAdams).
genero(guiaDelAutoestopistaGalactico,[novela,cienciaFiccion,cienciaFiccionHumoristica,humor,novelaComica]).

libro(lasFloresDelMal).
autor(lasFloresDelMal,charlesBaudelaire).
genero(lasFloresDelMal,[poesia,poesiaLirica,muerte,belleza]).

/****************************************************************************
Base de conocimiento - Música
--------------------
Cotiene diferentes musicos de diferentes géneros.
*****************************************************************************/

musica(djangoReindhart).
genero(djangoReindhart,[jazz,swing,gypsyJazz,gypsy,guitar]).

musica(charlieParker).
genero(charlieParker,[jazz,bebop,saxophone]).

musica(milesDavis).
genero(milesDavis,[jazz,trumpet]).

musica(marcusMiller).
genero(marcusMiller,[jazz,funk,bass]).

musica(funkiwis).
genero(funkiwis,[rock,rap,funk,spanish]).

musica(diabloSwingOrchestra).
genero(diabloSwingOrchestra,[jazz,metal,swing,opera]).

musica(vitaImana).
genero(vitaImana,[metal,grooveMetal,spanish]).

musica(fkj).
genero(fkj,[electronica,techno,house,hiphop,jazz]).

musica(masego).
genero(masego,[hiphop,rap,electronica,house]).

musica(craneo).
genero(craneo,[hiphop,rap,lofi,spanish]).

musica(lasser).
genero(lasser,[hiphop,rap,lofi,spanish]).

musica(bnmp).
genero(bnmp,[rap,trap,spanish]).

musica(tommyCash).
genero(tommyCash,[trap]).

musica(littleBig).
genero(littleBig,[rave,funeralRave,rapRave,rap,russian]).

musica(juanLuisGuerra).
genero(juanLuisGuerra,[bachata,salsa,merengue,mambo,popLatino,latino]).

musica(buenaVistaSocialClub).
genero(buenaVistaSocialClub,[sonCubano,guajira,salsa,bolero]).

musica(afroCubanAllstars).
genero(afroCubanAllstars,[sonCubano,timba,salsa,latin]).

musica(donOmar).
genero(donOmar,[reggaeton,latino]).

musica(badBunny).
genero(badBunny,[reggaeton,trap,latino]).

musica(ledZeppelin).
genero(ledZeppelin,[clasico,rock]).