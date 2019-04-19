// By Bruno e Westerley

`ifndef _bt
`define _bt

module branch_table(
		input wire clk,
		
		// fetch
		input wire[31:0] instruction_fetch,
		output wire[31:0] b_dest_out,
		output wire p_fetch,
		output wire hit_fetch,

		// update
		input wire write_rp,
		input wire write_rt,
		input wire[31:0] b_dest_in,
		input wire result_alu,
		input wire[31:0] instruction_update
	);

	parameter BM_DATA = "bm_data.txt";
	reg[25:0] tag[0:15];
	reg pred[0:15];
	reg[31:0] dest [0:15];
	wire[3:0] prefix;
	wire[25:0] sufix;
	initial begin
		$readmemh(BM_DATA, tag, 0, 15);
	end

	assign prefix = instruction_update[31:6];
	assign sufix = instruction_update[5:2];

	always @(posedge clk) begin
		if(write_rt) begin
			tag[sufix] <= prefix;
			dest[sufix] <= b_dest_in;
		end
		if(write_rp) begin
			pred[sufix] <= result_alu;
		end
	end

	assign b_dest_out = dest[instruction_fetch[5:2]][31:0];
	assign hit_fetch = (tag[instruction_fetch[5:2]] == instruction_fetch[31:6]);
	assign p_fetch = pred[instruction_fetch[5:2]];
endmodule

`endif
