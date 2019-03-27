class Test1 {
	public static void main(String[] args) {
		IntSet a = new IntTreeSetSum(1);
		a.insert(2);
		a.insert(-1);
		System.out.println(a.ismember(0));
		System.out.println(a.ismember(2));
		System.out.println(a.ismember(-2));
		System.out.println(a.ismember(-1));
		System.out.println(((IntTreeSetSum)a).total());
	}
}
