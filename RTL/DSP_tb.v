module DSP_tb ();
	reg [7:0]opmode;
	reg [17:0]a,b,d,bcin;
	reg [47:0]c,pcin;
	reg clk,rsta,rstb,rstm,rstp,rstc,rstd,rstcarryin,rstopmode,cea,ceb,cem,cep,cec,ced,cecarryin,ceopmode,carryin;
	wire  [17:0]bcout;
	wire  [47:0]p,pcout;
	wire  [35:0]m;
	wire  carryout,carryoutf;
	// expected values to compare with
	reg  [17:0]bcout_expected;
	reg  [47:0]p_expected,pcout_expected;
	reg  [35:0]m_expected;
	reg  carryout_expected,carryoutf_expected;
	// inistantiation of our RTL design
	DSP dut (clk,rsta,rstb,rstm,rstp,rstc,rstd,rstcarryin,rstopmode,cea,ceb,cem,cep,cec,ced,ceopmode,cecarryin,
	carryin,opmode,a,b,d,c,bcin,pcin,bcout,pcout,p,m,carryout,carryoutf);
	// clock 
	initial begin
		clk=0;
		forever begin
			#5; clk=~clk;
		end 
	end
	initial begin
		// test the rst of the input registers
		rsta=1; rstb=1; rstc=1; rstd=1; rstcarryin=1; rstopmode=0; rstp=0; rstm=0; // resets
		a=10; b=20; c=30; d=40; bcin=50; pcin=50; carryin=1; opmode=8'b00111111; // inputs
		cea=1; ceb=1; cem=1; cep=1; cec=1; ced=1; cecarryin=1; ceopmode=1; // clk enables

		bcout_expected=0; p_expected=0; pcout_expected=0; // expected values
		m_expected=0; carryout_expected=0; carryoutf_expected=0;
		@(negedge clk); @(negedge clk); @(negedge clk); @(negedge clk);// 4 clk cycle
		if (bcout_expected!=bcout||p_expected!=p||pcout_expected!=pcout||m_expected!=m
		||carryout_expected!=carryout||carryoutf_expected!=carryoutf) begin
			$display("There is an error");
			$stop;
		end
		////////////////////////////////////////////////////////////////////////////////////////////
		// test the rst of the output registers
		rsta=0; rstb=0; rstc=0; rstd=0; rstcarryin=1; rstopmode=0; rstp=1; rstm=1; // resets
		a=10; b=20; c=30; d=40; bcin=50; pcin=50; carryin=1; opmode=8'b00111111; // inputs
		cea=1; ceb=1; cem=1; cep=1; cec=1; ced=1; cecarryin=1; ceopmode=1; // clk enables
		bcout_expected=60; p_expected=0; pcout_expected=0; // expected values
		m_expected=0; carryout_expected=0; carryoutf_expected=0;
		@(negedge clk); @(negedge clk); @(negedge clk); @(negedge clk);// 4 clk cycle
		if (bcout_expected!=bcout||p_expected!=p||pcout_expected!=pcout||m_expected!=m
		||carryout_expected!=carryout||carryoutf_expected!=carryoutf) begin
			$display("There is an error");
			$stop;
		end	
		///////////////////////////////////////////////////////////////////////////////////////////////
		// test of the clk enables 
		rsta=0; rstb=0; rstc=0; rstd=0; rstcarryin=0; rstopmode=0; rstp=0; rstm=0; // resets
		a=10; b=20; c=30; d=40; bcin=50; pcin=50; carryin=1; opmode=8'b00111111; // inputs
		cea=0; ceb=0; cem=0; cep=0; cec=0; ced=0; cecarryin=0; ceopmode=0; // clk enables
		bcout_expected=60; p_expected=0; pcout_expected=0; // expected values
		m_expected=0; carryout_expected=0; carryoutf_expected=0;
		@(negedge clk); @(negedge clk); @(negedge clk); @(negedge clk);// 4 clk cycle
		if (bcout_expected!=bcout||p_expected!=p||pcout_expected!=pcout||m_expected!=m
		||carryout_expected!=carryout||carryoutf_expected!=carryoutf) begin
			$display("There is an error");
			$stop;
		end	
		//////////////////////////////////////////////////////////////////////////////////////////////
		// test of the outputs with diffrent operation modes
		rsta=0; rstb=0; rstc=0; rstd=0; rstcarryin=0; rstopmode=0; rstp=0; rstm=0; // resets
		a=10; b=20; c=30; d=40; bcin=50; pcin=50; carryin=1; opmode=8'b00000000; // inputs
		cea=1; ceb=1; cem=1; cep=1; cec=1; ced=1; cecarryin=1; ceopmode=1; // clk enables
		bcout_expected=20; p_expected=0; pcout_expected=0; // expected values
		m_expected=200; carryout_expected=0; carryoutf_expected=0;
		@(negedge clk); @(negedge clk); @(negedge clk); @(negedge clk);// 4 clk cycle
		if (bcout_expected!=bcout||p_expected!=p||pcout_expected!=pcout||m_expected!=m
		||carryout_expected!=carryout||carryoutf_expected!=carryoutf) begin
			$display("There is an error");
			$stop;
		end	
		///////////////////////////////////////////////////////////////////////////////////////////////
		rsta=0; rstb=0; rstc=0; rstd=0; rstcarryin=0; rstopmode=0; rstp=0; rstm=0; // resets
		a=10; b=20; c=30; d=40; bcin=50; pcin=50; carryin=1; opmode=8'b00000101; // inputs
		cea=1; ceb=1; cem=1; cep=1; cec=1; ced=1; cecarryin=1; ceopmode=1; // clk enables
		bcout_expected=20; p_expected=250; pcout_expected=250; // expected values
		m_expected=200; carryout_expected=0; carryoutf_expected=0;
		@(negedge clk); @(negedge clk); @(negedge clk); @(negedge clk);// 4 clk cycle
		if (bcout_expected!=bcout||p_expected!=p||pcout_expected!=pcout||m_expected!=m
		||carryout_expected!=carryout||carryoutf_expected!=carryoutf) begin
			$display("There is an error");
			$stop;
		end	
		/////////////////////////////////////////////////////////////////////////////////////////////
		// test the carryin (OPMODE5)
		rsta=0; rstb=0; rstc=0; rstd=0; rstcarryin=0; rstopmode=0; rstp=0; rstm=0; // resets
		a=10; b=20; c=30; d=40; bcin=50; pcin=50; carryin=1; opmode=8'b00100101; // inputs
		cea=1; ceb=1; cem=1; cep=1; cec=1; ced=1; cecarryin=1; ceopmode=1; // clk enables
		bcout_expected=20; p_expected=251; pcout_expected=251; // expected values
		m_expected=200; carryout_expected=0; carryoutf_expected=0;
		@(negedge clk); @(negedge clk); @(negedge clk); @(negedge clk);// 4 clk cycle
		if (bcout_expected!=bcout||p_expected!=p||pcout_expected!=pcout||m_expected!=m
		||carryout_expected!=carryout||carryoutf_expected!=carryoutf) begin
			$display("There is an error");
			$stop;
		end
		/////////////////////////////////////////////////////////////////////////////////////////////
		// test the post adder subtractor and the carry out 
		rsta=0; rstb=0; rstc=0; rstd=0; rstcarryin=0; rstopmode=0; rstp=0; rstm=0; // resets
		a=10; b=20; c=30; d=40; bcin=50; pcin=50; carryin=1; opmode=8'b10011010; // inputs
		cea=1; ceb=1; cem=1; cep=1; cec=1; ced=1; cecarryin=1; ceopmode=1; // clk enables
		bcout_expected=60; p_expected=0; pcout_expected=0; // expected values
		m_expected=600; carryout_expected=1; carryoutf_expected=1;
		@(negedge clk);
		if (carryout_expected!=carryout||carryoutf_expected!=carryoutf) begin
			$display("There is an error");
			$stop;
		end
		@(negedge clk); @(negedge clk) @(negedge clk); 
		if (bcout_expected!=bcout||p_expected!=p||pcout_expected!=pcout||m_expected!=m) begin
			$display("There is an error");
			$stop;
		end
		///////////////////////////////////////////////////////////////////////////////////////////////
		// test the pre adder subtractor (subtract) and the c port
		rsta=0; rstb=0; rstc=0; rstd=0; rstcarryin=0; rstopmode=0; rstp=0; rstm=0; // resets
		a=10; b=20; c=30; d=40; bcin=50; pcin=50; carryin=1; opmode=8'b01011101; // inputs
		cea=1; ceb=1; cem=1; cep=1; cec=1; ced=1; cecarryin=1; ceopmode=1; // clk enables
		bcout_expected=20; p_expected=230; pcout_expected=230; // expected values
		m_expected=200; carryout_expected=0; carryoutf_expected=0;
		@(negedge clk); @(negedge clk); @(negedge clk); @(negedge clk);// 4 clk cycle
		if (bcout_expected!=bcout||p_expected!=p||pcout_expected!=pcout||m_expected!=m
		||carryout_expected!=carryout||carryoutf_expected!=carryoutf) begin
			$display("There is an error");
			$stop;
		end	
	$stop;
	end
endmodule : DSP_tb