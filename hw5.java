//e
void foo (){
	try{
		throw new NULLException();

	}
	catch(IntergerError){
		System.out.println("1")
	}
	finally{
		throw new IntergerError();
		System.out.println("2")
	}
}//2
//f
void foo(){
	try{
		throw new NullPointerException();
	}
	catch(None){
		System.out.println("1")
	}
	finally{
		System.out.println("return")
		return;
	}
}//return
//l
void foo(){
	try{
		throw new NullPointerException();
	}
	catch(NullPointerException){
		System.out.println("1")
	}
	finally{
		System.out.println("2")
		return
	}
}//1 2
//n
void foo(){
	try{
		throw new NullPointerException();

	}
	catch(NullPointerException){
		System.out.println("1")
		return;
	}
	finally{
		throw new IntergerError();
	}
	
}//1

//r
int foo(){
	try{
		System.out.println("1")
		return 1;
	}
	catch (Exception e){
		
	}
	finally{
		System.out.println("2")
		return 0;
	}
}//1