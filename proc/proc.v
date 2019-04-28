module proc(
  input clk,
  input [31:0] instr,
  output [7:0] res
  );

  reg [7:0] storage [7:0];

  reg instr_and, instr_add, instr_fetch;
  reg [23:0] data_exec;
  //instr_decode
  always@(posedge clk)
  begin
    $display("instr : %d", instr[31:24]);
    instr_add <= 0;
    instr_and <= 0;
    instr_fetch <= 0;
    if(instr[31:24] == 0)
      instr_and <= 1;
    else if(instr[31:24] == 1)
      instr_add <= 1;
    else if(instr[31:24] == 2)
      instr_fetch <= 1;
    data_exec <= instr[23:0];
  end

  //instr_execute
  reg [7:0] data_write;
  reg [7:0] location_write;
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
    else if(instr_fetch == 1)
    begin
      data_write <= storage[data_exec[7:0]];
    end

    location_write <= data_exec [23:16];
  end

  always@(posedge clk)
  begin
    storage[location_write] <= data_write;
  end
  assign res = data_write;

endmodule
