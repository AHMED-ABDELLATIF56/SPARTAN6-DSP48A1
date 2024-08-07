module reg_mux_block (x,sel,clk,ce,rst,y);
	parameter WIDTH=18;
	parameter RSTTYPE="SYNC";
	input [WIDTH-1:0]x;
	input sel,clk,rst,ce;
	output [WIDTH-1:0]y;
	reg [WIDTH-1:0] reg_out;
	//Register
	generate
		if (RSTTYPE=="SYNC") begin
			always @(posedge clk or posedge rst) begin 
				if(rst) begin
					reg_out <= 0;
				end else if (ce) begin
					reg_out <= x;
				end else reg_out <= reg_out;
			end
		end else begin
			always @(posedge clk or posedge rst) begin 
				if(rst) begin
					reg_out <= 0;
				end else if (ce) begin
					reg_out <= x;
				end else reg_out <= reg_out;
			end 
		end
	endgenerate
	//Multiblixer
	assign y= sel? reg_out:x;
endmodule : reg_mux_block