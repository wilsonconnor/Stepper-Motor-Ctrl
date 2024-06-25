module fullStepTop( // Full-Step Control (Bi-directional)

    input clk,
    input run,
    input flip,
    output reg [3:0] stepOut,
    output reg [1:0] state
    );
    
    localparam step1 = 0,
                step2 = 1,
                step3 = 2,
                step4 = 3;
                
    wire dn;
    localparam delayCnt = 500000;
                
    fsmDelayCounter counter(.clk(clk), .dn(dn), .len(delayCnt));
    
    always@(posedge clk)
        begin
            case(state)
            step1:
                begin
                    if(run && dn && flip)
                    begin
                        state <= step4;
                    end
                    else if(run && dn)
                    begin
                        state <= step2;
                    end
                end
            step2:
                begin
                    if(run && dn && flip)
                    begin
                        state <= step1;
                    end
                    else if(run && dn)
                    begin
                        state <= step3;
                    end
                end
            step3:
                begin
                    if(run && dn && flip)
                    begin
                        state <= step2;
                    end
                    else if(run && dn)
                    begin
                        state <= step4;
                    end
                end
            step4:
                begin
                    if(run && dn && flip)
                    begin
                        state <= step3;
                    end
                    else if(run && dn)
                    begin
                        state <= step1;
                    end
                end
            endcase
        end
    
    
    always@(state)
        begin
            case(state)
                step1: stepOut = 4'b0101;
                step2: stepOut = 4'b0110;
                step3: stepOut = 4'b1010;
                step4: stepOut = 4'b1001;
            endcase
        end
endmodule
