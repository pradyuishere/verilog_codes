// module tb_dist_arith();
//
//   reg [7:0] x, u;
//   wire [7:0] sum;
//   wire carry;
//   reg b, d;
//
//   nbit_input n1 (x, b, u, d, sum, carry);
//
//   initial begin
//   #10;
//     $monitor("x : %d, b : %d, u : %d, d : %d\nsum : %d, carry : %d", x, b, u, d, sum, carry);
//     x = 100;
//     b = 1;
//     u = 20;
//     d = 1;
//     #100 $finish;
//   end
//
// endmodule

module tb_nm_bit_multiplier();

  reg [7:0] x, u;
  wire [14:0] sum;
  wire carry;
  reg [7:0] b, d;

  nm_bit_multiplier nm1 (x, b, u, d, sum, carry);

  initial begin
  $dumpfile("wave_dist.vcd");
  $dumpvars;
  #10;
    $monitor("x : %d, b : %d, u : %d, d : %d\nsum : %d, carry : %d", x, b, u, d, sum, carry);
    x = 100;
    b = 40;
    u = 60;
    d = 120;
    #100 $finish;
  end

endmodule
