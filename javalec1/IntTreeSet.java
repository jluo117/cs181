public class IntTreeSet implements IntSet {
	private int val;
	private IntTreeSet left,right;

	public IntTreeSet(int x) {
		val = x;
		left = null;
		right = null;
	}

	public boolean ismember(int x) {
		if (x==val) return true;
		if (x<val)
		    return (left!=null && left.ismember(x));
		else 
		    return (right!=null && right.ismember(x));
	}

	public void insert(int x) {
		if (x==val) return;
		if (x<val) {
			if (left!=null) left.insert(x);
			else left = new IntTreeSet(x);
		} else {
			if (right!=null) right.insert(x);
			else right = new IntTreeSet(x);
		}
	}
}
