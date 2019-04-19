// By Bruno e Westerley

`ifndef _bp
`define _bp

module branch_prediction(
	input wire clk,
	input wire hit_fetch,
	input wire p_fetch,
	input wire hit_alu,
	input wire p_alu,
	input wire result_alu,
	input wire b_decode,
	
	output reg [1:0] mux_signal,
	output wire reg write_rp,
	output wire reg write_rt,
	output wire reg flush
	);

	always @(*) begin
		if(~hit_fetch & ~hit_alu & ~b_decode) begin
			mux_signal <= 2'd0;
			write_rp <= 1'd0;
			write_rt <= 1'd0;
			flush <= 1'd0;
		end else
		if(hit_fetch & ~p_fetch & ~hit_alu & ~b_decode) begin
			mux_signal <= 2'd0;
			write_rp <= 1'd0;
			write_rt <= 1'd0;
			flush <= 1'd0;
		end else
		if(hit_fetch & p_fetch & ~hit_alu & ~b_decode) begin
			mux_signal <= 2'd1;
			write_rp <= 1'd0;
			write_rt <= 1'd0;
			flush <= 1'd0;
		end else
		if(~hit_fetch & ~hit_alu & ~result_alu & b_decode) begin
			mux_signal <= 2'd0;
			write_rp <= 1'd1;
			write_rt <= 1'd1;
			flush <= 1'd0;
		end else
		if(~hit_fetch & ~hit_alu & result_alu & b_decode) begin
			mux_signal <= 2'd3;
			write_rp <= 1'd1;
			write_rt <= 1'd1;
			flush <= 1'd1;
		end else
		if(~hit_fetch & hit_alu & ~p_alu & ~result_alu & b_decode) begin
			mux_signal <= 2'd0;
			write_rp <= 1'd0;
			write_rt <= 1'd0;
			flush <= 1'd0;
		end else
		if(~hit_fetch & hit_alu & p_alu & result_alu & b_decode) begin
			mux_signal <= 2'd0;
			write_rp <= 1'd0;
			write_rt <= 1'd0;
			flush <= 1'd0;
		end else
		if(~hit_fetch & hit_alu & ~p_alu & result_alu & b_decode) begin
			mux_signal <= 2'd3;
			write_rp <= 1'd1;
			write_rt <= 1'd0;
			flush <= 1'd1;
		end else
		if(~hit_fetch & hit_alu & p_alu & ~result_alu & b_decode) begin
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
