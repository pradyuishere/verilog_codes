To compile the verilog files, enter
 	$ iverilog proc.v tb_proc.v

To run the verilog files, enter
	$ ./a.out

The command above creates a vcd file which can can be viewed using gtkwave, using the command
	$ gtkwave a.vcd


	The module proc implements a minimal version of a pipelined with stages decode, execute, write_back.
Each of the three stages in the module run concurrently giving an effective output frequency
equal to the system clock frequency. Also, each of these sub-stages write the stage outputs to a set
of pre-assigned registers once every clock cycle so that the data can be used in the next stage.

	The instruction decode stage decodes the first 8-bits of the input instruction and creates control
signals which are passed on to the execute stage. Along with the control signals, it also passes the
storage location and operands in the instruction field, which are used in the later stages.

	The instruction execute stage uses the control signals generated in the decode stage to decide upon
the operation to execute and generates the data_write, which is the result of the operation. It also forwards the location_write data, which is the destination for the calculated data and is a part of the instruction code.

	The final stage write_back stage used the data_write and location_write to store the data in data_write, which is
the result of the operation in the execute stage to the memory location reference in location_write register. This stage also writes out the to the res, which is output of the module proc.