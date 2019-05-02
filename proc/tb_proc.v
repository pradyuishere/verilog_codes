module tb_proc();
  //Variable declaration
  reg clk;
  reg [31:0] instr;

  //****Please note that the result is of size 9 bits in order to accomodate the carry bit*****
  wire [8:0] res;
  //proc module instantiation
  proc p1(clk, instr, res);

  reg [7:0] temp [0:3]; //An array of 4 elements which together constitute the 32 bit instr

  initial begin
    clk = 0;
    //Dump the values of all the variables into the dumpfile
    $dumpfile("a.vcd");
    $dumpvars;
    /*For the following instructions,
    	temp[3] = opcode;
    	temp[2] = data_destination;
    	temp[1] = operand_1;
    	temp[0] = operand_2;
    */ 
    //Instr_1
    //Instr to "and" the operands
    temp[3] = 0; temp[2] = 3;temp[1] = 57;temp[0] = 100;
    @(posedge clk) instr <= {temp[3], temp[2], temp[1], temp[0]};
    //Instr_2
    //Instr to "add" the operands
    temp[3] = 1; temp[2] = 4;temp[1] = 255;temp[0] = 255;
    @(posedge clk) instr <= {temp[3], temp[2], temp[1], temp[0]};
    //Instr_3
    //Instr to display the data in the memory location temp[0]
    temp[3] = 2; temp[2] = 5;temp[1] = 57;temp[0] = 3;
    @(posedge clk) instr <= {temp[3], temp[2], temp[1], temp[0]};
    //Instr_4
    //Instr to display the data in the memory location temp[0]
    temp[3] = 2; temp[2] = 6;temp[1] = 57;temp[0] = 4;
    @(posedge clk) instr <= {temp[3], temp[2], temp[1], temp[0]};
    //Finish the execution after 100 clock units
    #100 $finish;
  end

  always
  begin
  	//Alternate the clock after every 5 clock units, effective clock delay is 10 units
    #5 clk = ~clk;
  end

endmodule
