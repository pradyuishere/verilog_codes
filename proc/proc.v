/*

**********Module Proc.v*************
Functions executed :
  1 - AND
  2 - ADD
  3 - FETCH

  The third operation takes in the argument last 8 bit operand in the
  instruction input to check the memory location and return the value
  found and also copies the same into the destination register as well.
*/
module proc(
  input clk,
  input [31:0] instr,
  output [8:0] res
  );
  
  //Storage array to store the computed results.
  //Each of the elements in this array are 9 bits in size in order to accomodate
  // the 8 bit sum and 1 bit carry formed by adding two 8 bit numbers
  reg [8:0] storage [7:0];

  //Control signals to control the muxes in the execute stage
  reg instr_and, instr_add, instr_fetch;

  //Data to be passed onto the execute stage along with the control signals
  reg [23:0] data_exec;
  
  //instr_decode
  //Decode the first 8 bits of the decode stage to generate the control signals
  always@(posedge clk)
  begin
    //Initialize the values to zero 
    instr_add <= 0;
    instr_and <= 0;
    instr_fetch <= 0;
    //Update only the signal corresponding to the instruction
    if(instr[31:24] == 0)
      instr_and <= 1;
    else if(instr[31:24] == 1)
      instr_add <= 1;
    else if(instr[31:24] == 2)
      instr_fetch <= 1;
    //Pass the memory location and operands from the instruction to the execute stage
    data_exec <= instr[23:0];
  end

  //Data to be written to the storage location in write_back stage
  reg [8:0] data_write;
  reg temp_carry;
  reg [7:0] temp_sum;
  //Location registers from the instr to be passed to the write_back stage
  reg [7:0] location_write;
  
  //instr_execute
  //Executes the operation based on the control signals
  always@(posedge clk)
  begin
    if(instr_add == 1)
    begin
      data_write <= data_exec[7:0] + data_exec[15:8];
    end
    else if(instr_and == 1)
    begin
      data_write <= data_exec[7:0] & data_exec [15:8];
    end
    //This operation instr_fetch fetches the data stored in the storage location requested
    else if(instr_fetch == 1)
    begin
      data_write <= storage[data_exec[7:0]];
    end

    //Pass the location to write back to the next stage
    location_write <= data_exec [23:16];
  end


  //write_back stage
  //This stage takes the result and storage location from the previous stage
  // stores them in the location requested. Also, it assigns the result to
  // res output of the module.
  always@(posedge clk)
  begin
    storage[location_write] <= data_write;
  end
  assign res = data_write;

endmodule
