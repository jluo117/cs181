
datatype 'a baltree = EmptyTree |  FullNode of 'a *  'a * 'a baltree   * 'a baltree  * 'a baltree  | SingleNode of 'a * 'a baltree * 'a baltree  ;
datatype 'a addTree = NoSplit of 'a baltree | Split of 'a * 'a baltree
fun isNode EmptyTree = false
	| isNode _ = true;

fun isSingle (FullNode(leftval,rightval,left,center,right)) = false
	| isSingle (SingleNode(rootval,left,right)) = true;

(*fun reassignLeft leftNode SingleNode(rootval,left,right,parent) = 
	SingleNode(rootval,leftNode,right,parent)
	| reassignLeft leftNode FullNode(leftval,rightval,left,center,right,parent);*)

	 
fun getLeft (SingleNode(myValue,left,right)) = left
	| getLeft (FullNode(leftval,rightval,left,center,right)) = left;
fun getRight (SingleNode(myValue,left,right)) = right
	| getRight (FullNode(leftval,rightval,left,center,right)) = right;
fun getCenter (FullNode(leftval,rightval,left,center,right)) = center;
fun getValue (SingleNode(myValue,left,right)) = myValue;
fun fullnodeBuilder (leftval,rightval,left,center,right) = 
	FullNode(leftval,rightval,left,center,right);

 fun intcmp (s1:int,s2:int) =
if s1<s2 then ~1 else if s2<s1 then 1 else 0;
 
 fun charcmp (s1:char,s2:char) =
if s1<s2 then ~1 else if s2<s1 then 1 else 0;
 fun listcmp _ ([],[]) = 0
	| listcmp _ (_,[]) = 1
	| listcmp _ ([],_) = ~1
	| listcmp cmp (a::ta,b::tb) =
	 let val c = cmp(a,b) in if c=0 then listcmp cmp (ta,tb) else c end;
fun find23 myComp  EmptyTree myValue= NONE
	| find23 myComp (SingleNode(rootval,left,right)) myValue = 
		if myComp(rootval,myValue) = 0
		then
			SOME(myValue)
		else
			if myComp (myValue, rootval) = ~1 (*myValue < rootVal*)
			then 
				find23 myComp left myValue
			else
				find23 myComp right myValue

	| find23 myComp  (FullNode(leftval,rightval,left,center,right)) myValue = 
	if myComp(leftval,myValue) = 0
	then
		SOME(myValue)

	else
		if myComp(rightval,myValue) = 0
		then
			SOME(myValue)
		else
		if myComp(myValue, leftval) = ~1
		then
			find23 myComp  left myValue
		else
			if myComp(rightval, myValue) = ~1
			then 
				find23 myComp  center myValue
			else
				find23 myComp right myValue


fun addTree myComp myValue  EmptyTree =
	SingleNode(myValue,EmptyTree,EmptyTree)
	| addTree myComp myValue  (SingleNode(rootval,left,right)) =
	if  myComp (myValue ,rootval) = ~1
	then
		if isNode left
		then
			let 
			 	val newNode = addTree myComp myValue left
			 in
			 	SingleNode(rootval,newNode,right)
			 end
		else
			FullNode(myValue,rootval,left,EmptyTree,right)
	else
		if isNode right
		then
			let 
				val newNode = addTree myComp myValue  right
			in
				SingleNode(rootval,left,newNode)
			end
		else
			FullNode(myValue,rootval,left,EmptyTree,right)
	| addTree myComp myValue  (FullNode(leftval,rightval,left,center,right))  =
	if myComp (myValue, leftval) = ~1 (*myValue < leftVal*)
	then
		let
			val newNode = addTree myComp myValue left
		in
			if  isSingle newNode 
			then
				if isNode right
				then
					if isNode center
					then
							FullNode(myValue,rightval,newNode,center,right)
					else
						FullNode(leftval,rightval,newNode,center,right)
				else
					let
						val newRight = SingleNode(rightval,EmptyTree,EmptyTree)
					in
						SingleNode(myValue,newNode,newRight)
					end
			else
					FullNode(leftval,rightval,newNode,center,right)
		end

		else
			if myComp(myValue, rightval) = ~1 (* myValue < rightval*)
			then
				let
					val newNode = addTree myComp myValue  center
				in
					if  isSingle newNode
					then
						let
							val centerLeft = getLeft newNode
							val centerRigt = getLeft newNode
							val centerVal = getValue newNode
							val newLeft = SingleNode(leftval, left,centerLeft) 
							val newRight = SingleNode(rightval,centerRigt,left)

						in
							SingleNode(centerVal,newLeft,newRight)
						end
					else
						FullNode(leftval,rightval,left,newNode,right)
				end
				
			else
				let
					val newNode = addTree myComp myValue right
				in
					if isSingle newNode
					then
						if isNode left
						then
							if  isNode center
							then
								FullNode(leftval,rightval,left,center,newNode)
							else 
								FullNode(leftval,rightval,left,center,newNode)
						else
							let
								val newLeft = SingleNode(leftval,EmptyTree,EmptyTree)
							in
								SingleNode(rightval,newLeft,newNode)
							end
					else
						FullNode(leftval,rightval,left,center,newNode)
				end;



