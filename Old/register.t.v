`timescale 1 ns / 1 ps
`include "register.v"

module testALU();
    reg[31:0] operandA, operandB;
    reg[2:0] command;
    wire[31:0] result;
    wire carryout, zero, overflow;

    ALU myALU (result, carryout, zero, overflow, operandA, operandB, command);

    initial begin
    //dump to vcd file so we can look at waveform
    $dumpfile("alu.vcd");
    $dumpvars(0, testALU);

    $display("   operandA   operandB   |  command   ||  zero   carryout   overflow  | result ||   Exp zero   Exp carryout   Exp overflow   |   Exp result");

    $display("Adder Test:");

    // this is our test bench
    operandA=32'b11;operandB=32'b101; #1000
    $display(" %b %b |  %b      ||      %b    %b    %b    %b   |     %b     ||     0     0     0     |   0 ", operandA, operandB, command, zero, carryout, overflow, result);

    $display("Control Test:");
    operandA=32'b11;operandB=32'b101; #1000
    $display(" %b %b |  %b      ||      %b    %b    %b    %b   |     %b     ||     0     0     0     |   0 ", operandA, operandB, command, zero, carryout, overflow, result);
    end
endmodule

