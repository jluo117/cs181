fun evalpoly [] _ = 0
	| evalpoly (c::cs) x = c + x* (evalpoly cs x);
fun evalpoly2 coeffs x =
	let 
		fun accsumandpow (coeffs,(currentsum,currentpow)) =
			(currentsum + coeffs*currentpow,currentpow * x)
		val (sum,pow) = foldl accsumandpow(0,1) coeffs
in 
	sum 
end
datatype color = red| green | blue
fun isred x=  (x=red);
datatype number = whole of int | decimal of real | NaN;
whole 2;

fun num2str ( whole x ) = Int.toString x
	| num2str( decimal x ) = Real.toString x
	| num2str(NaN) = "Not a number";
datatype  intlist =
	EmptyIntList
	|IntCons of int * intlist 
;
datatype inttrees = 
	EmptyTree
	| Node of int*inttrees*inttrees;
val it = Node (2 , EmptyTree,EmptyTree);
fun addtoTree EmptyTree v = Node(v,EmptyTree,EmptyTree)
	| addtoTree (Node(rootval,left,right)) v = 
		if v<rootval then Node (rootval, (addtoTree left v) , right)
		else Node(rootval, left ,(addtoTree right v))
datatype 'a tree =
	EmptyTree   
	|Node  of 'a * 'a tree; 
(*fun addtotree cmp EmptyTree v= Node(v,EmptyTree,EmptyTree)
	|addtotree cmp (Node(rootval,left,right)) v =
	if cmp (v,rootval) then Node(rootval, (addtotree cmp left v),right)
	else Node(rootval,left,(addtotree cmp right v));
*)(*Falten*)
fun printtree _ EmptyTree = ""
	| printtree stem(Node(v,left,right)) =
	let
		val newsteam = stem ^ " "
		val _ = printtree newsteam left
		val _ = print(stem & (Int.toString v) ^ "\n")
	in
		printtree newsteam right
	end

