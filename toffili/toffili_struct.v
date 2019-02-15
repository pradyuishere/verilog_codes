module toffili(aout, bout, cout, a, b, c);
	input a;
	input b;
	input c;
	
	output reg aout;
	output reg bout;
	output reg cout;
	
	wire ab;
	
	buf(aout, a);
	buf(bout, b);
	and(ab, a, b);
	xor(cout, ab, c)
endmodule
