`timescale 1ns / 1ps

module pwm(clk, reset, duty, out);
    input clk, reset;
    input [16:0] duty;
    output out;
    
    // declare counter for slowing down the clock to 1KHz
    reg [16:0] counter;
    
    // increment counter at every positive edge clock to slow clock down
    always @ (posedge clk, posedge reset) begin
        if (reset) begin
            counter = 0;
        end
        else
            if (counter == 100000) begin
                counter = 0;
            end
            else
                counter = counter + 1;            
    end
    
    // compare desired duty cycle with counter
    // set output high pwm signal for when counter
    // is greater than the desired duty cycle
    // and low otherwise
    assign out = counter > duty ? 0 : 1;
    
endmodule