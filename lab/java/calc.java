import java.util.Scanner;
public class calc{
	public static void main(String[] args)   {
		Hashtable<String, Integer> numbers;
		boolean number = true;
		Scanner scan = new Scanner(System.in);
		int curValue = scan.nextInt();
		String op  = scan.next();
		while (scan.hasNext()){
			if (number){
				if (op.equals("+")){
					curValue += scan.nextInt();
				}
				else if (op.equals("-") ){
					curValue -= scan.nextInt();
				}
				System.out.println(curValue);
				number = false;
			}
			else{
				op = scan.next();
				number = true;
			}

		}
		// System.out.println(curValue);
    }   	
        
	
}

