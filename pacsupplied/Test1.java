import java.io.*;
import java.util.*;

public class Test1 {
	static public void main(String[] args) throws IOException {
		GraphDrawer gd = new TxtDrawer("-");
		DataDrawer dds = new DataDrawer(gd);
		dds.addFormatter(new FieldFormat());
		FieldFormat testField = new FieldFormat();
		A a = new A(3);
		Formatter.GenObject newObj = new Formatter.GenObject(a,true);
		testField.getString(newObj);
		dds.addObject(a);
		A b = new A(4);
		dds.addObject(b);
		gd.draw();
	}

	static class A {
		public A(int ii) {
			i = ii;
			d = i+0.5;
		}
		public int i;
		public double d;
	}
}
