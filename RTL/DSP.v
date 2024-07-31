module DSP (clk,rsta,rstb,rstm,rstp,rstc,rstd,rstcarryin,rstopmode,cea,ceb,cem,cep,cec,ced,ceopmode,cecarryin,
carryin,opmode,a,b,d,c,bcin,pcin,bcout,pcout,p,m,carryout,carryoutf);
parameter A0REG=0;
parameter A1REG=1;
parameter B0REG=0;
parameter B1REG=1;
parameter CREG=1;
parameter DREG=1;
parameter MREG=1;
parameter PREG=1;
parameter CARRYINREG=1;
parameter CARRYOUTREG=1;
parameter OPMODEREG=1;
parameter CARRYINSEL="opmode5";
parameter B_INPUT="DIRECT";
input  [7:0]opmode;
input  [17:0]a,b,d,bcin;
input  [47:0]c,pcin;
input clk,rsta,rstb,rstm,rstp,rstc,rstd,rstcarryin,rstopmode,cea,ceb,cem,cep,cec,ced,cecarryin,ceopmode,carryin;
output  [17:0]bcout;
output  [47:0]p,pcout;
output  [35:0]m;
output  carryout,carryoutf;
// wires for internal signals
wire [7:0]opmodew;
wire [17:0]a0w,a1w,dw,b0w,b1w,pre_adder,b1_inw,b0_inw;
wire [35:0]mw,mult_outw;
wire [47:0]post_adder,cw;
wire cinw,cout,carry_cascade;
reg [47:0]x_out,z_out;
//////////////////////////////////////////////////////////////////////////////////////////////////////////
//selections of internal multiplixers
always @(*) begin 
	//Multiplixer X
	case (opmodew[1:0])
		0: x_out=0;
		1: x_out={12'h000,mw};
		2: x_out=pcout;
		3: x_out={dw[11:0], a1w[17:0],b1w[17:0]};
		default : x_out=0;
	endcase
	//Multiplixer Z
	case (opmodew[3:2])
		0: z_out=0;
		1: z_out=pcin;
		2: z_out=pcout;
		3: z_out=cw;
		default : z_out=0;
	endcase	
end
//////////////////////////////////////////////////////////////////////////////////////////////////////////
//inistantiation of the reg_mux blocks for inputs and outputs and internal signals
reg_mux_block #(.WIDTH(18),.RSTTYPE("SYNC")) D (.x(d),.sel(DREG),.clk(clk),.ce(ced),.rst(rstd),.y(dw));
reg_mux_block #(.WIDTH(18),.RSTTYPE("SYNC")) B0 (.x(b0_inw),.sel(B0REG),.clk(clk),.ce(ceb),.rst(rstb),.y(b0w));
reg_mux_block #(.WIDTH(18),.RSTTYPE("SYNC")) A0 (.x(a),.sel(A0REG),.clk(clk),.ce(cea),.rst(rsta),.y(a0w));
reg_mux_block #(.WIDTH(48),.RSTTYPE("SYNC")) C (.x(c),.sel(CREG),.clk(clk),.ce(cec),.rst(rstc),.y(cw));
reg_mux_block #(.WIDTH(8),.RSTTYPE("SYNC")) OPMODE (.x(opmode),.sel(OPMODEREG),.clk(clk),.ce(ceopmode),.rst(rstopmode),.y(opmodew));
reg_mux_block #(.WIDTH(18),.RSTTYPE("SYNC")) B1 (.x(b1_inw),.sel(B1REG),.clk(clk),.ce(ceb),.rst(rstb),.y(b1w));
reg_mux_block #(.WIDTH(18),.RSTTYPE("SYNC")) A1 (.x(a0w),.sel(A1REG),.clk(clk),.ce(cea),.rst(rsta),.y(a1w));
reg_mux_block #(.WIDTH(1),.RSTTYPE("SYNC")) CYI (.x(carry_cascade),.sel(CARRYINREG),.clk(clk),.ce(cecarryin),.rst(rstcarryin),.y(cinw));
reg_mux_block #(.WIDTH(36),.RSTTYPE("SYNC")) M (.x(mult_outw),.sel(MREG),.clk(clk),.ce(cem),.rst(rstm),.y(mw));
reg_mux_block #(.WIDTH(48),.RSTTYPE("SYNC")) P (.x(post_adder),.sel(PREG),.clk(clk),.ce(cep),.rst(rstp),.y(p));
reg_mux_block #(.WIDTH(1),.RSTTYPE("SYNC")) CYO (.x(cout),.sel(CARRYOUTREG),.clk(clk),.ce(cecarryin),.rst(rstcarryin),.y(carryout));
/////////////////////////////////////////////////////////////////////////////////////////////////////////
//B0 input selection
assign b0_inw=(B_INPUT=="DIRECT")? b:(B_INPUT=="CASCADE")?bcin:0;
//B1 input selection
assign b1_inw=(opmodew[4])? pre_adder:b0w;
//Carry in selection
assign carry_cascade=(CARRYINSEL=="opmode5")? opmodew[5]:(B_INPUT=="CARRYIN")?carryin:0;
//pre Adder_Subtractor
assign pre_adder=(opmodew[6])? dw-b0w:dw+b0w;
//post Adder_Subtractor
assign {carryout,post_adder}=(opmodew[7])? z_out-(x_out+cinw):z_out+x_out+cinw;
// Internal Multipier 
assign mult_outw=b1w*a1w;
// continoues assignments for outputs
assign m=mw;
assign pcout=p;
assign bcout=b1w;
assign carryoutf=carryout;
endmodule : DSP