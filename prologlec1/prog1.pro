parent(jim,ann).
parent(kim,ann).
parent(kim,joe).
parent(bob,jim).

grandparent(GP,GC) :- parent(GP,X), parent(X,GC).

greatgrandparent(GGP,GGC) :-
	grandparent(GGP,X), parent(X,GGC).

ancestor(X,Y) :- parent(X,Y).
ancestor(X,Y) :- parent(X,Z), ancestor(Z,Y).

sibling(X,Y) :- parent(P,X), parent(P,Y),
			write(X), nl, not(X=Y).
