`timescale 1ns / 1ps

module top(clk, reset, inc, dec, pwm);
    input clk, reset, inc, dec;
    output pwm;
    
    // declare wires
    wire incwire, decwire;
    wire [15:0] duty;
    
    // instantiate input syncronization modules for push button user input
    blipgen inc_blipgen(.in(inc), .clk(clk), .reset(reset), .out(incwire));
    blipgen dec_blipgen(.in(dec), .clk(clk), .reset(reset), .out(decwire));
    
    // instatiate module to hold and modify the desired duty cycle number
    two_digit_counter u_two_digit_counter(.clk(clk), .reset(reset), .inc(incwire), .dec(decwire), .count(duty));
    
    // instantiate pwm module
    pwm u_pwm(.clk(clk), .reset(reset), .duty(duty), .out(pwm));
    
endmodule
