`timescale 1ns / 1ps

// idk why i called this module two digit counter, but this module's
// purpose is to hold and modfy the desired duty cycle number that is
// used in the pwm module
module two_digit_counter(clk, reset, inc, dec, count);
    input clk, reset, inc, dec;
    output reg [16:0] count;
    
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            count = 0;
        end
        else begin
            // the following increments and decrements by 2000 because
            // 2000 is 2% of the max counter number (100000). Therefore,
            // this module allows the user to determine the desired duty
            // cycle by +/- 2%
            //
            // 100,000 is used for 1Khz because the Nexys 4 DDR has 100Mhz
            // base clock
            if (inc && count < 100000)
                count = count + 2000;
            else if (dec && count > 0)
                count = count - 2000;
            else
                count = count;
        end
    end
endmodule
