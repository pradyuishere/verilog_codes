module add_gate(bit_in1, bit_in2, bit_out);

input reg bit_in1;
input reg bit_in2;
output reg bit_out;

and(bit_in1, bit_in2, bit_out);

endmodule
