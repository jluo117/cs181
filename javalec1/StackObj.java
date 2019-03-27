public class StackObj {
	private Object value;
	private StackObj next;

	public StackObj() {
		value=null;
		next=null;
	}
	public StackObj(Object o) {
		value=o;
		next=null;
	}

	public void push(Object obj) {
		if (value!=null) {
			StackObj s = new StackObj(value);
			s.next = next;
			next = s;
		}
		value = obj;
	}

	public Object pop() {
		Object ret = value;
		if (next!=null) {
			value = next.value;
			next = next.next;
		} else { value = null; }
		return ret;
	}
}



