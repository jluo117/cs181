
isPrime(2).
isPrime(TargetNum) :- prime(TargetNum - 1,TargetNum).
prime(1,_):- !.
prime(CurNum,TargetNum):-(TargetNum mod CurNum) =\= 0, C is CurNum - 1 ,prime(C,TargetNum). 