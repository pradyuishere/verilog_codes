module pixl(
  input clk, rst, rx,
  output tx
  );

  reg rd1, wr1;
  reg [7:0] buf1w;
  wire tx_full1, rx_empty1;
  wire [7:0] buf1r;

  uart uart1( clk, rst, rd1, wr1, rx, buf1w,
    tx_full1, rx_empty1, tx, buf1r);

  reg [7:0] data_reg [0:8];
  integer count;
  reg [7:0] data_write [0:7];

  always@(negedge rx_empty1)
  begin
    data_reg[count] = buf1r;
    count = count + 1;
    if(count == 9)
    begin
    count = 0;
      if(data_reg[0] == 1)
      begin
        flag_write_data <= 1;
        for(iter = 0; iter<8; iter = iter+1)
        begin
          data_write[iter] <= prod[iter];
        end
      end
    end
  end

  integer counter_data_write;
  reg flag_write_data;

  always@(posedge clk)
  begin
    if(rst == 1)
    begin
      counter_data_write = 0;
      count = 0;
    end
    else if(flag_write_data == 1)
    begin
      if(counter_data_write < 8)
      begin
        buf1w = data_write[counter_data_write];
        wr1 = 1;
      end
      else
      begin
        wr1 = 0;
        flag_write_data <= 0;
      end
      counter_data_write <= counter_data_write + 1;
      if(counter_data_write == 9)
      begin
        counter_data_write <= 0;
      end
    end
  end

  reg [7:0] prod [3:0];
  reg [31:0] opA, opB;
  reg [31:0] wt1, wt2;
  reg [7:0] opcode;
  integer iter;
  reg [16:0] temp;

  always @(*) begin
    if(data_reg[0] == 0)
    begin
      wt1 = {data_reg[1], data_reg[2], data_reg[3], data_reg[4]};
      wt2 = {data_reg[5], data_reg[6], data_reg[7], data_reg[8]};
    end
    else if(data_reg[0] == 1)
    begin
      opA = {data_reg[1], data_reg[2], data_reg[3], data_reg[4]};
      opB = {data_reg[5], data_reg[6], data_reg[7], data_reg[8]};
      for(iter = 0; iter<4; iter = iter+1)
      begin
        temp = opA[iter*8+:8]*wt1[iter*8+:8] + opA[iter*8+:8]*wt1[iter*8+:8];
        prod[iter] = temp[16:9];
      end
    end
  end

endmodule
