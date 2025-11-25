%-----------------------------------------------------------------------------
% i. Construir a extensão de um predicado que calcule a soma de três valores; 
%-----------------------------------------------------------------------------

sum3(A, B, C, Result) :-
    Result is A + B + C.

%----------------------------------------------------------------------------------------
% ii. Construir a extensão de um predicado que calcule a soma de um conjunto de valores;
%----------------------------------------------------------------------------------------

sum_list([], 0).
sum_list([H|T], Sum) :-
    sum_list(T, Rest),
    Sum is H + Rest.

%-----------------------------------------------------------------------------------------
% iii. Construir a extensão de um predicado que calcule o maior valor entre dois valores;
%-----------------------------------------------------------------------------------------

max2(A, B, Max) :-
    ( A >= B ->
        Max = A
    ;
        Max = B
    ).

%-----------------------------------------------------------------------------------------
% iv. Construir a extensão de um predicado que calcule o maior de um conjunto de valores;
%-----------------------------------------------------------------------------------------

max_value_list([H], H).
max_value_list([H|T], Max) :-
    max_value_list(T, TempMax),
    ( H > TempMax ->
        Max = H
    ;
        Max = TempMax
    ). 

%---------------------------------------------------------------------------------------------------
% v. Construir a extensão de um predicado que calcule a media aritmetica de um conjunto de valores;
%---------------------------------------------------------------------------------------------------

mean_list([], 0).
mean_list(List, Mean) :-
    sum_list(List, Sum),
    comprimento(List, N),
    Mean is Sum / N.

%--------------------------------------------------------------------------------------------------
% vi. Construir a extensão de um predicado que ordene de modo crescente uma sequência de valores;
%--------------------------------------------------------------------------------------------------

inserir_ordenado(X, [], [X]).
inserir_ordenado(X, [H|T], [X,H|T]) :- X =< H.
inserir_ordenado(X, [H|T], [H|T2]) :-
    X > H,
    inserir_ordenado(X, T, T2).

ordenar([], []).
ordenar([H|T], LOrdenada) :-
    ordenar(T, LT),
    inserir_ordenado(H, LT, LOrdenada).

%----------------------------------------------------------------------------------
% vii. Construa a extensão de um predicado capaz de caracterizar os números pares.
%----------------------------------------------------------------------------------

is_even(X):-
    0 is X mod 2.

%-------------------------------------------------------------------------------------------------------------------------
% viii. Construir a extensão do predicado «pertence» que verifica se um elemento existe dentro de uma lista de elementos;
%-------------------------------------------------------------------------------------------------------------------------

pertence(X, [X|_])
pertence(X,[_|T]) :-
    pertence(X, T).

%---------------------------------------------------------------------------------------------------------------
% ix. Construir a extensão do predicado «comprimento» que calcula o número de elementos existentes numa lista;
%---------------------------------------------------------------------------------------------------------------

comprimento([], 0).
comprimento([_|T], Comp) :-
    comprimento(T, Result),
    Comp is 1 + Result.

%----------------------------------------------------------------------------------------------------------------------------
% x. Construir a extensão do predicado «diferentes» que calcula a quantidade de elementos diferentes existentes numa lista;
%----------------------------------------------------------------------------------------------------------------------------

pertence(X, [X|_]).
pertence(X, [_|T]) :-
    pertence(X, T).

diferentes([], 0).

diferentes([H|T], N) :-
    pertence(H, T),             % H aparece na cauda, não contar
    diferentes(T, N).

diferentes([H|T], N) :-
    \+ pertence(H, T),          % H não aparece, contar +1
    diferentes(T, N1),
    N is N1 + 1.

%--------------------------------------------------------------------------------------------------------------
% xi. Construir a extensão do predicado «apaga1» que apaga a primeira ocorrência de um elemento de uma lista;
%--------------------------------------------------------------------------------------------------------------

apaga1(_, [], []).
apaga1(X, [X|T], T).
apaga1(X, [H|T], [H|R]) :-
    apaga1(X, T, R).
    

%----------------------------------------------------------------------------------------------------------------
% xii. Construir a extensão do predicado «apagaT» que apaga todas as ocorrências de um dado elemento numa lista;
%----------------------------------------------------------------------------------------------------------------

apagaT(_, [], []).
apagaT(X, [X|T], List) :-
    apagaT(X, T, List).

apagaT(X, [H|T], [H|R]) :-
    X \= H,
    apagaT(X, T, R).        % mantém H

%--------------------------------------------------------------------------------------------------------
% xiii. Construir a extensão do predicado «adicionar» que insere um elemento numa lista, sem o repetir;
%--------------------------------------------------------------------------------------------------------

pertence(X, [X|_]).
pertence(X, [_|T]) :-
    pertence(X, T).

adicionar(X, L, L) :-
    pertence(X, L).

adicionar(X, L, [X|L]) :-
    \+ pertence(X, L).

%-------------------------------------------------------------------------------------------------------------------------------------------
% xiv. Construir a extensão do predicado «concatenar», que resulta na concatenação dos elementos da lista L1 com os elementos da lista L2;
%-------------------------------------------------------------------------------------------------------------------------------------------

concat([], L, L).
concat([H|T_L1], L2, [H|T_L3]) :-       
    concat(T_L1, L2, T_L3).

%--------------------------------------------------------------------------------------------------
% xv. Construir a extensão do predicado «inverter» que inverte a ordem dos elementos de uma lista;
%---------------------------------------------------------------------------------------------------

inverter([], []).
inverter([H|T], List) :-
    inverter(T, TempList),
    concat(TempList, [H], List).

%-----------------------------------------------------------------------------------------------------------------
% xvi. Construir a extensão do predicado «sublista» que determina se uma lista S é uma sublista de outra lista L.
%-----------------------------------------------------------------------------------------------------------------

sublist(S, L) :-
    concat(_, L2, L),
    concat(S, _, L2).