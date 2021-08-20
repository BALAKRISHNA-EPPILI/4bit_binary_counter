//************************************************************
// E BALAKRISHNA 
// Verilog file: dvsd_4bit_binary_counter.v
//************************************************************


// Declare input port and 4-bit output port to get the counter values  
  
 module dvsd_4bit_binary_counter (input clk,
                                   input reset,
                                   input updown,
                                   output reg[3:0] out);

// This always block will be triggered at the rising edge of clk (0->1)  
// It checks if the reset is 0, then change out to zero   
// It checks if reset is 1, then the design should be allowed to count updown, so increment and decrement the counter   
  
  always @ (posedge clk) begin  
    if (reset)  
      out <= 0;
    else
        if(updown==1)
           if(out==15)
               out <= 0;  
           else
// Here, value increment by 1 for up counter

               out <= out + 1; 
        else          
            if(out==0)
               out<=15;
           else
// Here, value decrement by 1 for down counter

               out<= out-1;  
  end  
endmodule
