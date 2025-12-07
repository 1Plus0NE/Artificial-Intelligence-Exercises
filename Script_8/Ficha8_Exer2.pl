%LICENCIATURA EM ENGENHARIA INFORMATICA
%MESTRADO integrado EM ENGENHARIA INFORMATICA

%Inteligencia Artificial
%2024/25

%Draft Ficha 8 Exercicio 2


%biblioteca(id, nome, localidade)

biblioteca(1, uminhogeral, braga).
biblioteca(2, luciocracveiro, braga).
biblioteca(3, municipal, porto).
biblioteca(4, publica, viana).
biblioteca(5, ajuda, lisboa).
biblioteca(6, cidade, coimbra).


%livros( id, nome, biblioteca)

livros(1, gameofthrones, 1). 
livros(2, codigodavinci, 2).
livros(3, setimoselo, 1).
livros(4, fireblood, 4).
livros(5, harrypotter, 6).
livros(6, senhoradosneis, 7).
livros(7, oalgoritmomestre, 9).

%leitores(id, nome, genero)

leitores(1, pedro, m).
leitores(2, joao, m).
leitores(3, lucia, f).
leitores(4, sofia, f).
leitores(5, patricia, f).
leitores(6, diana, f).

%requisicoes(id_requisicao,id_leitor, id_livro, data(A,M,D)

requisicoes(1,2,3,data(2022,5,17)).
requisicoes(2,1,2,data(2022,7,10)).
requisicoes(3,1,3,data(2021,11,2)).
requisicoes(4,1,4,data(2022,2,1)).
requisicoes(5,5,3,data(2022,4,23)).
requisicoes(6,4,2,data(2021,3,9)).
requisicoes(7,4,1,data(2022,5,5)).
requisicoes(8,2,6,data(2021,7,18)).
requisicoes(9,5,7,data(2022,4,12)).


%devolucoes(id_requisicao, data(A,M, D))


devolucoes(2, data(2022, 7, 26)).
devolucoes(4, data(2022, 2, 4)).
devolucoes(5, data(2022, 6, 13)).
devolucoes(1, data(2022, 5, 23)).
devolucoes(6, data(2022, 4, 9)).

% -------------------------------------------------------------------------------------
% i. Quantos leitores do sexo feminino existem representados na base de conhecimentos;
% -------------------------------------------------------------------------------------

leitoras(N) :-
    findall(Id, leitores(Id, _, f), Lista),
    length(Lista, N).

% -------------------------------------------------------------------------------------
% ii. Quais os livros que foram requisitados por leitores, mas que não se encontram
%     associados a nenhuma biblioteca da base de conhecimento;
% -------------------------------------------------------------------------------------

livros_requisitados(LivrosFinal) :-
    findall(IdLivro, requisicoes(_, _, IdLivro, _), Livros),
    sort(Livros, LivrosFinal).

livros_outras_bibliotecas(LivrosFinal) :-
    livros_requisitados(LivrosReq),
    include(sem_biblioteca, LivrosReq, LivrosFinal).

sem_biblioteca(IdLivro) :-
    livros(IdLivro, _, IdBib),
    \+ biblioteca(IdBib, _, _).

% -------------------------------------------------------------------------------------
% iii. Indique quais os livros e os respetivos leitores que efetuaram requisições em
%      bibliotecas situadas em Braga;
% -------------------------------------------------------------------------------------

livros_leitores_braga(Resultado) :-
    findall((IdLivro, IdLeitor),
        (
            requisicoes(_, IdLeitor, IdLivro, _),
            livros(IdLivro, _, IdBiblioteca),
            biblioteca(IdBiblioteca, _, braga)
        ),
        Resultado
    ).

% -------------------------------------------------------------------------------------
% iv. Quais os livros que não tiveram nenhuma requisição. Para esta questão, assuma
%     requisição de livros que se encontram ou não em alguma biblioteca;
% -------------------------------------------------------------------------------------

livros_nao_requisitados(Livros) :-
    findall(IdLivro,
        (
            livros(IdLivro, _, _),
            \+ requisicoes(_, _, IdLivro, _)
        ),
        Livros
    ).

% ---------------------------------------------------------------------
% v. Apresente a lista de livros, e a respetiva data de requisição,
%    que tenham sido pedidos em 2022;
% ---------------------------------------------------------------------

livros_requisitados_2022(Resultado) :-
    findall((IdLivro, Data),
        (
            requisicoes(_, _, IdLivro, Data),
            Data = data(2022, _, _)
        ),
        Resultado
    ).

% --------------------------------------------------------------------------------
% vi. Que leitores requisitaram livros no Verão. Assuma que o Verão se encontra
%     compreendido entre Julho e Setembro;
% --------------------------------------------------------------------------------

verao(data(_, Mes, _)) :-
    Mes >= 7,
    Mes =< 9.
    
requisitados_verao(Leitores) :-
    findall(IdLeitor,
        (
            requisicoes(_, IdLeitor, _, Data),
            verao(Data)
        ),
        Leitores
    ).

% ---------------------------------------------------------------------------------------------
% vii. Assumindo que o período máximo de devolução de um livro depois da requisição é de
% no máximo 15 dias, indique quais os leitores, que entregaram um livro depois da data limite.
% ---------------------------------------------------------------------------------------------

dias(data(A, M, D), TotalDias) :-
    TotalDias is A*365 + M*30 + D.

diferenca_dias(Data1, Data2, Dif) :-
    dias(Data1, D1),
    dias(Data2, D2),
    Dif is D2 - D1.
    
atraso(DataReq, DataDev) :-
    diferenca_dias(DataReq, DataDev, Dif),
    Dif > 15.

leitores_atrasados(Leitor) :-
    requisicoes(IdReq, Leitor, _, DataReq),
    devolucoes(IdReq, DataDev),
    atraso(DataReq, DataDev).