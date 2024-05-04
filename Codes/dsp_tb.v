module dsp_tb ();
parameter A0REG=1;
parameter A1REG=1;
parameter B0REG=1;
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
reg  [7:0]opmode;
reg  [17:0]a,b,d;
reg  [47:0]c,pcin;
reg  carryin;
reg clk,rsta,rstb,rstm,rstp,rstc,rstd,rstcarryin,rstopmode,
cea,ceb,cem,cep,cec,ced,cecarryin,ceopmode;
reg [47:0]p_expected;
reg [35:0]m_expected;
wire  [17:0]bcout,bcin;
wire  [47:0]p,pcout;
wire  [35:0]m;
wire  carryout;
wire carryoutf;
DSP #(.A0REG(A0REG),.A1REG(A1REG),.B0REG(B0REG),.B1REG(B1REG),.CREG(CREG),.DREG(DREG),.MREG(MREG),
	.PREG(PREG),.CARRYINREG(CARRYINREG),.CARRYOUTREG(CARRYOUTREG),.OPMODEREG(OPMODEREG)
	,.CARRYINSEL(CARRYINSEL),.B_INPUT(B_INPUT)) DUT (opmode,a,b,d,c,bcin,pcin,clk,carryin,
	rsta,rstb,rstm,rstp,rstc,rstd,rstcarryin,rstopmode,cea,ceb,cem,cep,cec,ced,
	cecarryin,ceopmode,bcout,pcout,p,m,carryout,carryoutf);

initial begin
	clk=0;
	forever 
	#1 clk=~clk ;
end
// test the rst signal
initial begin
	opmode=8'b11110000; a=10; b=20; d=30; c=40;  pcin=0; carryin=0;
	rsta=1; rstb=1; rstm=1; rstp=1; rstc=1; rstd=1; rstcarryin=1; rstopmode=1; cea=1;
	ceb=1; cem=1; cep=1; cec=1; ced=1; cecarryin=1; ceopmode=1;
	#20
	if (bcout!=0|pcout!=0|carryout!=0) begin
	$display("ERROR");
	$stop;	
	end

// test some cases
#20
	opmode=8'b00010000; a=10; b=20; d=30; c=40;  pcin=0; carryin=0;
	rsta=0; rstb=0; rstm=0; rstp=0; rstc=0; rstd=0; rstcarryin=0; rstopmode=0; cea=1;
	ceb=1; cem=1; cep=1; cec=1; ced=1; cecarryin=1; ceopmode=1;
	p_expected=0; m_expected=500; 
	#20
	if (p!=p_expected|m!=m_expected) begin
	$display("ERROR");
	$stop;	
	end
#20
	opmode=8'b00011101; a=10; b=20; d=30; c=40;  pcin=0; carryin=0;
	rsta=0; rstb=0; rstm=0; rstp=0; rstc=0; rstd=0; rstcarryin=0; rstopmode=0; cea=1;
	ceb=1; cem=1; cep=1; cec=1; ced=1; cecarryin=1; ceopmode=1;
	p_expected=540; m_expected=500;
	#20
	if (p!=p_expected|m!=m_expected) begin
	$display("ERROR");
	$stop;	
	end
#20
	opmode=8'b00011100; a=10; b=20; d=30; c=40;  pcin=0; carryin=0;
	rsta=0; rstb=0; rstm=0; rstp=0; rstc=0; rstd=0; rstcarryin=0; rstopmode=0; cea=1;
	ceb=1; cem=1; cep=1; cec=1; ced=1; cecarryin=1; ceopmode=1;
	p_expected=40; m_expected=500;
	#20
	if (p!=p_expected|m!=m_expected) begin
	$display("ERROR");
	$stop;	
	end
#20
    opmode=8'b00000000; a=10; b=20; d=30; c=40;  pcin=0; carryin=0;
	rsta=0; rstb=0; rstm=0; rstp=0; rstc=0; rstd=0; rstcarryin=0; rstopmode=0; cea=1;
	ceb=1; cem=1; cep=1; cec=1; ced=1; cecarryin=1; ceopmode=1;
	p_expected=0; m_expected=200;
	#20
	if (p!=p_expected|m!=m_expected) begin
	$display("ERROR");
	$stop;	
	end 
end
initial begin
	$monitor("time = %0t, a = %b, b = %b, c = %b, d = %b, opmode = %b,m = %b, p = %b,clk = %b",
$time,a, b, c, d, opmode, m, p ,clk);
end

endmodule