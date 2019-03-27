public class Stack{
	private Object value;
	private Stack next;
	public Stack(){
		value = null;
		next = null;
	}
	public Stack(Object o){
		value = null;
		next = null;
	}
	public void push(Object obj){
		if (value != null){
			Stack s = new Stack(obj);
			s.next = next;
			next = s;
		}
		value = obj;
	}
	public Object pop(){
		Object ret = value;
		if (next!= null){
			value = next.value;
			next = next.next;
		}
		return ret;
	}
}