fun addTreeDic myComp (myValue:('a * 'b))  EmptyTree =
	SingleNode(myValue,EmptyTree,EmptyTree)
	| addTreeDic myComp myValue  (SingleNode((rootval:('a * 'b)),left,right)) =
	if  myComp (#1 myValue ,#1 rootval) = ~1 (*myValue < rootval*)
	then
		if isNode left
		then
			let 
			 	val newNode = addTreeDic myComp myValue left
			 in
			 	SingleNode(rootval,newNode,right)
			 end
		else
			FullNode(myValue,rootval,left,EmptyTree,right)
	else
		if isNode right
		then
			let 
				val newNode = addTreeDic myComp myValue  right
			in
				SingleNode(rootval,left,newNode)
			end
		else
			FullNode(myValue,rootval,left,EmptyTree,right)
	| addTreeDic myComp (myValue:('a * 'b)) (FullNode((leftval: ('a* 'b)) ,(rightval: ('a * 'b)) ,left,center,right))   =
	if myComp (#1 myValue, #1 leftval) = ~1 (*myValue < leftval*)
	then
		let
			val newNode = addTreeDic myComp myValue left
		in
			if  isSingle newNode 
			then
				if isNode right
				then
					if isNode center
					then
							FullNode(myValue,rightval,newNode,center,right)
					else
						FullNode(leftval,rightval,newNode,center,right)
				else
					let
						val newRight = SingleNode(rightval,EmptyTree,EmptyTree)
					in
						SingleNode(myValue,newNode,newRight)
					end
			else
					FullNode(leftval,rightval,newNode,center,right)
		end

		else
			if myComp(#1 myValue, #1 rightval) = ~1 (*myValue < rightVal*)
			then
				let
					val newNode = addTreeDic myComp myValue  center
				in
					if  isSingle newNode
					then
						let
							val centerLeft = getLeft newNode
							val centerRigt = getLeft newNode
							val centerVal = getValue newNode
							val newLeft = SingleNode(leftval, left,centerLeft) 
							val newRight = SingleNode(rightval,centerRigt,left)

						in
							SingleNode(centerVal,newLeft,newRight)
						end
					else
						FullNode(leftval,rightval,left,newNode,right)
				end
				
			else
				let
					val newNode = addTreeDic myComp myValue right
				in
					if isSingle newNode
					then
						if isNode left
						then
							if  isNode center
							then
								FullNode(leftval,rightval,left,center,newNode)
							else 
								FullNode(leftval,rightval,left,center,newNode)
						else
							let
								val newLeft = SingleNode(leftval,EmptyTree,EmptyTree)
							in
								SingleNode(rightval,newLeft,newNode)
							end
					else
						FullNode(leftval,rightval,left,center,newNode)
				end;


fun insert23  myComp EmptyTree myValue = 
	SingleNode(myValue,EmptyTree,EmptyTree)
	|
	insert23 myComp myTree myValue =  addTree myComp myValue myTree;
fun treedictfind myComp EmptyTree myValue  =  NONE
	| treedictfind myComp (SingleNode((rootval: ('b * 'c)), left,right)) myValue = 
	if  myComp(#1 rootval,myValue) = 0
	then
		SOME(#2 rootval) 
	else
		if myComp(myValue, #1 rootval) = ~1 
		then
			treedictfind myComp left myValue
		else
			treedictfind myComp right myValue
	| treedictfind myComp (FullNode((leftval: ('b* 'c)) ,(rightval: ('b * 'c)) ,left,center,right)) myValue =
	if myComp(#1 leftval, myValue) = 0
	then
		SOME(#2 leftval)
	else
		if myComp(myValue ,#1 rightval) = 0
		then
			SOME(#2 rightval)
		else
			if myComp(myValue , #1 leftval) = ~1
			then
				treedictfind myComp left myValue
			else
				if myComp(#1 rightval, myValue) = 1
				then
					treedictfind myComp center myValue
				else
					treedictfind myComp right myValue;



fun treedictadd myComp EmptyTree (myValue: ('a * 'b)) = 
	SingleNode(myValue,EmptyTree,EmptyTree)
	| treedictadd myComp myTree (myValue: ('a * 'b)) = 
	addTreeDic myComp myValue myTree

fun lz78te cmp l = lz78e (EmptyTree,(treedictfind cmp),(treedictadd cmp)) l;
fun lz78td cmp l = lz78d (EmptyTree,(treedictfind cmp),(treedictadd cmp)) l;