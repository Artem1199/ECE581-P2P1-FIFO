// Artem Kulakevich - P2P1
module FIFO_Controller (input rst,//Asynch global reset
                        input clk, //Controller Clock
                        input wr, //External Device writing data in
                        input rd, //External Device, reading data out
                        output logic wr_en, //To FIFO, write signal
                        output logic rd_en, //To FIFO, read signal
                        output logic [4:0] rd_ptr, //read address bus to FIFO
                        output logic [4:0] wr_ptr, //write address bus to FIFO 
                        output logic emp, //Indicates fifo is empty
                        output logic full); //Indicates fifo is full
  
/*                        
 //RESET Logic
  always @(posedge rst) begin
  if (rst) begin
    wr_ptr = 0;
    rd_ptr = 0;
    emp = 1;
    full = 0;
  end //end if
end //end always
  */
  
//Write/Read logic
  always_ff @(posedge clk or posedge rst) begin
    
 if (rst) begin
    wr_ptr = 0;
    rd_ptr = 0;
    emp = 1;
    full = 0;
  end //end if
  
    else begin
    
  rd_en = 0;
  wr_en = 0;
    if (wr) begin 			//When a write request occurs
      if (~full) begin 		//and the FIFO isn't full
      wr_ptr = wr_ptr+1; 	//Increments pointer to look at next empty spot
      wr_en = 1; 			//allows a write on the RAM
      emp = 0; 				//Disables empty, because if we did a write, we have to have data
        if (wr_ptr == rd_ptr) //If we just wrote data in, and the pointers overlap
        full = 1;			//set the full output to 1
      
    end //if ~full
  end //if wr
  
    if (rd) begin			//Read request
      if (~emp) begin			//if not empty
      rd_ptr = rd_ptr+1;	//Increment pointer
      rd_en = 1;			//allow read
      full = 0;				//set to full to 0, because we have to have removed data
        if (rd_ptr == wr_ptr) //If we just read data, and the pointers overlap, them we must be empty
      	emp = 1;	 //set empty to 1
      
    end // ~emp
  end //if rd
    end//else
end //always
    
  

  
  
endmodule