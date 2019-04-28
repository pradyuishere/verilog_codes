module tb_pixl();
reg clk, reset;
reg rd1, rd2, wr1, wr2;
reg [7:0] buf1w, buf2w;
wire [7:0] buf1r, buf2r;
wire rx, tx;
wire tx_full1, rx_empty1, tx_full2, rx_empty2;

localparam c_CLOCK_PERIOD_NS=20;
initial begin clk=0; reset=0; forever #c_CLOCK_PERIOD_NS clk=~clk; end

uart uart1 (.clk(clk), .reset(reset), .rd_uart(rd1), .wr_uart(wr1), .rx(rx), .w_data(buf1w),
    .tx_full(tx_full1), .rx_empty(rx_empty1), .tx(tx), .r_data(buf1r));

pixl p1(clk, reset, rx, tx);

initial begin
    #80;
    reset = 1'b1;
    #2000000;
    reset = 1'b0;
    #2000000; //wait for 5 clks
    rd2 = 1'b0;

    @(posedge clk) {buf1w, wr1} = {8'd0, 1'b1}; //put ASCII 'A' on write buf and enable write
    @(posedge clk) wr1 = 1'b0; //generate only a pulse
    #1043300; //wait for transmission = ticks/bit * no. of bits * clk cycles/tick * timeunits/clk = 16 * 10 * 163 * 40 = 1043200

    @(posedge clk) {buf1w, wr1} = {8'd1, 1'b1}; //put ASCII 'A' on write buf and enable write
    @(posedge clk) wr1 = 1'b0; //generate only a pulse
    #1043300; //wait for transmission = ticks/bit * no. of bits * clk cycles/tick * timeunits/clk = 16 * 10 * 163 * 40 = 1043200

    @(posedge clk) {buf1w, wr1} = {8'd2, 1'b1}; //put ASCII 'A' on write buf and enable write
    @(posedge clk) wr1 = 1'b0; //generate only a pulse
    #1043300; //wait for transmission = ticks/bit * no. of bits * clk cycles/tick * timeunits/clk = 16 * 10 * 163 * 40 = 1043200

    @(posedge clk) {buf1w, wr1} = {8'd3, 1'b1}; //put ASCII 'A' on write buf and enable write
    @(posedge clk) wr1 = 1'b0; //generate only a pulse
    #1043300; //wait for transmission = ticks/bit * no. of bits * clk cycles/tick * timeunits/clk = 16 * 10 * 163 * 40 = 1043200

    @(posedge clk) {buf1w, wr1} = {8'd4, 1'b1}; //put ASCII 'A' on write buf and enable write
    @(posedge clk) wr1 = 1'b0; //generate only a pulse
    #1043300; //wait for transmission = ticks/bit * no. of bits * clk cycles/tick * timeunits/clk = 16 * 10 * 163 * 40 = 1043200

    @(posedge clk) {buf1w, wr1} = {8'd5, 1'b1}; //put ASCII 'A' on write buf and enable write
    @(posedge clk) wr1 = 1'b0; //generate only a pulse
    #1043300; //wait for transmission = ticks/bit * no. of bits * clk cycles/tick * timeunits/clk = 16 * 10 * 163 * 40 = 1043200

    @(posedge clk) {buf1w, wr1} = {8'd6, 1'b1}; //put ASCII 'A' on write buf and enable write
    @(posedge clk) wr1 = 1'b0; //generate only a pulse
    #1043300; //wait for transmission = ticks/bit * no. of bits * clk cycles/tick * timeunits/clk = 16 * 10 * 163 * 40 = 1043200

    @(posedge clk) {buf1w, wr1} = {8'd7, 1'b1}; //put ASCII 'A' on write buf and enable write
    @(posedge clk) wr1 = 1'b0; //generate only a pulse
    #1043300; //wait for transmission = ticks/bit * no. of bits * clk cycles/tick * timeunits/clk = 16 * 10 * 163 * 40 = 1043200

    @(posedge clk) {buf1w, wr1} = {8'd8, 1'b1}; //put ASCII 'A' on write buf and enable write
    @(posedge clk) wr1 = 1'b0; //generate only a pulse
    #1043300; //wait for transmission = ticks/bit * no. of bits * clk cycles/tick * timeunits/clk = 16 * 10 * 163 * 40 = 1043200




    @(posedge clk) {buf1w, wr1} = {8'd1, 1'b1}; //put ASCII 'A' on write buf and enable write
    @(posedge clk) wr1 = 1'b0; //generate only a pulse
    #1043300; //wait for transmission = ticks/bit * no. of bits * clk cycles/tick * timeunits/clk = 16 * 10 * 163 * 40 = 1043200

    @(posedge clk) {buf1w, wr1} = {8'd2, 1'b1}; //put ASCII 'A' on write buf and enable write
    @(posedge clk) wr1 = 1'b0; //generate only a pulse
    #1043300; //wait for transmission = ticks/bit * no. of bits * clk cycles/tick * timeunits/clk = 16 * 10 * 163 * 40 = 1043200

    @(posedge clk) {buf1w, wr1} = {8'd3, 1'b1}; //put ASCII 'A' on write buf and enable write
    @(posedge clk) wr1 = 1'b0; //generate only a pulse
    #1043300; //wait for transmission = ticks/bit * no. of bits * clk cycles/tick * timeunits/clk = 16 * 10 * 163 * 40 = 1043200

    @(posedge clk) {buf1w, wr1} = {8'd4, 1'b1}; //put ASCII 'A' on write buf and enable write
    @(posedge clk) wr1 = 1'b0; //generate only a pulse
    #1043300; //wait for transmission = ticks/bit * no. of bits * clk cycles/tick * timeunits/clk = 16 * 10 * 163 * 40 = 1043200

    @(posedge clk) {buf1w, wr1} = {8'd5, 1'b1}; //put ASCII 'A' on write buf and enable write
    @(posedge clk) wr1 = 1'b0; //generate only a pulse
    #1043300; //wait for transmission = ticks/bit * no. of bits * clk cycles/tick * timeunits/clk = 16 * 10 * 163 * 40 = 1043200

    @(posedge clk) {buf1w, wr1} = {8'd6, 1'b1}; //put ASCII 'A' on write buf and enable write
    @(posedge clk) wr1 = 1'b0; //generate only a pulse
    #1043300; //wait for transmission = ticks/bit * no. of bits * clk cycles/tick * timeunits/clk = 16 * 10 * 163 * 40 = 1043200

    @(posedge clk) {buf1w, wr1} = {8'd7, 1'b1}; //put ASCII 'A' on write buf and enable write
    @(posedge clk) wr1 = 1'b0; //generate only a pulse
    #1043300; //wait for transmission = ticks/bit * no. of bits * clk cycles/tick * timeunits/clk = 16 * 10 * 163 * 40 = 1043200

    @(posedge clk) {buf1w, wr1} = {8'd8, 1'b1}; //put ASCII 'A' on write buf and enable write
    @(posedge clk) wr1 = 1'b0; //generate only a pulse
    #1043300; //wait for transmission = ticks/bit * no. of bits * clk cycles/tick * timeunits/clk = 16 * 10 * 163 * 40 = 1043200

    @(posedge clk) {buf1w, wr1} = {8'd9, 1'b1}; //put ASCII 'A' on write buf and enable write
    @(posedge clk) wr1 = 1'b0; //generate only a pulse
    #1043300; //wait for transmission = ticks/bit * no. of bits * clk cycles/tick * timeunits/clk = 16 * 10 * 163 * 40 = 1043200







    @(posedge clk) rd2 = 1'b1;
    @(posedge clk) rd2 = 1'b0; //generate only a pulse
    #200;

    //above can be put in a loop to transmit more data.
    $finish;
end
initial begin
    $dumpfile("a.vcd");
    $dumpvars;
end
endmodule
