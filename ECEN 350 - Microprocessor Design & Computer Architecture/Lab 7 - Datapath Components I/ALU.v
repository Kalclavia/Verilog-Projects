`define AND   4'b0000
`define OR    4'b0001
`define ADD   4'b0010
`define SUB   4'b0110
`define PassB 4'b0111


module ALU(BusW, BusA, BusB, ALUCtrl, Zero);
    
    output  [63:0] BusW;
    input   [63:0] BusA, BusB;
    input   [3:0] ALUCtrl;
    output reg  Zero;
    
    reg     [63:0] BusW;
    
    always @(ALUCtrl or BusA or BusB) begin
        case(ALUCtrl)
            `AND: begin
                assign BusW = BusA & BusB;
            end
            `OR: begin
                assign BusW = BusA | BusB;
            end
            `ADD: begin
                assign BusW = BusA + BusB;
            end
            `SUB: begin
                assign BusW = BusA - BusB;
            end
            `PassB: begin
                assign BusW = BusB;
            end
        endcase
        
            
    if(BusW ==64'b0)
        assign Zero = 1'b1;
    else
        assign Zero = 1'b0;
        
    end

        
endmodule
