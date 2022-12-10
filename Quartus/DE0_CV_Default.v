// ============================================================================
//   Ver  :| Author            :| Mod. Date :| Changes Made:
//   V1.0 :| YaytZade          :| 11/25/2020:| Initial Revision
// ============================================================================


module DE0_CV_Default(


      ///////// CLOCK2 /////////
      input              CLOCK2_50,

      ///////// CLOCK3 /////////
      input              CLOCK3_50,

      ///////// CLOCK4 /////////
      inout              CLOCK4_50,

      ///////// CLOCK /////////
      input              CLOCK_50,

      ///////// DRAM /////////
      output      [12:0] DRAM_ADDR,
      output      [1:0]  DRAM_BA,
      output             DRAM_CAS_N,
      output             DRAM_CKE,
      output             DRAM_CLK,
      output             DRAM_CS_N,
      inout       [15:0] DRAM_DQ,
      output             DRAM_LDQM,
      output             DRAM_RAS_N,
      output             DRAM_UDQM,
      output             DRAM_WE_N,

      ///////// GPIO /////////
      inout       [35:0] GPIO_0,
      inout       [35:0] GPIO_1,

      ///////// HEX0 /////////
      output      [6:0]  HEX0,

      ///////// HEX1 /////////
      output      [6:0]  HEX1,

      ///////// HEX2 /////////
      output      [6:0]  HEX2,

      ///////// HEX3 /////////
      output      [6:0]  HEX3,

      ///////// HEX4 /////////
      output      [6:0]  HEX4,

      ///////// HEX5 /////////
      output      [6:0]  HEX5,

      ///////// KEY /////////
      input       [3:0]  KEY,

      ///////// LEDR /////////
      output      [9:0]  LEDR,

      ///////// PS2 /////////
      inout              PS2_CLK,
      inout              PS2_CLK2,
      inout              PS2_DAT,
      inout              PS2_DAT2,

      ///////// RESET /////////
      input              RESET_N,

      ///////// SD /////////
      output             SD_CLK,
      inout              SD_CMD,
      inout       [3:0]  SD_DATA,

      ///////// SW /////////
      input       [9:0]  SW,

      ///////// VGA /////////
      output      [3:0]  VGA_B,
      output      [3:0]  VGA_G,
      output             VGA_HS,
      output      [3:0]  VGA_R,
      output             VGA_VS
);


//=======================================================
//  REG/WIRE declarations
//=======================================================
	wire Run;
	wire Resetn = ~KEY[0];
	wire [8:0] ADDR;
	wire [8:0] DOUT;
	wire [8:0] DIN;
	wire W;
	wire Done;
//=======================================================
//  Structural coding
//=======================================================
	//processor instantiate
	regw U3 (
		.clock(CLOCK_50),
		.en(SW[0]),
		.q(Run));
	
	proc U0 (
		.Clock(CLOCK_50),
		.Resetn(Resetn),
		.Run(Run),
		.DIN(DIN),
		.Done(Done),
		.ADDR(ADDR),
		.DOUT(DOUT),
		.W(W));
	
	wire wren, len;
	assign wren = W & ~(ADDR[8] | ADDR[7]);
	assign len = W & ~(ADDR[8] | ~ADDR[7]);
	
	ram128x9 U1 (
		.address(ADDR[6:0]),
		.clock(CLOCK_50),
		.data(DOUT),
		.wren(wren),
		.q(DIN));

	regn U2 (
		.R(DOUT),
		.Rin(len),
		.Clock(CLOCK_50),
		.Q(LEDR[8:0]));
	
//	regl U2 (
//		.clock(CLOCK_50),
//		.en(len),
//		.data(DOUT),
//		.q(LEDR[8:0]));
	
endmodule
