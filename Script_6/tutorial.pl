localizacao(porto,portugal). 
localizacao(lisboa,portugal). 
localizacao(coimbra,portugal). 
localizacao(caminha,portugal). 
localizacao(madrid,espanha). 
localizacao(barcelona,espanha).
localizacao(zamora,espanha).
localizacao(orense,espanha).
localizacao(toledo,espanha).

atravessa(douro,porto). 
atravessa(douro,zamora). 
atravessa(tejo,lisboa). 
atravessa(tejo,toledo).
atravessa(minho,caminha).
atravessa(minho,orense). 

b(1).
b(2).
b(3).
c(1).
c(2).
c(3).

a1 (X, Y) :-b(X), c(Y).

rio(minho).
rio(tejo).
rio(ave).
rio(douro).
pai(pedro, raquel).

potencia(_,0,1):-!.
potência(X,N,P):- N1 is N-1,
            potência(X,N1,P1),
            P is X*P1.

rio_português(R):-atravessa(R,C),localizacao(C,portugal).
mesmo_rio(C1,C2):-atravessa(R,C1),atravessa(R,C2),C1\==C2.