datatype 'a stack = 
	EmptyStack  
	| NotEmpty of 'a list;

fun push x EmptyStack = NotEmpty [x]
	| push x (NotEmpty myStack) = NotEmpty([x] @ myStack);

fun pop  EmptyStack = EmptyStack
	| pop (NotEmpty myStack) = 
	if length(myStack) = 1
	then
		EmptyStack
	else
		NotEmpty(tl(myStack));
		

val myStack = EmptyStack;
val notEmpty = push 5 myStack;
pop myStack;
datatype intlist = EmptyIntList | IntCons of int*intlist;

val longintlist = IntCons(1,IntCons(5,IntCons(0,IntCons(~1,EmptyIntList))));


fun min (a,b) = 
	if a < b then a
	else
		b;
datatype 'a heap = 
	EmptyHeap 
	| Max of 'a * 'a heap * 'a heap;
fun minHeight EmptyHeap = 0
	| minHeight heap(_,left,right) = 1 + min (minHeight left , minHeight right);
