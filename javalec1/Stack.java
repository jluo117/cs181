public class Stack<E> {
	private E value;
	private Stack<E> next;

	public Stack() {
		value=null;
		next=null;
	}
	public Stack(E o) {
		value=o;
		next=null;
	}

	public void push(E obj) {
		if (value!=null) {
			Stack<E> s = new Stack<E>(value);
			s.next = next;
			next = s;
		}
		value = obj;
	}

	public E pop() {
		E ret = value;
		if (next!=null) {
			value = next.value;
			next = next.next;
		} else { value = null; }
		return ret;
	}
}



