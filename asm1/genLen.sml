fun listdictadd (mylist, x: (''a * 'b)) =
    mylist @[x]
  ;

fun listdictfind(x,mylist: (''a * 'b)list) =
	if null(mylist) 
	then
		NONE
	else
		let 
			val toCompare = hd(mylist)
		in 
			if  #1 toCompare = x
			then
				SOME(#2 toCompare)
			else
				listdictfind(x,tl(mylist))
			end
;


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
fun findIndex (x,mylist,curNum)=
	if hd(mylist) = x
	
	then
		curNum
	else
		findIndex(x , tl(mylist), curNum + 1)

fun encode(mylist,myStr:string, curStr:string) =
	if myStr = ""
	then
		if notinDic(curStr,mylist)
		then
			let 
				val newPair = (curStr,length(mylist))
				(*val newList = listdictadd(mylist, newPair)*)
			in				
				listdictadd(mylist,newPair)
			end
			else

			mylist
	else 
		if notinDic(curStr,mylist)
		then
			let 
				val newPair = (curStr,length(mylist))
				val newList = listdictadd(mylist, newPair)
			in 
				encode(newList,implode(tl (explode myStr)),implode[(hd (explode myStr))])
			end
		else
			encode(mylist, implode (tl (explode myStr)), curStr ^  implode [(hd (explode myStr))]);
fun lz78e(mylist, myStr)=
	if myStr = ""
	then mylist
	else
		encode(mylist,implode (tl (explode myStr)),implode [(hd (explode myStr))])
		;


fun popStr(strList,sizeToPop) = 
	if sizeToPop = 0
	then
		strList
	else
		popStr(implode(tl(explode(strList))), sizeToPop - 1);