import java.util.*;
import java.lang.reflect.*;
import java.io.*;
public class ArrayFormat implements Formatter{
	public ArrayFormat (){

	}
	public boolean applies(GenObject info){
		Class infoClass = info.obj.getClass();
		return (infoClass.isArray());
	}
	public boolean preferString(GenObject info){
		return (info.isprim);
	}
	public String getString(GenObject info){
		return info.obj.toString();

	}
	public String className(GenObject info){
		Class cls = info.obj.getClass().getComponentType();
		return cls.getName() + "[]";
	}
	public List<NamedObject> getFields(GenObject info){
		List myList = new LinkedList<NamedObject>();
		for (int i = 0; i < Array.getLength(info.obj); i++){
			
			Object aryObj = Array.get(info.obj,i);
			if (aryObj == null) {
				continue;
			}
			GenObject newGen = new GenObject(aryObj,aryObj.getClass());
			String myClassName = "[" + Integer.toString(i) + "]";
			NamedObject newObj = new NamedObject(myClassName,newGen);
			myList.add(newObj);
			//myList.addAll(this.superList(aryObj.getClass().getSuperclass(),newGen));
			// try{
			// 	Class cls = aryObj.getClass();
			// 	Field[] fields = cls.getDeclaredFields();
			// 	Class superClass = aryObj.getClass().getSuperclass();
			// 	myList.addAll(superList(superClass,newGen));
			// 	for (int j=0; j < fields.length; j++ ){
			// 		fields[j].setAccessible(true);
			// 		NamedObject newObj = new NamedObject(fields[j].getName(),fields[j].get(aryObj),fields[j].getType());
			// 		myList.add(newObj);
			// 	}
			// }
			// catch (Exception e){

			// }

		}
		//System.out.println(myList.size());
		return myList;
	}
	private List<NamedObject> superList(Class myClass, GenObject info){
		List myList = new LinkedList <NamedObject>();
		if (myClass.isPrimitive()){
				return myList;
			}
			try{
			Class superClass = myClass.getSuperclass();
			myList = superList(superClass,info);
			Class cls = myClass;
			Field[] fields = cls.getDeclaredFields();
			for (int i = 0; i < fields.length; i++){
				fields[i].setAccessible(true);
				NamedObject newObj = new NamedObject(fields[i].getName(),fields[i].get(info.obj) , fields[i].getType());
				myList.add(newObj);

				}

			}
			catch (Exception e){

			}
			return myList;

	} 



private List<NamedObject> combineList(List<NamedObject> listA, List<NamedObject> listB){
	for(NamedObject n : listB ){
		listA.add(n);
	}
	return listA;
}
}