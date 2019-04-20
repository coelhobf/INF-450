// By Bruno e Westerley

`ifndef _bp
`define _bp

module branch_prediction(
	input wire clk,
	input wire hit_s1,
	input wire p_s1,
	input wire hit_s4,
	input wire p_s4,
	input wire deviated_s4,
	input wire branch_s4,
	
	output reg [1:0] mux_signal,
	output wire reg write_rp,
	output wire reg write_rt,
	output wire reg flush
	);

	always @(*) begin
		if(~hit_s1 & ~hit_s4 & ~branch_s4) begin
			mux_signal <= 2'd0;
			write_rp <= 1'd0;
			write_rt <= 1'd0;
			flush <= 1'd0;
		end else
		if(hit_s1 & ~p_s1 & ~hit_s4 & ~branch_s4) begin
			mux_signal <= 2'd0;
			write_rp <= 1'd0;
			write_rt <= 1'd0;
			flush <= 1'd0;
		end else
		if(hit_s1 & p_s1 & ~hit_s4 & ~branch_s4) begin
			mux_signal <= 2'd1;
			write_rp <= 1'd0;
			write_rt <= 1'd0;
			flush <= 1'd0;
		end else
		if(~hit_s1 & ~hit_s4 & ~deviated_s4 & branch_s4) begin
			mux_signal <= 2'd0;
			write_rp <= 1'd1;
			write_rt <= 1'd1;
			flush <= 1'd0;
		end else
		if(~hit_s1 & ~hit_s4 & deviated_s4 & branch_s4) begin
			mux_signal <= 2'd3;
			write_rp <= 1'd1;
			write_rt <= 1'd1;
			flush <= 1'd1;
		end else
		if(~hit_s1 & hit_s4 & ~p_s4 & ~deviated_s4 & branch_s4) begin
			mux_signal <= 2'd0;
			write_rp <= 1'd0;
			write_rt <= 1'd0;
			flush <= 1'd0;
		end else
		if(~hit_s1 & hit_s4 & p_s4 & deviated_s4 & branch_s4) begin
			mux_signal <= 2'd0;
			write_rp <= 1'd0;
			write_rt <= 1'd0;
			flush <= 1'd0;
		end else
		if(~hit_s1 & hit_s4 & ~p_s4 & deviated_s4 & branch_s4) begin
			mux_signal <= 2'd3;
			write_rp <= 1'd1;
			write_rt <= 1'd0;
			flush <= 1'd1;
		end else
		if(~hit_s1 & hit_s4 & p_s4 & ~deviated_s4 & branch_s4) begin
			mux_signal <= 2'd2;
			write_rp <= 1'd1;
			write_rt <= 1'd0;
			flush <= 1'd1;
		end
		else begin
			mux_signal <= 2'd0;
			write_rp <= 1'd0;
			write_rt <= 1'd0;
			flush <= 1'd0;
		end
	end
endmodule

`endif
