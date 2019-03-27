mappend([],X,X).
mappend([H|T],L,[H|NewT]) :- mappend(T,L,NewT).
mymem(X,[X|_]) :- !.
mymem(X,[_|T]) :- mymem(X,T).

%mylen(X,L).
mylen([],0).
mylen([_|T],L) :- mylen(T,LTail), L is LTail+1.
