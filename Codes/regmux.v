module regmux(in,sel,clk,clke,rst,out);
parameter n=18;
parameter rsttype="SYNC";

input [n-1:0]in;
input sel,clk,clke,rst;
output [n-1:0] out;

reg [n-1:0]in_reg;
if (rsttype=="SYNC") begin
	always @(posedge clk) begin
		if (rst) begin
			in_reg<=0;	
		end
		else if (clke) begin
			in_reg<=in;
		end
	end
end
else begin
	always @(posedge clk or posedge rst) begin
		if (rst) begin
			in_reg<=0;	
		end
		else if (clke) begin
			in_reg<=in;
		end
	end	
end
assign out = sel? in_reg:in;
endmodule 

