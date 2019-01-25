fun listdictadd (mylist, x) =
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
				SOME(toCompare)
			else
				listdictfind(x,tl(mylist))
			end
;


fun inDic(x,mylist: (''a * 'b)list) =
	if null(mylist) 
	then
		false
	else
		let 
			val toCompare = hd(mylist)
		in 
			if  #1 toCompare = x
			then
				true
			else
				inDic(x,tl(mylist))
			end
;

fun strNotinDic(mylist,strList:string,curStr:string) = 
	if strList = ""
	then
		if inDic(curStr,mylist)
		then
			SOME(curStr)
		else
			NONE
	else
		if inDic(curStr,mylist)
		then
			SOME(curStr)
		else
		strNotinDic(mylist,implode(tl(explode(strList))), implode((explode curStr) @ [hd (explode(strList))]));


fun popStr(strList,sizeToPop) = 
	if sizeToPop = 0
	then
		strList
	else
		popStr(implode(tl(explode(strList))), sizeToPop - 1);

fun encode(mylist,myStr, curStr)
	if myStr = ""
	then
		mylist
	else 
		if ~inDic(mylist,curStr)
		then
			let 
				val newList = listdictadd(mylist,(curStr,length(mylist)))
			in 
				encode(newList,implode(tl (explode myStr)),implode(hd (explode myStr)))
			end
		else
			encode(newList, implode (tl (explode myStr)), curStr ^ implode (hd (explode myStr)));
fun lz78e(mylist: (''a*'b) list, myStr)=
	if myStr = ""
	then
		mylist
	else
		let 
			val explodedString = explode (myStr)
			
		in
			if ~inDic(implode(hd(explodedString)), mylist)
			then
				let 
					val newIndexItem = (implode(hd(explodedString)),length(mylist) + 1)
				in
					print (implode(hd(myStr)  ^ (Int.toString(0))  ^ "\n")) 
					mylist = listdictadd(mylist,newIndexItem)
					lz78e(mylist,implode(tl(explodedString)))
				end

			else
				let 
					val notinDictionary = strNotinDic(mylist,myStr,implode(hd(explodedString)))
					val myIndexValue = listdictfind(mylist,implode(hd(explodedString)))
					val newIndexItem = (notinDictionary,length(mylist) + 1)
				in 
					print( implode(hd(explodedString)) ^ myIndexValue ^ "\n")
					mylist = listdictadd(mylist,newIndexItem)
					myStr = popStr(myStr, length(explode (notinDictionary)))
					lz78e(mylist,implode(tl(explodedString)))
				end
			end
;