intree(X,node(X,_,_)) :- !.
intree(X,node(Y,LST,_)) :- X<Y, !, intree(X,LST).
intree(X,node(_,_,RST)) :- intree(X,RST).

alltree(X,node(X,_,_)).
alltree(X,node(_,LST,_)) :- alltree(X,LST).
alltree(X,node(_,_,RST)) :- alltree(X,RST).

% addtree(A,B,C) succeeds if C is the tree resulting from
% 	adding element B to the tree A
addtree(null,X,node(X,null,null)) :- !.
addtree(node(X,L,R),X,node(X,L,R)) :- !.
addtree(node(Y,L,R),X,node(Y,NL,R)) :- X<Y, !, addtree(L,X,NL).
addtree(node(Y,L,R),X,node(Y,L,NR)) :- addtree(R,X,NR).

mypred(A,D,X) :- addtree(A,3,B), addtree(B,6,C), addtree(C,0,D),
	alltree(X,D).
%
% example "query:"
% findall([X],mypred(A,D,X),Z).
%   or
% findall([D,X],mypred(A,D,X),Z).

%      3
%   2     6
% 1     4   7
%
%
%
% node(3,node(2,node(1,null,null),null),
%        node(6,node(4,null,null),node(7,null,null)))
