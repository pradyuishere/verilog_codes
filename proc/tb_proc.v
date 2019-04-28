module tb_proc();

  reg clk;
  reg [31:0] instr;
  wire [7:0] res;
  proc p1(clk, instr, res);

  reg [7:0] temp [0:3];

  initial begin
    clk = 0;
    $dumpfile("a.vcd");
    $dumpvars;
    temp[3] = 0; temp[2] = 3;temp[1] = 57;temp[0] = 100;
    @(posedge clk) instr <= {temp[3], temp[2], temp[1], temp[0]};
    temp[3] = 1; temp[2] = 4;temp[1] = 57;temp[0] = 100;
    @(posedge clk) instr <= {temp[3], temp[2], temp[1], temp[0]};
    temp[3] = 2; temp[2] = 5;temp[1] = 57;temp[0] = 3;
    @(posedge clk) instr <= {temp[3], temp[2], temp[1], temp[0]};
    temp[3] = 2; temp[2] = 6;temp[1] = 57;temp[0] = 4;
    @(posedge clk) instr <= {temp[3], temp[2], temp[1], temp[0]};
    #100 $finish;
  end

  always
  begin
    #5 clk = ~clk;
  end

endmodule
