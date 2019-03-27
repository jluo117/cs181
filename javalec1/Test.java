class Test {
	public static void main(String[] args) {
		Stack<String> s = new Stack<String>();
		s.push("hello");
		String x = s.pop();
		System.out.println(x);


		String[] aos = new String[4];
		aos[0] = "hello";
		aos[1] = "goodbye";
		aos[2] = "yes";
		aos[3] = "no";

		for(String b : aos)
			System.out.println(b);
	}
}
