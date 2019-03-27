import java.io.*;
import java.util.*;
public class TxtDrawer implements GraphDrawer {

	public class TxtNode implements GraphDrawer.Node {
		public LinkedList<VaribleNode> value;
		public LinkedList<NextList> nodeValue;
		public String name;
		public TxtNode(String name,int count){
			this.name = name;
			//next = null;
			value =  new LinkedList<VaribleNode>();
			nodeValue = new LinkedList<NextList>();
			this.count = count;
		}
		// a constructor here...
		public void addValueField(String name, String value) {
			VaribleNode newNode = new VaribleNode(name,value);
			this.value.add(newNode);
			// code here
		}

		public void addPtrField(String name, Node tonode) {
			NextList newNodes = new NextList(name,tonode);
			nodeValue.add(newNodes);
			// code here
			// tonode will be a TxtNode, but you'll have to cast it
		}
		
		//public Node next;
		public int count;
		public String nextNodeValue( Node next) {
			int target = findNode(next);
			String nodeCast = Integer.toString(target);
			return ("-> node " + nodeCast);
		}
		
		// fields and other methods here
	}
	

	public TxtDrawer(String filename) {
		// save filename and open it later (see below)
		fn = filename;
		myList = new LinkedList<TxtNode>();

		// other initialization here...
	}


	public Node addNode(String name) {
		
		TxtNode newNode = new TxtNode(name,myList.size());
		myList.add(newNode);
		return newNode;
		// your continueode here (should return a TxtNode)
	}
	public int findNode(Node targetNode) {
		int count = 0;
		for (Node n: myList) {
			if (n == targetNode) {
				return count;
			}
			count += 1;
		}
		return -1;
	}
	public void draw() {
		PrintWriter out;
		if (fn!="-") {
			try {
				out = new PrintWriter(new FileWriter(fn));
			} catch (IOException ioe) {
				System.out.println("could not open "+fn+" for writing");
				return;
			}
		} else {
			out = new PrintWriter(System.out);
		}
		for ( TxtNode n : myList) {
			System.out.println("node: " + n.count + " " + n.name);
			for (VaribleNode str: n.value) {
				System.out.println("	" + str.name + ": " + str.value);
			}
			for (NextList nodes : n.nodeValue) {
				System.out.println("	" + nodes.name+": " + n.nextNodeValue(nodes.nextNode));
			}
			
			
		}
		
		
		// now use out.println(...) and similar...
		// your code here...
		out.close();
	}
	

//-----------------------------
	private String fn;
	private String value;
	private LinkedList<TxtNode> myList;
	public class VaribleNode{
		public VaribleNode(String name,String value) {
			this.name = name;
			this.value = value;
		}
		public String name;
		public String value;
		
	}
	public class NextList{
		public NextList(String name, Node nextNode) {
			this.name = name;
			this.nextNode = nextNode;
		}
		public String name;
		public Node nextNode;
	}
	// your private fields and methods...
}
