`timescale 1 ns / 1 ps
`include "newalu2.v"
/*include "genvartest.v"*/

/*
module testmux();

    //tests the mux: MUX WORKS!
    wire [31:0] result;
    reg [2:0] muxindex;
    reg [31:0] andResult, orResult, xorResult, addResult;
    reg [31:0]sltResult;


    structuralMultiplexer mymux(result, muxindex, andResult, orResult, xorResult, addResult, sltResult);
    initial begin
    //$display("  muxindex   result    |   expected result");

    $dumpfile("testmux.vcd");
    $dumpvars;

    muxindex = 0; andResult=32'd1; orResult=32'd2; xorResult=32'd3; addResult=32'd4; sltResult=0; #1000000000
    $display(" Test   | muxindex   result    | expected result");
    $display("Add/Sub |    %h      %h   |    %h ", muxindex, result, addResult);
    muxindex = 1; andResult=32'd1; orResult=32'd2; xorResult=32'd3; addResult=32'd4; sltResult=0; #1000000000
    $display("  Xor   |    %h      %h   |    %h ", muxindex, result, xorResult);
    muxindex = 2; andResult=32'd1; orResult=32'd2; xorResult=32'd3; addResult=32'd4; sltResult=0; #1000000000
    $display("  SLT   |    %h      %h   |    %h ", muxindex, result, sltResult);
    muxindex = 3; andResult=32'd6; orResult=32'd2; xorResult=32'd3; addResult=32'd4; sltResult=0; #1000000000
    $display("And/Nor |    %h      %h   |    %h ", muxindex, result, andResult);
    muxindex = 4; andResult=32'd1; orResult=32'd2; xorResult=32'd3; addResult=32'd4; sltResult=0; #1000000000
    $display("Or/Nand |    %h      %h   |    %h ", muxindex, result, orResult);
    end*/
   // endmodule

/*
module testlut();

    //tests the mux: MUX WORKS!
    wire[2:0] muxindex;
    wire invertA;
    wire invertB;
    wire enableOverflow;
    wire carryin;
    reg[2:0] ALUcommand;


    ALUcontrolLUT myLUT(muxindex, invertA, invertB, enableOverflow, carryin, ALUcommand);
    initial begin
    $display(" muxindex invertA invertB enableOverflow carryin ALUcommand ");
    ALUcommand=3'b000; #1000000000
    $display("     %h       %h       %h           %h           %h        %h  ", muxindex, invertA, invertB, enableOverflow, carryin, ALUcommand);
    ALUcommand=3'b001; #1000000000
    $display("     %h       %h       %h           %h           %h        %h  ", muxindex, invertA, invertB, enableOverflow, carryin, ALUcommand);
    ALUcommand=3'b010; #1000000000
    $display("     %h       %h       %h           %h           %h        %h  ", muxindex, invertA, invertB, enableOverflow, carryin, ALUcommand);
    ALUcommand=3'b011; #1000000000
    $display("     %h       %h       %h           %h           %h        %h  ", muxindex, invertA, invertB, enableOverflow, carryin, ALUcommand);
    ALUcommand=3'b100; #1000000000
    $display("     %h       %h       %h           %h           %h        %h  ", muxindex, invertA, invertB, enableOverflow, carryin, ALUcommand);
    ALUcommand=3'b101; #1000000000
    $display("     %h       %h       %h           %h           %h        %h  ", muxindex, invertA, invertB, enableOverflow, carryin, ALUcommand);
    ALUcommand=3'b110; #1000000000
    $display("     %h       %h       %h           %h           %h        %h  ", muxindex, invertA, invertB, enableOverflow, carryin, ALUcommand);
    ALUcommand=3'b111; #1000000000
    $display("     %h       %h       %h           %h           %h        %h  ", muxindex, invertA, invertB, enableOverflow, carryin, ALUcommand);
    end*/





