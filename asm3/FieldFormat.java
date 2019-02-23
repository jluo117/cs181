import java.util.*;
import java.lang.reflect.*;
import java.io.*;
 public class FieldFormat implements Formatter{
 		public FieldFormat (){

 		}
		public boolean applies(GenObject info){
			Class infoClass = info.obj.getClass();
			return (!infoClass.isArray());
		}
		public boolean preferString(GenObject info){
			//System.out.println(info.isprim);
			return (info.isprim);
		}
		public String getString(GenObject info){
			return info.obj.toString();
		}
		public String className(GenObject info){
			Class cls = info.obj.getClass();
			return cls.getName();
		}
		public List<NamedObject> getFields(GenObject info){
			LinkedList myList = new LinkedList<NamedObject>();
			try {
				Class cls = info.obj.getClass();
				Field[] fields = cls.getDeclaredFields();
				Class superClass = info.obj.getClass().getSuperclass();	
				myList = superList(superClass,info);
         		for(int i = 0; i < fields.length; i++) {
         			fields[i].setAccessible(true);
         			NamedObject newObj = new NamedObject(fields[i].getName(),fields[i].get(info.obj),fields[i].getType());
         			myList.add(newObj);
 
         			}


         			// catch (Exception e){

         			// }
         		} 
         		catch(Exception e){
				//System.out.println(e);

				}
         		

			
			

			return myList;
		}
		private LinkedList<NamedObject> superList(Class myClass, GenObject info){
			LinkedList myList = new LinkedList<NamedObject>();
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


}
