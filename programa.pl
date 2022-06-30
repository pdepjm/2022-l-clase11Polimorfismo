/*
Hay bandas, y cada banda tuvo discos en distintos momentos del año:
Los piojos sacó chactuchac el 8 de agosto de 1992.
oneDirection sacó takeMeHome el 12 de noviembre de 2012.
*/


disco(losPiojos, chactuchac, fecha(8,8,1992)).
disco(losPiojos, ayayay, fecha(10,12,1994)).
disco(losPiojos, tercerArco, fecha(31,agosto,1996)).
disco(damasGratis, somosNosotrosLosBuenos, fecha(9,12,2016)).
disco(oneDirection, takeMeHome, fecha(12,11,2012)).
disco(oneDirection, midnightMemories, fecha(25,11,2013)).

% anioProductivo/2 relaciona una banda y un anio si produjo algún disco.

anioProductivo(Banda, Anio):-
    disco(Banda,_,fecha(_,_,Anio)).


% agostino/1 un disco es agostino cuando salió en agosto.

agostino(Nombre):-
    disco(_, Nombre, fecha(_,Mes,_)),
    esAgosto(Mes).

% delego lidiar con los tipos distintos a otro predicado.
esAgosto(8).
esAgosto(agosto).

/********************************
 * MALO FEO REPITE LOGICA
 * Podemos intentar tratar polimorficamente distintos tipos
agostino(Nombre):-
    disco(_, Nombre, fecha(_,8,_)).
    
agostino(Nombre):-
    disco(_, Nombre, fecha(_,agosto,_)).
*/
% esAnterior/2 me dice si una fecha es anterior a un año.
esAnterior(fecha(_,_,AnioAnt), Anio):-
    AnioAnt < Anio.

% bandaMillenial/1 se cumple cuando una banda tuvo algún disco antes del 2000

bandaMillenial(Banda):-
    disco(Banda,_,Fecha),
    esAnterior(Fecha, 2000).

% Aritmética: edad de un disco (considerar sólo los años).

anioActual(2022).

antiguedad(Nombre, Antiguedad):-
    disco(_, Nombre, fecha(_,_,Anio)),
    anioActual(AnioActual),
    is(Antiguedad,AnioActual - Anio).
    %AnioActual - Anio = Antiguedad.

/*
Sabemos de los siguientes eventos:
    - losPiojos tuvieron:
        un show masivo en cosquinRock donde participaron 15 bandas y se hizo en Argentina
        un show propio en un estadio para 70.074 personas
    - damasGratis hacen un show propio en un lugar que tiene capacidad para 9.290 personas
    - oneDirection planea un vivo de instagram en su cuenta oficial: oneDirection con una duracion estimada de 2 horas y media. En su cuenta tienen 22.300.000 followers.
    
*/
% Queremos saber todos los eventos de una banda.

hace(losPiojos, masivo(cosquinRock, 15, argentina)).
hace(losPiojos, propio(70074)).
hace(damasGratis, propio(9290)).
hace(oneDirection, vivoIG(oneDirection, 150, 22300000)).

% esto se podría: hace(losPiojos,propio(70074, 5)).
% confunde un poco así que no lo hacemos.

    % Presentacion pueden ser Show masivo, Show propio, Vivo de ig
    % Functor(es) -> Inidividuos compuestos (de otros individuos) 
    %               -> Son como tuplas pero con nombres
    %               -> Son individuos, no predicados, no tienen valor de verdad, son un dato



% evento(Banda, Presentacion).
% Siendo Presentacion:
    % masivo(Festival, CantBandas, Pais)
    % propio(Capacidad)
    % vivoIG(Cuenta, DuracionEstimada, Followers)


/*
bandaPiola/1: Se cumple para una banda cuando tiene alguna presentación pero además todas sus presentaciones son piolas.
- Los shows masivos son piolas cuando son en cosquin en argentina
- Los shows propios son siempre piolas
- Los vivos de instagram son piolas si duran entre 1 y 3 horas.
*/

bandaPiola(Banda):-
    hace(Banda,_),
    forall(hace(Banda,Evento),esPiola(Evento)).

esPiola(masivo(cosquinRock,_,argentina)).
esPiola(propio(_)).
esPiola(vivoIG(_,Duracion,_)):-
    between(60,180,Duracion).

/*
esFamosa/1: Una banda es famosa cuando alguno de sus eventos tienen una asistencia proyectada de más de 987 personas.

La asistencia proyectada se calcula así:
    Para los show propios estimamos la capacidad del lugar
    Para un show masivo es 1000 veces la cantidad de bandas del festival
    Para un vivo de instagram es la centésima parte de la cantidad de seguidores dividido la duración esperada
*/


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% LABO %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/*
Enunciado para el labo:

Punto 1)
Hacer el predicado nacionalidad/1: ana, belu y chiqui son de nacionalidad argentina, dante es de uruguay y eli de brasil.

Punto 2)
Hacer el predicado seguroVa/2: Relaciona una persona y una presentación y es cierta cuando esa persona podria asistir fácilmente a la presentación.
- Para los show masivos si el país coincide con tu nacionalidad
- Para los vivos de instagram si se espera una duración menor a 3 horas
- No hay asistencia asegurada para los eventos propios.

Punto 3)
Hacer el predicado bandaCarita/1, que se cumple para aquella banda con la presentación más cara.
- Los show masivos cuestan 500 monedas por cada banda.
- Los show propios cuestan 1 moneda por cada lugar disponible.
- Los vivos de instagram cuestan 1 moneda por hora por cada 200 seguidores.
*/