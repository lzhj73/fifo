module mem(rdata,raddr,wclk,waddr,wdata,wen);
    parameter A_SIZE = 4;
    parameter D_SIZE = 8;
    localparam MEM_DEPTH = 1 << A_SIZE;

    output [D_SIZE-1:0] rdata;
    input [A_SIZE-1:0] raddr,waddr;
    input [D_SIZE-1:0] wdata;
    input wclk,wen;

    reg [D_SIZE-1:0] mem [0:MEM_DEPTH];
    always@(posedge wclk)
        if(wen)
            mem[waddr]<=wdata;

    assign rdata = mem[raddr];
endmodule
