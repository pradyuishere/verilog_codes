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

module nm_bit_multiplier #(parameter N = 8, parameter M = 8) (
  input [N-1:0] x,
  input [M-1:0] y,
  input [N-1:0] u,
  input [M-1:0] d,
  output [N+M-2:0] sum,
  output carry
  );

  wire [N-1:0] sums [M:0];
  wire carrys[M:0];

  assign {carrys[0], sums[0][N-1:1]} = u;

  genvar i;
  for(i = 0; i < M; i = i + 1)
  begin
    nbit_input i_nbit_input(x, y[i], {carrys[i], sums[i][N-1:1]}, d[i], sums[i+1], carrys[i+1]);
  end

  for(i = 0; i < M-1; i = i + 1)
  begin
    assign sum[i] = sums[i+1][0];
  end

  assign sum[M+N-2:M-1] = sums[M];
  assign carry = carrys[M];

endmodule
