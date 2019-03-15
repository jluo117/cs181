// a class for coordinating the drawer and formatters to produce
// the output
import java.util.*;
public class DataDrawer {
	// a constructor, which should take (and save) the drawer to be used
	public DataDrawer(GraphDrawer drawer) {
		myDrawer = drawer;
		formatters = new LinkedList<Formatter>();
		myTable = new HashMap <Object,GraphDrawer.Node> ();
		myNodeTable = new HashSet<Object>();
	}

	// Multiple formatters might be used.  When an object is to be
	// displayed, the formatters should be queried (in reverse order 
	// from the order in which they were added) to find the first
	// one that applies to the object.
	//
	// That formatter should then be used to determine if the object
	// can be displayed "inline" as text or whether it needs its own node.
	// If it need its own node, the formatter returns the field names and
	// subobjects.
	public void addFormatter(Formatter f) {
		formatters.addFirst(f); 
	}
	private Formatter findFormatter(Formatter.GenObject myObj){
		ListIterator<Formatter> listIterator = formatters.listIterator();
		for (Formatter n : formatters) {
               if (n.applies(myObj)){
               	return n;
               }
        	}
		return null;
	}

	// This adds an object (and everything it is connected to!)
	// to the drawer's output (that is, it should be calling the methods
	// of the GraphDrawer given in the constructor)
	//
	// Note that each object (if it is isn't own node) should only
	// be added ONCE.  So, if we get to the same object in two different
	// ways, we should not regenerate  the object, but rather just point
	// to the previously created object.
	public void addObject(Object o) {
		addObjectReal(new Formatter.GenObject(o,false));
	}

	private GraphDrawer.Node addObjectReal (Formatter.GenObject myObj){
		if (myObj.obj == null){
			return null;
		}
		if (myObj == null){
			return null;
		}

		Formatter matched = findFormatter(myObj);
		
		GraphDrawer.Node dicNode =  myTable.get(myObj.obj);
		if (dicNode != null){
			return dicNode;
		}
		
		GraphDrawer.Node newNode = myDrawer.addNode(matched.className(myObj));
		//myNodeTable.add(checkNode);
		//return newNode;
		//myTable.put(myObj.obj,newNode);
		List <Formatter.NamedObject> myFieldObj = matched.getFields(myObj);
		for ( Formatter.NamedObject n : myFieldObj) {
			if (n == null){
				return null;
			}
               if (matched.preferString(n.value)){
               
               		newNode.addValueField(n.name,matched.getString(n.value));
               		//myTable.add(n.value.obj);
      
               }
               else{
            	if (!myNodeTable.contains(n.value.obj)) {
            	myNodeTable.add(n.value.obj);
               	GraphDrawer.Node realObj = addObjectReal(n.value);
 				myNodeTable.remove(n.value.obj);
               	if (realObj == null){
               		newNode.addValueField(n.name,"");
               	}
               	else{
               	newNode.addPtrField(n.name,realObj); 
               }
            	}
            	else {
            		//GraphDrawer.Node circleNode = myDrawer.addNode(n.name);
            		newNode.addPtrField(n.name,newNode);
            	}
               }
        	}
        	myTable.put(myObj.obj,newNode);
        	
        	return newNode;

	}
	private LinkedList getFields;
	private Map <Object,GraphDrawer.Node> myTable;
	//private Map <Object,GraphDrawer.Node> cycleTable;
	private Set <Object> myNodeTable;
	private GraphDrawer myDrawer;
	private LinkedList<Formatter> formatters;
  

    
	// feel free to add private methods and fields!
}
