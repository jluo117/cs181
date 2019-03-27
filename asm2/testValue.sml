datatype 'a testValue = NoneType | NewTest of 'a * 'a testValue;
fun outputTest NoneType = NONE
	|outputTest (NewTest((value:('b *'c)),testValue)) =
	if #1 value = 1 then SOME(#1 value)
	else
		SOME(#1 value)