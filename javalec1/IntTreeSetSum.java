public class IntTreeSetSum extends IntTreeSet {
	private int sum;

	public IntTreeSetSum(int x) {
		super(x);
		sum = x;
	}

	public void insert(int x) {
		if (!super.ismember(x)) sum += x;
		super.insert(x);
	}

	public int total() {
		return sum;
	}

}
