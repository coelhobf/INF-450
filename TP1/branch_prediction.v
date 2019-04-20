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
	output wire reg flush,

	// teste de predição
	output [31:0] p_acerto,
	output [31:0] p_erro
	);

	reg [31:0] _p_acerto;
	reg [31:0] _p_erro;

	initial begin
		_p_acerto = 32'd0;
		_p_erro = 32'd0;
	end

	assign p_acerto = _p_acerto;
	assign p_erro = _p_erro;

	always @(*) begin
		// caso 1
		if(~hit_s1 & ~hit_s4 & ~branch_s4) begin
			mux_signal <= 2'd0;
			write_rp <= 1'd0;
			write_rt <= 1'd0;
			flush <= 1'd0;
		end
		// caso 2
		else if(hit_s1 & ~p_s1 & ~hit_s4 & ~branch_s4) begin
			mux_signal <= 2'd0;
			write_rp <= 1'd0;
			write_rt <= 1'd0;
			flush <= 1'd0;
		end
		// caso 3
		else if(hit_s1 & p_s1 & ~hit_s4 & ~branch_s4) begin
			mux_signal <= 2'd1;
			write_rp <= 1'd0;
			write_rt <= 1'd0;
			flush <= 1'd0;
		end
		// caso 4
		else if(~hit_s1 & ~hit_s4 & ~deviated_s4 & branch_s4) begin
			mux_signal <= 2'd0;
			write_rp <= 1'd1;
			write_rt <= 1'd1;
			flush <= 1'd0;
		end
		// caso 5
		else if(~hit_s1 & ~hit_s4 & deviated_s4 & branch_s4) begin
			mux_signal <= 2'd3;
			write_rp <= 1'd1;
			write_rt <= 1'd1;
			flush <= 1'd1;
		end
		// caso 6
		else if(~hit_s1 & hit_s4 & ~p_s4 & ~deviated_s4 & branch_s4) begin
			mux_signal <= 2'd0;
			write_rp <= 1'd0;
			write_rt <= 1'd0;
			flush <= 1'd0;

			_p_acerto = _p_acerto + 32'd1;
		end
		// caso 7
		else if(~hit_s1 & hit_s4 & p_s4 & deviated_s4 & branch_s4) begin
			mux_signal <= 2'd0;
			write_rp <= 1'd0;
			write_rt <= 1'd0;
			flush <= 1'd0;

			_p_acerto = _p_acerto + 32'd1;
		end
		// caso 8
		else if(~hit_s1 & hit_s4 & ~p_s4 & deviated_s4 & branch_s4) begin
			mux_signal <= 2'd3;
			write_rp <= 1'd1;
			write_rt <= 1'd0;
			flush <= 1'd1;

			_p_erro = _p_erro + 32'd1;
		end
		// caso 9
		else if(~hit_s1 & hit_s4 & p_s4 & ~deviated_s4 & branch_s4) begin
			mux_signal <= 2'd2;
			write_rp <= 1'd1;
			write_rt <= 1'd0;
			flush <= 1'd1;

			_p_erro = _p_erro + 32'd1;
		end
		// caso base
		else begin
			mux_signal <= 2'd0;
			write_rp <= 1'd0;
			write_rt <= 1'd0;
			flush <= 1'd0;
		end
	end
endmodule

`endif
