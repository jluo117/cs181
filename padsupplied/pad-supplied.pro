% randelem(+list,?elem)
randelem(L,X) :- length(L,LL), I is random(LL), nth0(I,L,X).

% selandrem(+index,+list,-list,-elem)
selandrem0(0,[X|R],R,X) :- !.
selandrem0(I,[A|R],[A|Rout],X) :- NI is I-1, selandrem0(NI,R,Rout,X).

% just a helper function to boggleboard, below
% bbhelp(-board,+nleft,+cubes)
bbhelp([],0,[]) :- !.
bbhelp([X|R],L,CS) :- I is random(L), selandrem0(I,CS,NCS,C), randelem(C,X), !,
				NL is L-1, bbhelp(R,NL,NCS).

% returns a randomly chosen boggle board.
% No choice points -- will not backtrack
% boggleboard(-board)
boggleboard(B) :- bbhelp(B,16,
		[['A','A','E','E','G','N'],['A','B','B','J','O','O'],
		 ['A','C','H','O','P','S'],['A','F','F','K','P','S'],
		 ['A','O','O','T','T','W'],['C','I','M','O','T','U'],
		 ['D','E','I','L','R','X'],['D','E','L','R','V','Y'],
		 ['D','I','S','T','T','Y'],['E','E','G','H','N','W'],
		 ['E','E','I','N','S','U'],['E','H','R','T','V','W'],
		 ['E','I','O','S','S','T'],['E','L','R','T','T','Y'],
		 ['H','I','M','N','Q','U'],['H','L','N','N','R','Z']]).

% boggleletter(+board,?xindex,?yindex,?character)
boggleletter(B,X,Y,C) :- nth0(N,B,C), XR is N/4, X is floor(XR), Y is mod(N,4).

% you should not use this... you will need to traverse the dictionary
% yourself.  However, this checks whether the first argument (a list of
% characters) is in the dictionary (the second argument)
% order it adds the word to the dictionary
% indict(?word,?dictionary)
indict([X],node(X,true,_,_)).
indict([X|RX],node(X,_,Y,_)) :- indict(RX,Y).
indict([X|RX],node(_,_,_,Y)) :- indict([X|RX],Y).

% a helper function to loaddict, below
loaddicthelp(S,_) :- at_end_of_stream(S), !.
loaddicthelp(S,D) :- read_line_to_codes(S,C), atom_codes(Str,C),
		atom_chars(Str,W), indict(W,D), !, loaddicthelp(S,D).

% a helper function to loaddict, only succeeds if the dictionary is grounded.
restrictdict(null) :- !.
restrictdict(node(_,false,L,R)) :- !, restrictdict(L), !, restrictdict(R).
restrictdict(node(_,true,L,R)) :- !, restrictdict(L), !, restrictdict(R).

% loads a dictionary
% loaddict(+filename,-dictionary)
loaddict(Filename,Dict) :- 
	open(Filename,read,S), !,
	loaddicthelp(S,Dict), !, 
	restrictdict(Dict),
	close(S).

% draws a boggle board 
% drawboard(+board).
drawboard(B) :- drawboard(B,16).
drawboard(_,0) :- !.
drawboard([X|Y],I) :- 1 =:= mod(I,4), !, writeln(X),
		II is I-1, drawboard(Y,II).
drawboard([X|Y],I) :- write(X), II is I-1, drawboard(Y,II).

% word is a list of characters
% boggleword(+board,?word)
boggleword(B,X) :- loaddict(bogwords,D), isboggleword(B,D,X).

isboggleword(Board,Dict,[Head|Tail]):-
boggleletter(Board,X,Y,Head),
NumVal is (X + (Y * 10)),
list_append(NumVal,[],List),
indict([Head|Tail],Dict),
isWord(Board,X,Y,Tail,List).

isboggleword(Board,node(V,true,_,_),Word):-
boggleletter(Board,_,_,V),
list_append(V,[],Word).

isboggleword(Board,node(V,_,D,_),Word):-
boggleletter(Board,X,Y,V),
list_append(V,[],NWord),
NumVal is (X + (Y * 10)),
list_append(NumVal,[],List),
traversalTree(Board,D,X,Y,Word,NWord,List).

isboggleword(Board,node(_,_,_,L) , Word):-
isboggleword(Board,L,Word).

traversalTree(Board,node(V,_,D,_),X,Y,Word,CurWord,List):-
boggleletter(Board,NewX,NewY,V),
TargetX is X + 1,
NewY == Y,
NewX == TargetX,
NumVal is (NewX + (NewY * 10)),
notInList(List,NumVal),
list_append(NumVal,List,NList),
list_append(V,[],NChar),
append(CurWord,NChar,NWord),
traversalTree(Board,D,NewX,NewY,Word,NWord,NList).

traversalTree(Board,node(V,true,_,_),X,Y,Word,CurWord,List):-
boggleletter(Board,NewX,NewY,V),
TargetX is X + 1,
NewY == Y,
NewX == TargetX,
NumVal is (NewX + (NewY * 10)),
notInList(List,NumVal),
list_append(V,[],NChar),
append(CurWord,NChar,Word).

