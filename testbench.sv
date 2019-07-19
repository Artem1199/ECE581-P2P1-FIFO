// Testbench for FIFO
//Artem Kulakevich - Project 2, problem 2

`timescale 1ns/1ns

module P2P1_FIFO_TB;	// No need for Ports

  logic RST;
  logic CLK;
  logic WR;
  logic RD;
  logic WR_EN;
  logic RD_EN;
  logic [4:0] RD_PTR;
  logic [4:0] WR_PTR;
  logic EMP;
  logic FULL;

  // Instantiate the module to be tested
  
  FIFO_Controller FIFO(RST, CLK, WR, RD, WR_EN, RD_EN, RD_PTR[4:0], WR_PTR[4:0], EMP, FULL);
   
  initial begin	   // initial block
    $dumpfile("Test_FIFO.vcd"); //required for EDA playground
    $dumpvars(1, FIFO);
    
    CLK =0; RST = 1; WR = 0; RD = 0;
    #4 RST = 0;
	#5 WR = 0;
    #5 WR = 1;
	#5 WR = 0;
    #10 WR = 0;
    #5 WR = 1; RD = 1;
    #5 WR = 0; RD = 0;
    
    for (int i = 0 ; i < 34 ; i++) begin
      #5 WR = 1;
      #5 WR = 0;
    end
    
    for (int p = 0 ; p < 34 ; p++) begin
      #5 RD = 1;
      #5 RD = 0;
    end
    
    #30
   for (int p = 0 ; p < 34 ; p++) begin
      #5 RD = 1;
      #5 RD = 0;
      #5 WR = 1;
      #5 WR = 0;
    end
    #30
    for (int i = 0 ; i < 10 ; i++) begin
      #5 WR = 1;
      #5 WR = 0;
    end
    
    
    for (int p = 0 ; p < 15 ; p++) begin
      #5 RD = 1;
      #5 RD = 0;
    end
       

    
    #50 $finish;

  end	
  
    always #5 CLK =  ~CLK;

  
endmodule
