% state given as list of left/right
% first elem: bank location of man
% first elem: bank location of wolf
% first elem: bank location of sheep
% first elem: bank location of cabbage

diffbanks(left,right).
diffbanks(right,left).

islegalmove([M1,W,S,C],[M2,W,S,C]) :- diffbanks(M1,M2), okaystate([M2,W,S,C]).
islegalmove([M1,M1,S,C],[M2,M2,S,C]) :- diffbanks(M1,M2), okaystate([M2,M2,S,C]).
islegalmove([M1,W,M1,C],[M2,W,M2,C]) :- diffbanks(M1,M2), okaystate([M2,W,M2,C]).
islegalmove([M1,W,S,M1],[M2,W,S,M2]) :- diffbanks(M1,M2), okaystate([M2,W,S,M2]).

okaystate([A,_,A,_]).
okaystate([_,B,A,B]) :- diffbanks(A,B).

legalsequence([]).
legalsequence([S]) :- okaystate(S).
legalsequence([S1,S2|T]) :- okaystate(S1), islegalmove(S1,S2), legalsequence([S2|T]).

solveriver(X,Y,Sol) :- length(Sol,L), nth1(L,Sol,Y), nth1(1,Sol,X),
					legalsequence(Sol).
