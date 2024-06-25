module varSpeedTop( // bidirectional variable speed DC motor control
    input clk,
    input reset,
    input [11:0] sw,
    input dir,
    output reg [1:0] pulseOut,
    output reg [1:0] motorOut
    );
    
    wire clk_out;
    wire [11:0] R;
    reg [11:0] cnt;
    assign R = sw;
    
    clk_5MHz inst
    (
        // Clock out ports  
        .clk_out1(clk_out),
        // Status and control signals               
        .reset(reset), 
        // Clock in ports
        .clk_in1(clk)
    );
    
    
    always@(posedge clk_out)
    begin
        cnt <= cnt + 1;  
    end
    
    always@(cnt, R, dir)
    begin
        if(cnt < R && dir)
        begin
            pulseOut[1] = 1;
            pulseOut[0] = 0;
            motorOut = 2'b01;
        end
        else if (cnt < R && ~dir)
        begin
            pulseOut[1] = 0;
            pulseOut[0] = 1;
            motorOut = 2'b10;
        end
        else
        begin
            motorOut = 2'b11;
            pulseOut[1] = 0;
            pulseOut[0] = 0;
        end
    end
    
endmodule
