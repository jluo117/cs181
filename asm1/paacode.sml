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
fun listdictadd (mylist, x) =
    x::mylist
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
        SOME(toCompare)
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

fun encode(mylist,myStr:string, curStr:string) =
  if myStr = ""
  then
    if notinDic(curStr,mylist)
    then
      let 
        val newPair = (curStr,length(mylist))
        (*val newList = listdictadd(mylist, newPair)*)
      in
        listdictadd(mylist, newPair)
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


(* uncomment below when you've added listdictfind and listdictadd *)
 fun lz78ld l = lz78d ([],listdictfind,listdictadd) l; *)
(* uncomment below when you've added the above, plus lz78e *)
(* fun lz78le l = lz78e ([],listdictfind,listdictadd) l; *)
