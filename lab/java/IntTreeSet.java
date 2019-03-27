public class IntTreeSet{
	private int val;
	private IntTreeSet left, right;

	public IntTreeSet(int myVal){
		val = myVal;
		left = null;
		right = null;
	} 
	public boolean ismember(int x){
		if (x == val){
			return true;
		}
		if (x < val) {
			if (left != null){
				return left.ismember(x);
			}
			else{
				return false;
			}
		}
		else{
			if (right != null){
				return right.ismember(x);
			}
			else{
				return false;
			}
		}
	}
	public void insert(int x){
		if (x == val) return;
		if (x < val) {
			if (left != null) left.insert(x);
			else left = new IntTreeSet(x);
		}
		else{
			if (right != null) left.insert(x);
			else right = new IntTreeSet(x);
		}
	}
}