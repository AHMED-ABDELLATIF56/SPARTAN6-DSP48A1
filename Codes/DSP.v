module DSP(opmode,a,b,d,c,bcin,pcin,clk,carryin,rsta,rstb,rstm,rstp,rstc,rstd,rstcarryin,rstopmode,
cea,ceb,cem,cep,cec,ced,cecarryin,ceopmode,bcout,pcout,p,m,carryout,carryoutf);
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
input  carryin;
input clk,rsta,rstb,rstm,rstp,rstc,rstd,rstcarryin,rstopmode,
cea,ceb,cem,cep,cec,ced,cecarryin,ceopmode;
output  [17:0]bcout;
output  [47:0]p;
output  [35:0]m;
output  carryout,pcout;
output carryoutf;

wire [7:0]opmodew;
wire [17:0]a0w,a1w,dw;
wire [47:0]cw;
wire [17:0]bcoutw;
wire [35:0]mw,m_in;
wire carryinw,carryoutw,cin;
wire [47:0]post;
wire [17:0]bw,b0w,b1w,b1_in,pre;
reg [47:0]x,z;
regmux #(.n(18)) D_REG (.in(d),.sel(DREG),.clk(clk),.clke(ced),.rst(rstd),.out(dw));
regmux #(.n(18)) A0_REG (.in(a),.sel(A0REG),.clk(clk),.clke(cea),.rst(rsta),.out(a0w));
regmux #(.n(48)) C_REG (.in(c),.sel(CREG),.clk(clk),.clke(cec),.rst(rstc),.out(cw));
     assign bw=(B_INPUT=="DIRECT")? b:bcin;
regmux #(.n(18)) B0_REG (.in(bw),.sel(B0REG),.clk(clk),.clke(cea),.rst(rstb),.out(b0w));
regmux #(.n(8)) OP_REG (.in(opmode),.sel(OPMODEREG),.clk(clk),.clke(ceopmode),.rst(rstopmode),.out(opmodew));

	assign pre = opmodew[6]? (dw-b0w):(b0w+dw)  ;
	assign b1_in = opmodew[4]? pre:b0w  ;
regmux #(.n(18)) B1_REG (.in(b1_in),.sel(B1REG),.clk(clk),.clke(ceb),.rst(rstb),.out(b1w));
regmux #(.n(18)) A1_REG (.in(a0w),.sel(A1REG),.clk(clk),.clke(cea),.rst(rsta),.out(a1w));
	assign m_in = b1w*a1w ;
regmux #(.n(36)) M_REG (.in(m_in),.sel(MREG),.clk(clk),.clke(cem),.rst(rstm),.out(mw));
	assign carryinw=(CARRYINSEL=="opmode5")? opmode[5]:carryin;
regmux #(.n(1)) CARRYIN_REG (.in(carryinw),.sel(CARRYINREG),.clk(clk),.clke(cecarryin),.rst(rstcarryin),.out(cin));
always@(*) begin
case(opmodew[1:0])
    2'b00:   x=0;
    2'b01:   x=mw;
    2'b10:   x=p;
    2'b11:   x= {dw[11:0], a1w[17:0], b1w[17:0]};
    endcase
case(opmodew[3:2])
    2'b00:   z=0;
    2'b01:   z=pcin;
    2'b10:   z=p;
    2'b11:   z=cw;
    endcase
end
    assign {carryoutw,post} = opmodew[7]? (z-(x+cin)):x+z+cin ;
regmux #(.n(1)) CARRYOUT_REG (.in(carryoutw),.sel(CARRYOUTREG),.clk(clk),.clke(cecarryin),.rst(0),.out(carryout));
	assign carryoutf=carryout;
regmux #(.n(48)) P_REG (.in(post),.sel(PREG),.clk(clk),.clke(cep),.rst(0),.out(p));
	assign bcout = b1w ;
	assign pcout = p ;
	assign m = mw ;

endmodule
