%split/3 split(A,B,C) succeeds if B are the even-indexed elements of A
%  and C are the odd-indexed elements of A
split([],[],[]).
split([X],[X],[]).
split([X,Y|T],[X|EvenT],[Y|OddT]) :- split(T,EvenT,OddT).

%xmerge/3 xmerge(+A,+B,-C) assumes A and B are in sorted order
%   succeeds if C all elements of A and B together, in sorted order
xmerge([],[],[]).
xmerge(X,[],X).
xmerge([],X,X).
xmerge([X|XT],[Y|YT],[X|T]) :- X=<Y, xmerge(XT,[Y|YT],T). 
xmerge([X|XT],[Y|YT],[Y|T]) :- X>Y, xmerge([X|XT],YT,T). 
