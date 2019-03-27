fun min (a,b) = 
	if a < b then a
	else
		b;
datatype 'a heap = 
	EmptyHeap 
	| Max of 'a * 'a heap * 'a heap;
fun getValue (Max(returnValue,_,_)) = returnValue;

fun replaceValue newValue (Max(_,left,right)) =
	Max(newValue,left,right)
un minHeight EmptyHeap = 0
	| minHeight (Max(_,left,right)) = 1 + min (minHeight left , minHeight right);
fun insert value EmptyHeap = 
	Max(value, EmptyHeap,EmptyHeap)
	|insert value (Max(rootValue,left,right)) = 
	let
		val leftHeight = minHeight left
		val rightHeight = minHeight right
	in
		if leftHeight < rightHeight 
		then
			let
				val newNode = insert value left
			in
				if getValue(newNode) > rootValue
				then
					let
						val newLeft = replaceValue value newNode
					in
						Max(rootValue,newLeft,right)
					end
				else
					Max(rootValue,newNode,right)
			end
		else
			let
				val newNode = insert value right
			in
				body
			end
	end
