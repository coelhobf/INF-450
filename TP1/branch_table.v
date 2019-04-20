// By Bruno e Westerley

`ifndef _bt
`define _bt

module branch_table(
		input wire clk,
		
		// fetch
		input wire[31:0] inst_adress_s1,
		output wire[31:0] b_dest_out,
		output wire p_s1,
		output wire hit_s1,

		// update
		input wire write_rp,
		input wire write_rt,
		input wire[31:0] b_dest_in,
		input wire deviated_s4,
		input wire[31:0] inst_adress_s4
	);

	parameter tagData = "tag_data.txt";
	parameter pData = "p_data.txt";
	reg[25:0] tag[0:15];
	reg pred[0:15];
	reg[31:0] dest [0:15];
	wire[3:0] prefix;
	wire[25:0] sufix;
	initial begin
		$readmemh(tagData, tag, 0, 15);
		$readmemh(pData, pred, 0, 15);
	end

	assign prefix = inst_adress_s4[31:6];
	assign sufix = inst_adress_s4[5:2];

	always @(posedge clk) begin
		if(write_rt) begin
			tag[sufix] <= prefix;
			dest[sufix] <= b_dest_in;
		end
		if(write_rp) begin
			pred[sufix] <= deviated_s4;
		end
	end

	assign b_dest_out = dest[inst_adress_s1[5:2]][31:0];
	assign hit_s1 = (tag[inst_adress_s1[5:2]] == inst_adress_s1[31:6]);
	assign p_s1 = pred[inst_adress_s1[5:2]];
endmodule

`endif