traversalTree(Board,node(V,_,D,_),X,Y,Word,CurWord,List):-
boggleletter(Board,NewX,NewY,V),
TargetY is Y + 1,
NewY == TargetY,
NewX == X,
NumVal is (NewX + (NewY * 10)),
notInList(List,NumVal),
list_append(NumVal,List,NList),
list_append(V,[],NChar),
append(CurWord,NChar,NWord),
traversalTree(Board,D,NewX,NewY,Word,NWord,NList).

traversalTree(Board,node(V,true,_,_),X,Y,Word,CurWord,List):-
boggleletter(Board,NewX,NewY,V),
TargetY is Y + 1,
NewY == TargetY,
NewX == X,
NumVal is (NewX + (NewY * 10)),
notInList(List,NumVal),
list_append(V,[],NChar),
append(CurWord,NChar,Word).

traversalTree(Board,node(V,_,D,_),X,Y,Word,CurWord,List):-
boggleletter(Board,NewX,NewY,V),
TargetX is X - 1,
NewY == Y,
NewX == TargetX,
NumVal is (NewX + (NewY * 10)),
notInList(List,NumVal),
list_append(NumVal,List,NList),
list_append(V,[],NChar),
append(CurWord,NChar,NWord),
traversalTree(Board,D,NewX,NewY,Word,NWord,NList).

traversalTree(Board,node(V,true,_,_),X,Y,Word,CurWord,List):-
boggleletter(Board,NewX,NewY,V),
TargetX is X - 1,
NewY == Y,
NewX == TargetX,
NumVal is (NewX + (NewY * 10)),
notInList(List,NumVal),
list_append(V,[],NChar),
append(CurWord,NChar,Word).


traversalTree(Board,node(V,_,D,_),X,Y,Word,CurWord,List):-
boggleletter(Board,NewX,NewY,V),
TargetY is Y - 1,
NewY == TargetY,
NewX == X,
NumVal is (NewX + (NewY * 10)),
notInList(List,NumVal),
list_append(NumVal,List,NList),
list_append(V,[],NChar),
append(CurWord,NChar,NWord),
traversalTree(Board,D,NewX,NewY,Word,NWord,NList).

traversalTree(Board,node(V,true,_,_),X,Y,Word,CurWord,List):-
boggleletter(Board,NewX,NewY,V),
TargetY is Y - 1,
NewY == TargetY,
NewX == X,
NumVal is (NewX + (NewY * 10)),
notInList(List,NumVal),
list_append(V,[],NChar),
append(CurWord,NChar,Word).

traversalTree(Board,node(V,_,D,_),X,Y,Word,CurWord,List):-
boggleletter(Board,NewX,NewY,V),
TargetX is X + 1,
TargetY is Y + 1,
NewY == TargetY,
NewX == TargetX,
NumVal is (NewX + (NewY * 10)),
notInList(List,NumVal),
list_append(NumVal,List,NList),
list_append(V,[],NChar),
append(CurWord,NChar,NWord),
traversalTree(Board,D,NewX,NewY,Word,NWord,NList).

traversalTree(Board,node(V,true,_,_),X,Y,Word,CurWord,List):-
boggleletter(Board,NewX,NewY,V),
TargetX is X + 1,
TargetY is Y + 1,
NewX == TargetX,
NewY == TargetY,
NumVal is (NewX + (NewY * 10)),
notInList(List,NumVal),
list_append(V,[],NChar),
append(CurWord,NChar,Word).



traversalTree(Board,node(V,_,D,_),X,Y,Word,CurWord,List):-
boggleletter(Board,NewX,NewY,V),
TargetX is X - 1,
TargetY is Y - 1,
NewY == TargetY,
NewX == TargetX,
NumVal is (NewX + (NewY * 10)),
notInList(List,NumVal),
list_append(NumVal,List,NList),
list_append(V,[],NChar),
append(CurWord,NChar,NWord),
traversalTree(Board,D,NewX,NewY,Word,NWord,NList).

traversalTree(Board,node(V,true,_,_),X,Y,Word,CurWord,List):-
boggleletter(Board,NewX,NewY,V),
TargetX is X - 1,
TargetY is Y - 1,
NewX == TargetX,
NewY == TargetY,
NumVal is (NewX + (NewY * 10)),
notInList(List,NumVal),
list_append(V,[],NChar),
append(CurWord,NChar,Word).

traversalTree(Board,node(V,_,D,_),X,Y,Word,CurWord,List):-
boggleletter(Board,NewX,NewY,V),
TargetX is X - 1,
TargetY is Y + 1,
NewY == TargetY,
NewX == TargetX,
NumVal is (NewX + (NewY * 10)),
notInList(List,NumVal),
list_append(NumVal,List,NList),
list_append(V,[],NChar),
append(CurWord,NChar,NWord),
traversalTree(Board,D,NewX,NewY,Word,NWord,NList).

traversalTree(Board,node(V,true,_,_),X,Y,Word,CurWord,List):-
boggleletter(Board,NewX,NewY,V),
TargetX is X - 1,
TargetY is Y + 1,
NewX == TargetX,
NewY == TargetY,
NumVal is (NewX + (NewY * 10)),
notInList(List,NumVal),
list_append(V,[],NChar),
append(CurWord,NChar,Word).

