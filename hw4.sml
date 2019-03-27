fun comb (f,g,c,d) = 
	let 
		fun cl(x,y) = f(x) + g(y)
		fun call (nil, _) = 0
			|call (_, nil) = 0
			|call ((x :: xs),(y::ys)) = cl(x,y) + call(xs,ys)
		in
			call(c,d)
		end;
fun poly coeff =
	let 
		fun eval (x,nil) = 0
			|eval (x,(c0::cs)) = c0 + x * eval(x,cs)
			fun evalx x = eval(x,coeff)
			
		in 
			evalx
		end;
val it = comb((poly[0,0,2]) , (poly[2,1]) , [0,1,2] , [3,4,5]);
val test = poly[2,1];
test(5);
test(3);
test(1);