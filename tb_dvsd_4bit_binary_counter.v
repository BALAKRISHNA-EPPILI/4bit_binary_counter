//************************************************************
// E BALAKRISHNA 
// Verilog file: tb_dvsd_4bit_binary_counter.v
//************************************************************

`timescale 1ns / 1ps

// Declare a reg to connect to design clk
// Declare a reg to connect to design reset
// Declare a reg to connect to design updown 
// Declare a wire to connect to design output


module tb_dvsd_4bit_binary_counter; 
 reg clk; 
 reg reset;
 reg updown; 
 wire [3:0] out;
  
//Here a counter design and connect with Testbench variables  
  dvsd_4bit_binary_counter  c0 ( .clk (clk),  
          .reset (reset),
          .updown(updown),  
          .out (out));  
  
//Generate a clock with its value every 5ns -> time period = 10ns -> freq = 100 MHz  
   
 always #5 clk = ~clk;  
  
// This initial block forms the stimulus of the testbench  
  initial begin 
 
//Create a dump file 

  $dumpfile("tb_dvsd_4bit_binary_counter.vcd");                                        
  $dumpvars(0,tb_dvsd_4bit_binary_counter);
// Initialize testbench variables to 0 at start of simulation  
    clk <= 0;  
    reset <= 0;
    updown <= 0;  
  
// Drive rest of the stimulus, reset is asserted in between  
   #5     reset = 1;
         updown =0;
          
         updown =1;
          
   #30    reset = 0; 
         updown =0;
   #50   updown=1;
   #150   reset = 1;  
  
// Finish the stimulus after 200ns  
    #20 $finish;  
  end  
endmodule