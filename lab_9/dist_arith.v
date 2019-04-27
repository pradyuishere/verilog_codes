module multiplier(
  input x,
  input y,
  input u,
  input v,
  output sum,
  output carry
  );

  assign {carry, sum} = x*y + u + v;

endmodule

module nbit_input #(parameter N = 8) (
  input [N-1:0] x,
  input b,
  input [N-1:0] u,
  input d,
  output [N-1:0] sum,
  output carry
  );

  wire carrys [N:0];
  assign carrys[0] = d;


  genvar i;
  for(i = 0; i<N; i = i+1)
  begin
    multiplier i_multipliter(x[i], b, u[i], carrys[i], sum[i], carrys[i+1]);
  end

  assign carry = carrys[N];

endmodule
