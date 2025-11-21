% Factos

filho(joao, jose).      % joao é filho de jose
filho(jose, manuel).    % jose é filho de manuel
filho(carlos, jose).    % carlos é filho de jose

pai(paulo, filipe).     % paulo é pai de filipe
pai(paulo, maria).      % paulo é pai de maria

avo(antonio, nadia).    % antonio é avô de nadia
neto(nuno, ana).        % nuno é neto de ana

sexo(joao, masculino).  % joao é de sexo masculino
sexo(jose, masculino).  % jose é de sexo masculino
sexo(maria, feminino).  % maria é de sexo feminino
sexo(joana, feminino).  % joana é de sexo feminino

% Regras

%----------------------------------------------------------
% xii. P é pai de F quando F é filho de P.
%----------------------------------------------------------

pai(X, Y) :-
    filho(Y, X).

%----------------------------------------------------------
% xiii. A é avô de N se N for filho de X e A pai de X.
%----------------------------------------------------------

avo(A, N) :-
    filho(N, X),
    pai(A, X).

%----------------------------------------------------------
% xiv. N é neto de A se A é avô de N.
%----------------------------------------------------------

neto(N, A) :-
    avo(A, N)

%----------------------------------------------------------
% xv. Descendência (recursão)
%     X descende de Y se:
%       - caso base: X é filho de Y
%       - caso recursivo: X é filho de Z que descende de Y
%----------------------------------------------------------

descende(X, Y) :-
    filho(X, Y).                    % caso base

descende(X, Y) :-
    filho(X, Z),                    % caso recursivo
    descende(Z, Y).

%----------------------------------------------------------
% xvi. Grau de descendência
%     grau_descendencia(X, Y, G)
%       G = número de gerações entre X e Y
%----------------------------------------------------------

grau_descendencia(X, Y, 1) :-
    filho(X, Y).                    % grau 1 = filho

grau_descendencia(X, Y, G) :-
    filho(X, Z),
    grau_descendencia(Z, Y, G1),
    G is G1 + 1.

%----------------------------------------------------------
% xvii. Avô através do grau
%       A é avô de N quando N descende de A com grau 2.
%----------------------------------------------------------

avo_grau(A, N) :-
    grau_descendencia(N, A, 2).

%----------------------------------------------------------
% xviii. Bisavô (3 gerações acima)
%----------------------------------------------------------

bisavo(A, N) :-
    grau_descendencia(N, A, 3).

%----------------------------------------------------------
% xix. Trisavô (4 gerações acima)
%----------------------------------------------------------

trisavo(A, N) :-
    grau_descendencia(N, A, 4).

%----------------------------------------------------------
% xx. Tetraneto (4 gerações abaixo)
%       X é tetraneto de Y se o grau entre X e Y é 4.
%----------------------------------------------------------

tetraneto(X, Y) :-
    grau_descendencia(X, Y, 4).