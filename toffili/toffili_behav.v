module toffili(aout, bout, cout, a, b, c);
	input a;
	input b;
	input c;
	
	output reg aout;
	output reg bout;
	output reg cout;
	
	always@ (a or b or c)
	begin
		if(a==1 && b==1)
		begin
			aout<= a;
			bout<= b;
			cout<= ~c;
		end
		else
		begin
			aout<= a;
			bout<= b;
			cout<= c;
		end
	end
	
endmodule