module testalu();

    //tests the mux: MUX WORKS!
    wire[31:0]    result;
    wire          carryout;
    wire          zero;
    wire          overflow;
    reg[31:0]     operandA;
    reg[31:0]     operandB;
    reg[2:0]      command;


    ALU myALU( result, carryout, zero, overflow, operandA, operandB, command);
    initial begin

    //dump to vcd file so we can look at waveform
    $dumpfile("newALU2.vcd");
    $dumpvars(0, myALU);

    $display("Testing ADD operation: simple, negative, carryout, and overflow.");
    $display("command  operandA  operandB |  result  carryout zero overflow | expected result");
    
    command=3'b000; operandA=32'h10000000; operandB=32'h10000000; #100000000000 //simple
    $display("   %h     %h  %h | %h     %h      %h      %h    |    20000000", command, operandA, operandB, result, carryout, zero, overflow);
    command=3'b000; operandA=32'h00000001; operandB=32'h00000003; #100000000000 //simple
    $display("   %h     %h  %h | %h     %h      %h      %h    |    00000004", command, operandA, operandB, result, carryout, zero, overflow);
    command=3'b000; operandA=32'h100f0001; operandB=32'h10020003; #100000000000 //simple
    $display("   %h     %h  %h | %h     %h      %h      %h    |    20110004", command, operandA, operandB, result, carryout, zero, overflow);

    command=3'b000; operandA=32'h8ffffff3; operandB=32'h10000600; #100000000000 //negative and positive
    $display("   %h     %h  %h | %h     %h      %h      %h    |    a00005f3", command, operandA, operandB, result, carryout, zero, overflow);
    command=3'b000; operandA=32'h00000001; operandB=32'h80000003; #100000000000 
    $display("   %h     %h  %h | %h     %h      %h      %h    |    80000004", command, operandA, operandB, result, carryout, zero, overflow);
    command=3'b000; operandA=32'h800f0001; operandB=32'h10020003; #100000000000
    $display("   %h     %h  %h | %h     %h      %h      %h    |    90110004", command, operandA, operandB, result, carryout, zero, overflow);

    command=3'b000; operandA=32'h80fffff3; operandB=32'h80000600; #100000000000 //negative and negative, carryout and overflow
    $display("   %h     %h  %h | %h     %h      %h      %h    |    010005f3", command, operandA, operandB, result, carryout, zero, overflow);
    command=3'b000; operandA=32'h80000001; operandB=32'h90000003; #100000000000 
    $display("   %h     %h  %h | %h     %h      %h      %h    |    10000004", command, operandA, operandB, result, carryout, zero, overflow);
    command=3'b000; operandA=32'hf00f0001; operandB=32'hf0020003; #100000000000 
    $display("   %h     %h  %h | %h     %h      %h      %h    |    e0110004", command, operandA, operandB, result, carryout, zero, overflow);
    command=3'b000; operandA=32'h7FFFFFFF; operandB=32'h7FFFFFFF; #100000000000 //overflow
    $display("   %h     %h  %h | %h     %h      %h      %h    |    fffffffe", command, operandA, operandB, result, carryout, zero, overflow);

    $display("Testing SUBTRACT operation: simple, negative, carryout, and overflow.");
    $display("command  operandA  operandB |  result  carryout zero overflow | expected result");
    command=3'b001; operandA=32'h10000000; operandB=32'h10000000; #100000000000 //simple
    $display("   %h     %h  %h | %h     %h      %h      %h    |    00000000", command, operandA, operandB, result, carryout, zero, overflow);
    command=3'b001; operandA=32'h00000001; operandB=32'h00000003; #100000000000 //simple
    $display("   %h     %h  %h | %h     %h      %h      %h    |    fffffffe", command, operandA, operandB, result, carryout, zero, overflow);
    command=3'b001; operandA=32'h100f0001; operandB=32'h10020003; #100000000000 //simple
    $display("   %h     %h  %h | %h     %h      %h      %h    |    000cfffe", command, operandA, operandB, result, carryout, zero, overflow);

    command=3'b001; operandA=32'h8ffffff3; operandB=32'h10000600; #100000000000 //negative and positive
    $display("   %h     %h  %h | %h     %h      %h      %h    |    7ffff9f3", command, operandA, operandB, result, carryout, zero, overflow);
    command=3'b001; operandA=32'h800f0001; operandB=32'h10020003; #100000000000
    $display("   %h     %h  %h | %h     %h      %h      %h    |    700cfffe", command, operandA, operandB, result, carryout, zero, overflow);

    command=3'b001; operandA=32'h80fffff3; operandB=32'h80000600; #100000000000 //negative and negative, carryout and overflow
    $display("   %h     %h  %h | %h     %h      %h      %h    |    00fff9f3", command, operandA, operandB, result, carryout, zero, overflow);
    command=3'b001; operandA=32'h80000001; operandB=32'h90000003; #100000000000 
    $display("   %h     %h  %h | %h     %h      %h      %h    |    effffffe", command, operandA, operandB, result, carryout, zero, overflow);
    command=3'b001; operandA=32'hf00f0001; operandB=32'hf0020003; #100000000000 
    $display("   %h     %h  %h | %h     %h      %h      %h    |    000cfffe", command, operandA, operandB, result, carryout, zero, overflow);

    $display("Testing XOR operation");
    $display("command  operandA  operandB |  result  carryout zero overflow | expected result");
    command=3'b010; operandA=32'h10000000; operandB=32'h10000000; #100000000000 //simple
    $display("   %h     %h  %h | %h     %h      %h      %h    |    00000000", command, operandA, operandB, result, carryout, zero, overflow);
    command=3'b010; operandA=32'h00000001; operandB=32'h00000003; #100000000000 //simple
    $display("   %h     %h  %h | %h     %h      %h      %h    |    00000002", command, operandA, operandB, result, carryout, zero, overflow);
    command=3'b010; operandA=32'h100f0001; operandB=32'h10020003; #100000000000 //simple
    $display("   %h     %h  %h | %h     %h      %h      %h    |    000d0002", command, operandA, operandB, result, carryout, zero, overflow);

    $display("Testing SLT operation");
    $display("command  operandA  operandB |  result  carryout zero overflow | expected result");
    command=3'b011; operandA=32'h10000000; operandB=32'h10000000; #100000000000 //simple
    $display("   %h     %h  %h | %h     %h      %h      %h    |    00000000", command, operandA, operandB, result, carryout, zero, overflow);
    command=3'b011; operandA=32'h00000001; operandB=32'h00000003; #100000000000 //simple
    $display("   %h     %h  %h | %h     %h      %h      %h    |    ffffffff", command, operandA, operandB, result, carryout, zero, overflow);
    command=3'b011; operandA=32'h100f0001; operandB=32'h10020003; #100000000000 //simple
    $display("   %h     %h  %h | %h     %h      %h      %h    |    00000000", command, operandA, operandB, result, carryout, zero, overflow);
    command=3'b011; operandA=32'hf0000000; operandB=32'hf0000000; #100000000000 //simple
    $display("   %h     %h  %h | %h     %h      %h      %h    |    00000000", command, operandA, operandB, result, carryout, zero, overflow);
    command=3'b011; operandA=32'hf0000001; operandB=32'h10000003; #100000000000 //simple
    $display("   %h     %h  %h | %h     %h      %h      %h    |    ffffffff", command, operandA, operandB, result, carryout, zero, overflow);
    command=3'b011; operandA=32'hf0000001; operandB=32'hf0000003; #100000000000 //simple
    $display("   %h     %h  %h | %h     %h      %h      %h    |    00000000", command, operandA, operandB, result, carryout, zero, overflow);

    $display("Testing AND operation");
    $display("command  operandA  operandB |  result  carryout zero overflow | expected result");
    command=3'b100; operandA=32'h10000003; operandB=32'h10000001; #100000000000 //simple
    $display("   %h     %h  %h | %h     %h      %h      %h    |    10000001", command, operandA, operandB, result, carryout, zero, overflow);
    command=3'b100; operandA=32'hffffffff; operandB=32'heeeeeeee; #100000000000 //simple
    $display("   %h     %h  %h | %h     %h      %h      %h    |    eeeeeeee", command, operandA, operandB, result, carryout, zero, overflow);
    command=3'b100; operandA=32'h100f0001; operandB=32'h10020003; #100000000000 //simple
    $display("   %h     %h  %h | %h     %h      %h      %h    |    10020001", command, operandA, operandB, result, carryout, zero, overflow);

    $display("Testing NAND operation");
    $display("command  operandA  operandB |  result  carryout zero overflow | expected result");
    command=3'b101; operandA=32'h10000003; operandB=32'h10000001; #100000000000 //simple
    $display("   %h     %h  %h | %h     %h      %h      %h    |    effffffe", command, operandA, operandB, result, carryout, zero, overflow);
    command=3'b101; operandA=32'hffffffff; operandB=32'heeeeeeee; #100000000000 //simple
    $display("   %h     %h  %h | %h     %h      %h      %h    |    11111111", command, operandA, operandB, result, carryout, zero, overflow);
    command=3'b101; operandA=32'h100f0001; operandB=32'h10020003; #100000000000 //simple
    $display("   %h     %h  %h | %h     %h      %h      %h    |    effdfffe", command, operandA, operandB, result, carryout, zero, overflow);
    

    $display("Testing NOR operation");
    $display("command  operandA  operandB |  result  carryout zero overflow | expected result");
    command=3'b110; operandA=32'h10000003; operandB=32'h10000001; #100000000000 //simple
    $display("   %h     %h  %h | %h     %h      %h      %h    |    effffffc", command, operandA, operandB, result, carryout, zero, overflow);
    command=3'b110; operandA=32'hffffffff; operandB=32'heeeeeeee; #100000000000 //simple
    $display("   %h     %h  %h | %h     %h      %h      %h    |    00000000", command, operandA, operandB, result, carryout, zero, overflow);
    command=3'b110; operandA=32'h100f0001; operandB=32'h10020003; #100000000000 //simple
    $display("   %h     %h  %h | %h     %h      %h      %h    |    eff0fffc", command, operandA, operandB, result, carryout, zero, overflow);


    $display("Testing OR operation");
    $display("command  operandA  operandB |  result  carryout zero overflow | expected result");
    command=3'b111; operandA=32'h10001003; operandB=32'h10000001; #100000000000 //simple
    $display("   %h     %h  %h | %h     %h      %h      %h    |    10001003", command, operandA, operandB, result, carryout, zero, overflow);
    command=3'b111; operandA=32'hffffffff; operandB=32'heeeeeeee; #100000000000 //simple
    $display("   %h     %h  %h | %h     %h      %h      %h    |    ffffffff", command, operandA, operandB, result, carryout, zero, overflow);
    command=3'b111; operandA=32'h100f0001; operandB=32'h10020003; #100000000000 //simple
    $display("   %h     %h  %h | %h     %h      %h      %h    |    100f0003", command, operandA, operandB, result, carryout, zero, overflow);
    end

endmodule

/*module testand();
    wire carryout;
    wire overflow;
    wire[31:0] andResult;
    reg [31:0] operandA;
    reg [31:0] operandB;


    and32 myALU (carryout, overflow, andResult, operandA, operandB);

    initial begin
    //dump to vcd file so we can look at waveform
    $dumpfile("alu.vcd");
    $dumpvars(0, testand);
    $display(" operandA   operandB  |  result  ||   Exp result");

    operandA='h0;operandB='h0; #1000
    $display(" %h   %h  | %h ||    00000000", operandA,operandB,  andResult);
    operandA='h181;operandB='h263; #1000
    $display(" %b   %b  | %b ||    00000001", operandA,operandB,  andResult);
    operandA='h161;operandB='h161; #1000
    $display(" %h   %h  | %h ||    00000161", operandA,operandB,  andResult);
    operandA='hffffffff;operandB='hf00f001; #1000
    $display(" %h   %h  | %h ||    0f00f001", operandA,operandB,  andResult);
    operandA='hffff0fff;operandB='hffffffff; #1000
    $display(" %h   %h  | %h ||    cccccccc", operandA,operandB,  andResult);
    end
    */
//endmodule
