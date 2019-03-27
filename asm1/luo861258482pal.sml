(* rename this file <lastname>-<studentID>-pa1.sml before
* submitting
*)

(* add the functions
*
* listdictfind
* listdictadd
* lz78e
*
* as specified in the assignment
*)

(* LZ78 decompression algorithm *)
fun listdictadd mylist  =
  fn x: (''a * 'b) =>
      mylist @[x]
  ;

fun listdictfind (l : (''a * 'b) list) =
  if (null l) then
    (fn (k : ''a) =>
      (NONE: 'b option))
  else (fn (k : ''a) =>
    if k = (#1 (hd l)) then
      (SOME (#2 (hd l)): 'b option)
    else
      listdictfind (tl l) k);




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


fun lz78d (emptybook,inbook,addbook) l = 
let

  (* decode takes a codebook, a list of pairs, and the next index *)
  fun decode _ nil _ = nil 
    | decode dict ((ind,h)::t) c =
    (* ind is the index of the codeword and h is the value to add at the end *)
    (* c is the index of the next code word *)
    let
      val str = if ind=0 then [] else
               case inbook dict ind of
                    NONE => [] (* this should never happen! *)
                  | SOME s => s
      val cword = h::str
    in
      foldl op::  (* cons together... *)
          (decode (addbook dict (c,cword)) t (c+1))
			(* ... the decoding of
			the rest of the input, with a dictionary
			with an extra entry ... *)
          cword  (* ... with the new code word (as the "seed") *)
    end
in
   decode emptybook l 1
end; 
lz78le(explode "hihihiyahiyahiya!") ;
lz78le(explode "aababbaba") ;

(* uncomment below when you've added listdictfind and listdictadd *)
(* fun lz78ld l = lz78d ([],listdictfind,listdictadd) l; *)
(* uncomment below when you've added the above, plus lz78e *)
(* fun lz78le l = lz78e ([],listdictfind,listdictadd) l; *)
