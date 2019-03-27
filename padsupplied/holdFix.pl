notInList([Head|Tail],Cord):-
Cord =\= Head,
notInList(Tail,Cord).

notInList([],_).


list_member(X,[X|_]).
list_member(X,(_|Tail)):-
list_member(X,Tail).
list_append(A,T,T):- list_member(A,T),!.
list_append(A,Tail,[A|Tail]).

isWord(Board,X,Y,[Head|Tail],List):-
boggleletter(Board,NewX,NewY,Head),
TargetX is X + 1,
NewY == Y,
NewX == TargetX,
NewCord is (NewX, + (NewY * 10)),
notInList(List,NewCord),
list_append(NewCord,List,NewList),
isWord(Board,NewX,Y,Tail,NewList).

isWord(Board,X,Y,[Head|Tail],List):-
boggleletter(Board,NewX,NewY,Head),
TargetY is Y + 1,
X ==  NewX,
NewY == TargetY,
NewCord is (NewX, + (NewY * 10)),
notInList(List,NewCord),
list_append(NewCord,List,NewList),
isWord(Board,X,NewY,Tail,NewList).

isWord(Board,X,Y,[Head|Tail]):-
boggleletter(Board,NewX,NewY,Head,List),
TargetX is X - 1,
NewY == Y,
NewX == TargetX,
NewCord is (NewX, + (NewY * 10)),
notInList(List,NewCord),
list_append(NewCord,List,NewList),
isWord(Board,NewX,Y,Tail,NewList).

isWord(Board,X,Y,[Head|Tail],List) :-
boggleletter(Board,NewX,NewY,Head),
TargetY is Y - 1,
NewX == X,
NewY == TargetY,
NewCord is (NewX, + (NewY * 10)),
notInList(List,NewCord),
list_append(NewCord,List,NewList),
isWord(Board,X,NewY,Tail,NewList).

isWord(Board,X,Y,[Head|Tail],List) :-
boggleletter(Board,NewX,NewY,Head),
TargetX is X + 1,
TargetY is Y + 1,
NewY == TargetY,
NewX == TargetX,
NewCord is (NewX, + (NewY * 10)),
notInList(List,NewCord),
list_append(NewCord,List,NewList),
isWord(Board,NewX,NewY,Tail,NewList).

isWord(Board,X,Y,[Head|Tail],List):-
boggleletter(Board,NewX,NewY,Head),
TargetX is X - 1,
TargetY is Y - 1,
NewX == TargetX,
NewY == TargetY,
NewCord is (NewX, + (NewY * 10)),
notInList(List,NewCord),
list_append(NewCord,List,NewList),
isWord(Board,NewX,NewY,Tail,NewList).

isWord(Board,X,Y,[Head|Tail],List):-
boggleletter(Board,NewX,NewY,Head),
TargetX is X + 1,
TargetY is Y - 1,
NewX == TargetX,
NewY == TargetY,
NewCord is (NewX, + (NewY * 10)),
notInList(List,NewCord),
list_append(NewCord,List,NewList),
isWord(Board,NewX,NewY,Tail,NewList).

isWord(Board,X,Y,[Head|Tail],List):-
boggleletter(Board,NewX,NewY,Head),
NewX == X - 1,
NewY == Y + 1,
NewCord is (NewX, + (NewY * 10)),
notInList(List,NewCord),
list_append(NewCord,List,NewList),
isWord(Board,NewX,NewY,Tail,NewList).

isWord(_,_,_,[],_).
