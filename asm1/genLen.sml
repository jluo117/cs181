fun listdictadd mylist  =
	fn x: (''a * 'b) =>
    	mylist @[x]
  ;
(*fun first a =
	#1 a;
fun second a = 
	#2 a;*)

fun listdictfind (l : (''a * 'b) list) =
  if (null l) then
    (fn (k : ''a) =>
      (NONE: 'b option))
  else (fn (k : ''a) =>
    if k = (#1 (hd l)) then
      (SOME (#2 (hd l)): 'b option)
    else
      listdictfind (tl l) k);
(*fun listdictfind key  mylist = 
	if null(mylist) 
	then NONE
	else
		let 
			val toCompare = hd(mylist)
		in 
			if  #1 toCompare = key
			then
				SOME(#2 toCompare)
			else
				listdictfind key tl(mylist)
			end
;*)
	

(*fun buildFinalList (mylist: (string * int) list,masterList,curList) =
	if null(mylist)
	then
		curList
	else
		if length(explode #1(hd mylist)) = 1
		then
			let
				val newPair = (hd (explode #1 (hd mylist)) , 0)
				val newList = listdictadd mylist newPair
			in 
				buildFinalList(tl(mylist), masterList,newList)
			end
		else
			let
				val firstChar = implode[hd(explode #1 (hd mylist))]
				val myIndex = listdictfind(masterList,firstChar)
				val newPair = (firstChar,myIndex)
				val newList = listdictadd mylist newPair
			in
				buildFinalList(tl(mylist),masterList,newList)
			end
			;*)

fun notinDic(x,mylist: (''a * 'b)list) =
	if null(mylist) 
	then
		true
	else
		let 
			val toCompare = hd(mylist)
		in 
			if  #1 toCompare = x
			then
				false
			else
				notinDic(x,tl(mylist))
			end
;

fun findIndex (x,mylist: (string*int)list,curNum)=
	let
		val myHead = hd(mylist)
	in
		if #1 myHead = x
	
		then
			curNum
		else
			findIndex(x , tl(mylist), curNum + 1)
		end;

fun tailOfStr(alphaList : char list) =
	let
		val newList = tl(alphaList)
	in
		if null(newList)
		then
			hd alphaList
			else
				tailOfStr(newList)
	end
fun notinSet (curChar,mySet) =
	if null(mySet)
	then
		true
	else
		if hd(mySet) = curChar
		then
			false
		else
			notinSet(curChar,(tl mySet));

fun popLast(output,curStr) =
	if length(curStr) = 1
	then 
		output
	else
		let
			val newOutPut = output ^ implode[hd curStr]
		in
			popLast(newOutPut, tl(curStr))
		end;
fun updateOutputList(mylist, curStr: string, output) =
	if length (explode curStr) = 1
	then
		let
			val newPair = (0,hd (explode curStr))
		in
			listdictadd output newPair
		end
		else
		let 
			val targetChar = tailOfStr(explode curStr)
			val mySet = []
			val outputStr = ""
			val strPattern = popLast(outputStr,explode curStr)
			val count = 0
			val outputNum =  findIndex(strPattern,mylist,count) + 1
			val newPair = (outputNum,targetChar)
		in
			listdictadd output newPair
		end
			;

fun encode(mylist,myStr:string, curStr:string,output) =
	if myStr = ""
	then
		if notinDic(curStr,mylist)
		then			
			updateOutputList(mylist,curStr,output)

			else
			output
	else 
		if notinDic(curStr,mylist)
		then
			let 
				val newPair = (curStr,length(mylist))
				val newList = listdictadd mylist newPair
				val newOutPut = updateOutputList(mylist,curStr,output)
			in 
				encode(newList,implode(tl (explode myStr)),implode[(hd (explode myStr))],newOutPut)
			end
		else
			encode(mylist, implode (tl (explode myStr)), curStr ^  implode [(hd (explode myStr))],output);

(*fun encode(mylist,myStr:string, curStr:string,output) =
	if myStr = ""
	then
		if notinDic(curStr,mylist)
		then
			updateOutputList(mylist,curStr,output)
			else
			output
	else 
		if notinDic(curStr,mylist)
		let
			val newOutPut = updateOutputList(mylist,curStr,output)
			val newPair = (curStr,length(mylist))
			val newList = listdictadd mylist newPair
		in
			encode(newList,implode (tl (explode myStr)), implode [(hd (explode myStr))], newOutPut)
		end
		else
			encode(mylist, implode (tl (explode myStr)), curStr ^  implode [(hd (explode myStr))], output);
*)
fun lz78le(myStr)=
	if null(myStr)
	then []
	else
		let 
			val output  = []
		in
	 	encode([],implode ( tl( myStr)),implode [(hd ( myStr))],output)
	 end
		;

lz78le(explode "hihihiyahiyahiya!") ;