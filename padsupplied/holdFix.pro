notInList([Head|Tail],Cord):-
Cord =\= Head,
notInList(Tail,Cord).

notInList([],_).


list_member(X,[X|_]).
list_member(X,(_|Tail)):-
list_member(X,Tail).
list_append(A,T,T):- list_member(A,T),!.
list_append(A,Tail,[A|Tail]).

dupAdd(NewX,NewY,List,NewList):-
NewCord is (NewX, + (NewY * 10)),
notInList(List,NewCord),
list_append(NewCord,List,NewList).