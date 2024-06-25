module fsmDelayCounter(
    input clk,
    input [31:0] len,
    output reg dn
    );
    
    reg [31:0] cnt;
    
    always@(posedge clk)
    begin
        if (cnt == len)
        begin 
            dn <= 1;
            cnt <= 0;
        end
        else
        begin
            cnt <= cnt + 1;
            dn <= 0;
        end
    end
endmodule
