%LICENCIATURA EM ENGENHARIA INFORMATICA
%MESTRADO integrado EM ENGENHARIA INFORMATICA

%Inteligencia Artificial
%2024/25

%Draft Ficha 8 Exercicio 1

% aluno(cod,nome,genero)
aluno(1,joao,m).
aluno(2,antonio,m).
aluno(3,carlos,m).
aluno(4,luisa,f).
aluno(5,maria,f).
aluno(6,isabel,f).

% curso(cod,curso)
curso(1,lei).
curso(2,miei).
curso(3,lcc).

% disciplina(cod,sigla,ano,curso)
disciplina(1,ed,2,1).
disciplina(2,ia,3,1).
disciplina(3,fp,1,2).

% inscrito(aluno,disciplina)
inscrito(1,1).
inscrito(1,2).
inscrito(5,3).
inscrito(5,5).
inscrito(2,5).

% nota(aluno,disciplina,nota)
nota(1,1,15).
nota(1,2,16).
nota(1,5,20).
nota(2,5,10).
nota(3,5,8).

% copia(aluno1, aluno2) <- aluno1 copiou aluno2
copia(1,2).
copia(2,3).
copia(3,4).

% --------------------------------------------------------------------
% i. Quais os alunos que não estão inscritos em qualquer disciplina;
% --------------------------------------------------------------------

nao_frequentam_lista(Lista) :-
    findall((Cod, Nome),
            (aluno(Cod, Nome, _), \+ inscrito(Cod, _)),
            Lista).

% ---------------------------------------------------------------------------------------------
% ii. Quais os alunos que não estão inscritos em qualquer disciplina, assumindo que um aluno
% inscrito numa disciplina que não existe não está inscrito;
% ---------------------------------------------------------------------------------------------

nao_inscritos_validos_lista(Lista) :-
    findall((Cod, Nome),
            (aluno(Cod, Nome, _),
             \+ (inscrito(Cod, Disc), disciplina(Disc, _, _, _))),
            Lista).

% --------------------------------------------
% iii. Qual a média de um determinado aluno;
% --------------------------------------------

media_aluno(AlunoCod, Media) :-
    findall(Nota, nota(AlunoCod, _, Nota), Notas),
    sum_list(Notas, Soma),          % Soma é o somatorio da lista
    length(Notas, N),               % N é o tamanho da lista
    N > 0,                          % garante que o aluno tem pelo menos uma nota
    Media is Soma / N.

% ----------------------------------------------------------------------------------------------------
% iv. Quais os alunos cuja média é acima da média (considere todas as notas de todas as disciplinas);
% ----------------------------------------------------------------------------------------------------

comprimento([], 0).
comprimento([_|T], Comp) :-
    comprimento(T, Result),
    Comp is 1 + Result.

soma_lista([], 0).
soma_lista([H|T], Soma) :-
    soma_lista(T, Resto),
    Soma is H + Resto.

todas_notas(Lista) :-
    findall(N, nota(_, _, N), Lista).

media_global(Media) :-
    todas_notas(Notas),
    soma_lista(Notas, S),
    comprimento(Notas, N),
    Media is S / N.

acima_da_media(Lista) :-
    media_global(MediaG),
    findall((Cod, Nome, MediaAluno),
             (
                 aluno(Cod, Nome, _),
                 media_aluno(Cod, MediaAluno),
                 MediaAluno > MediaG
             ),
             Lista).
% --------------------------------------------------------------------
% v. Quais os nomes dos alunos que copiaram;
% --------------------------------------------------------------------
alunos_copiadores(Lista) :-
    findall((Nome),
            (aluno(Cod, Nome, _), copia(Cod, _)),
            Lista).

% -----------------------------------------------------------------------------------
% vi. Quais os alunos que copiaram (diretamente ou indiretamente) por um dado aluno;
% -----------------------------------------------------------------------------------

% to do

% ---------------------------------------------------------------------------------------
% vii. mapToNome - converter uma lista de números de alunos numa lista de nomes. Assuma
% que podem ser dados números de alunos não registados (que devem ser ignorados).
% ---------------------------------------------------------------------------------------

mapToNome(ListaCodigos, ListaNomes) :-
    findall(Nome, (member(Cod, ListaCodigos), aluno(Cod, Nome, _)), ListaNomes).