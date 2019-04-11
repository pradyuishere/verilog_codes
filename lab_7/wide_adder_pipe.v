module fa(output wire s, cout, input wire a, b, cin);
    assign {cout, s} = cin + a + b;
endmodule

module wide_adder #(parameter [3:0] width = 4) (output wire [width-1:0] s,
    output wire cout, input wire [width-1:0] a, b, input wire cin);

    wire [width:0] c;
    assign c[0] = cin;
    assign cout = c[width];

    genvar n;
    generate
        for(n=0; n<width; n=n+1)
            fa fa(s[n], c[n+1], a[n], b[n], c[n]);
    endgenerate
endmodule


// module adder_16bit(output wire [15:0] sum, output wire cout, input wire [15:0] a, b,
//     input wire cin, clk, reset);
//     reg [7:0] ifa, ifb;
//     wire [7:0] ifanextw, ifbnextw;
//     reg if2;
//     wire if2nextw;
//     reg [7:0] if3;
//     wire [7:0] if3nextw;
//     wire [3:0] carry;
//
//     wide_adder w1(if3nextw[3:0], carry[0], a[3:0], b[3:0], cin);
//     wide_adder w2(if3nextw[7:4], if2nextw, a[7:4], b[7:4], carry[0]);
//     wide_adder w3(sum[11:8], carry[2], ifa[3:0], ifb[3:0], if2);
//     wide_adder w4(sum[15:12], carry[3], ifa[7:4], ifb[7:4], carry[2]);
//
//     always @(posedge clk, reset) begin
//         if (reset) begin
//             {ifa, ifb, if2, if3} <= {4'b0, 4'b0, 1'b0, 4'b0};
//         end
//         else begin
//             ifa <= ifanextw;
//             ifb <= ifbnextw;
//             if2 <= if2nextw;
//             if3 <= if3nextw;
//         end
//     end
//
//     assign sum[7:0] = if3;
//     assign {ifanextw, ifbnextw} = {a[15:8], b[15:8]};
//     assign cout = carry[3];
// endmodule

module adder_16bit(output wire [15:0] sum, output wire cout, input wire [15:0] a, b,
    input wire cin, clk, reset);
    reg [11:0] stage_1_a, stage_1_b;
    reg [7:0] stage_2_a, stage_2_b;
    reg [3:0] stage_3_a, stage_3_b;

    reg [3:0] sum_stage_0;
    reg [7:0] sum_stage_1;
    reg [11:0] sum_stage_2;

    wire [3:0] temp_0;
    wire [3:0] temp_1;
    wire [3:0] temp_2;
    wire [3:0] temp_3;

    wire carry_stage_0_out;
    reg carry_stage_1_in;
    wire carry_stage_1_out;
    reg carry_stage_2_in;
    wire carry_stage_2_out;
    reg carry_stage_3_in;
    wire carry_stage_3_out;

    wide_adder w1(temp_0, carry_stage_0_out, a[3:0], b[3:0], cin);
    wide_adder w2(temp_1, carry_stage_1_out, stage_1_a[3:0], stage_1_b[3:0], carry_stage_1_in);
    wide_adder w3(temp_2, carry_stage_2_out, stage_2_a[3:0], stage_2_b[3:0], carry_stage_2_in);
    wide_adder w4(sum[15:12], cout, stage_3_a[3:0], stage_3_b[3:0], carry_stage_3_in);

    always @(posedge clk, reset) begin
        if (reset) begin
            {carry_stage_1_in, carry_stage_2_in, carry_stage_3_in} <= {1'b0, 1'b0, 1'b0};
        end
        else begin
            sum_stage_0 = temp_0;
            sum_stage_1[3:0] <= sum_stage_0;
            sum_stage_1[7:4] = temp_1;
            sum_stage_2[7:0] <= sum_stage_1;
            sum_stage_2[11:8] = temp_2;

            stage_1_a <= a[15:4];
            stage_1_b <= b[15:4];

            stage_2_a <= stage_1_a[11:4];
            stage_2_b <= stage_1_b[11:4];

            stage_3_a <= stage_2_a[7:4];
            stage_3_b <= stage_2_b[7:4];

            carry_stage_1_in <= carry_stage_0_out;
            carry_stage_2_in <= carry_stage_1_out;
            carry_stage_3_in <= carry_stage_2_out;
        end
    end
    assign sum[11:0] = sum_stage_2;
endmodule




module tb_wide_adder_16bit();
    reg clk;
    reg [15:0] a, b;
    wire [15:0] sum;
    wire [15:0] sum_actual;
    reg c_in, rst;
    wire c_out;

    assign sum_actual = a+b;

    adder_16bit a1(
      .clk(clk),
      .sum(sum),
      .a(a),
      .b(b),
      .cin(c_in),
      .cout(c_out),
      .reset(rst)
      );

    initial begin
        $dumpfile("wide_adder.vcd");
        $dumpvars;
        rst = 1;
        a = 200;
        b = 0;
        clk = 0;
        c_in = 0;
        #50 rst = 0;
        #2000 $finish;
    end

    always
      #5 clk = ~clk;

    always@(posedge clk)
    begin
      a <= a+1;
      b <= b+1;
    end

endmodule
