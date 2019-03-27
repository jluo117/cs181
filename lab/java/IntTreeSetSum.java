public class IntTreeSetSum extends IntTreeSet{
	private int sum;
	public IntTreeSetSum(int x){
		super(x);
		sum = x;
	}
	public int total(){
		return sum;
	}
}
