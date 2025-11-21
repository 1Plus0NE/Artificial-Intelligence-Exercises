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