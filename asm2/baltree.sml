
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

fun find23 myValue EmptyTree = NONE
	| find23 myValue (SingleNode(rootval,left,right)) = 
		if rootval = myValue
		then
			SOME(SingleNode(rootval,left,right))
		else
			if rootval > myValue
			then 
				find23 myValue left
			else
				find23 myValue right

	| find23 myValue (FullNode(leftval,rightval,left,center,right)) = 
	if leftval = myValue
	then
		SOME(FullNode(leftval,rightval,left,center,right))

	else
		if rightval = myValue
		then
			SOME(FullNode(leftval,rightval,left,center,right))
		else
		if leftval > myValue
		then
			find23 myValue left
		else
			if rightval > myValue
			then 
				find23 myValue center
			else
				find23 myValue right


fun addTree myValue  EmptyTree =
	SingleNode(myValue,EmptyTree,EmptyTree)
	| addTree myValue  (SingleNode(rootval,left,right)) =
	if  myValue < rootval
	then
		if isNode left
		then
			let 
			 	val newNode = addTree myValue left
			 in
			 	SingleNode(rootval,newNode,right)
			 end
		else
			FullNode(myValue,rootval,left,EmptyTree,right)
	else
		if isNode right
		then
			let 
				val newNode = addTree myValue  right
			in
				SingleNode(rootval,left,newNode)
			end
		else
			FullNode(myValue,rootval,left,EmptyTree,right)
	| addTree myValue  (FullNode(leftval,rightval,left,center,right))  =
	if leftval > myValue
	then
		let
			val newNode = addTree myValue left
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
			if rightval < myValue
			then
				let
					val newNode = addTree myValue  center
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
					val newNode = addTree myValue right
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






fun insert23 myValue EmptyTree = 
	SingleNode(myValue,EmptyTree,EmptyTree)
	|
	insert23 myValue myTree = addTree myValue myTree 

(*fun add23 myValue EmptyTree = *)
	