fun min (a,b) = 
	if a < b then a
	else
		b;
datatype 'a heap = 
	EmptyHeap 
	| Max of 'a * 'a heap * 'a heap;
fun minHeight EmptyHeap = 0
	| minHeight heap(_,left,right) = 1 + min (minHeight left , minHeight right);