traversalTree(Board,node(V,_,D,_),X,Y,Word,CurWord,List):-
boggleletter(Board,NewX,NewY,V),
TargetX is X + 1,
TargetY is Y - 1,
NewY == TargetY,
NewX == TargetX,
NumVal is (NewX + (NewY * 10)),
notInList(List,NumVal),
list_append(NumVal,List,NList),
list_append(V,[],NChar),
append(CurWord,NChar,NWord),
traversalTree(Board,D,NewX,NewY,Word,NWord,NList).

traversalTree(Board,node(V,true,_,_),X,Y,Word,CurWord,List):-
boggleletter(Board,NewX,NewY,V),
TargetX is X + 1,
TargetY is Y - 1,
NewX == TargetX,
NewY == TargetY,
NumVal is (NewX + (NewY * 10)),
notInList(List,NumVal),
list_append(V,[],NChar),
append(CurWord,NChar,Word).


traversalTree(Board,node(_,_,_,R),X,Y,Word,CurWord,List):-
traversalTree(Board,R,X,Y,Word,CurWord,List).



isWord(Board,X,Y,[Head|Tail],List):-
boggleletter(Board,NewX,NewY,Head),
TargetX is X + 1,
NewY == Y,
NewX == TargetX,
NumVal is (NewX + (NewY * 10)),
notInList(List,NumVal),
list_append(NumVal,List,NList),
isWord(Board,NewX,Y,Tail,NList).

isWord(Board,X,Y,[Head|Tail],List):-
boggleletter(Board,NewX,NewY,Head),
TargetY is Y + 1,
X ==  NewX,
NewY == TargetY,
NumVal is (NewX + (NewY * 10)),
notInList(List,NumVal),
list_append(NumVal,List,NList),
isWord(Board,X,NewY,Tail,NList).

isWord(Board,X,Y,[Head|Tail],List):-
boggleletter(Board,NewX,NewY,Head),
TargetX is X - 1,
NewY == Y,
NewX == TargetX,
NumVal is (NewX + (NewY * 10)),
notInList(List,NumVal),
list_append(NumVal,List,NList),
isWord(Board,NewX,Y,Tail,NList).

isWord(Board,X,Y,[Head|Tail],List) :-
boggleletter(Board,NewX,NewY,Head),
TargetY is Y - 1,
NewX == X,
NewY == TargetY,
NumVal is (NewX + (NewY * 10)),
notInList(List,NumVal),
list_append(NumVal,List,NList),
isWord(Board,X,NewY,Tail,NList).

isWord(Board,X,Y,[Head|Tail],List) :-
boggleletter(Board,NewX,NewY,Head),
TargetX is X + 1,
TargetY is Y + 1,
NewY == TargetY,
NewX == TargetX,
NumVal is (NewX + (NewY * 10)),
notInList(List,NumVal),
list_append(NumVal,List,NList),
isWord(Board,NewX,NewY,Tail,NList).

isWord(Board,X,Y,[Head|Tail],List):-
boggleletter(Board,NewX,NewY,Head),
TargetX is X - 1,
TargetY is Y - 1,
NewX == TargetX,
NewY == TargetY,
NumVal is (NewX + (NewY * 10)),
notInList(List,NumVal),
list_append(NumVal,List,NList),
isWord(Board,NewX,NewY,Tail,NList).

isWord(Board,X,Y,[Head|Tail],List):-
boggleletter(Board,NewX,NewY,Head),
TargetX is X + 1,
TargetY is Y - 1,
NewX == TargetX,
NewY == TargetY,
NumVal is (NewX + (NewY * 10)),
notInList(List,NumVal),
list_append(NumVal,List,NList),
isWord(Board,NewX,NewY,Tail,NList).

isWord(Board,X,Y,[Head|Tail],List):-
boggleletter(Board,NewX,NewY,Head),
NewX == X - 1,
NewY == Y + 1,
NumVal is (NewX + (NewY * 10)),
notInList(List,NumVal),
list_append(NumVal,List,NList),
isWord(Board,NewX,NewY,Tail,NList).

isWord(_,_,_,[],_).

% below is only needed for Q3
%---------------------

% converttostr(?listlistchar,?liststr)
converttostr([],[]).
converttostr([X|XR],[Y|YR]) :- atom_chars(Y,X), converttostr(XR,YR).

% allbogglewords(+board,-words)

allbogglewords(B,X) :- loaddict(bogwords,D),
	findall(W,isboggleword(B,D,W),XL),
	removedup(XL,XL2), converttostr(XL2,X).

removedup(InputList,OutputList):-
	sort(InputList,OutputList).


notInList([Head|Tail],Cord):-
Cord =\= Head,
notInList(Tail,Cord).

notInList([],_).


list_member(X,[X|_]).
list_member(X,(_|Tail)):-
list_member(X,Tail).
list_append(A,T,T):- list_member(A,T),!.
list_append(A,Tail,[A|Tail]).
