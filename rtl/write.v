module write(full,waddr,wptr,wclk,wen,wrstn,rptr);
    parameter A_SIZE = 4;

    output              full;
    output [A_SIZE-1:0] waddr;
    output [A_SIZE  :0] wptr;
    input               wclk,wen,wrstn;
    input  [A_SIZE:0]   rptr;

    reg  [A_SIZE:0] bin_reg,gray_reg;
    wire [A_SIZE:0] bin_next,gray_next;
    reg  [A_SIZE:0] wrptr2,wrptr1;
    reg             full_reg;

    assign bin_next  = bin_reg+{{A_SIZE-1{1'b0}},(wen&~full)};
    assign gray_next = {1'b0,bin_next[A_SIZE:1]} ^ bin_next;

    always@(posedge wclk,negedge wrstn)
        if(!wrstn)
            {bin_reg,gray_reg}<=0;
        else
            {bin_reg,gray_reg}<={bin_next,gray_next};

    assign waddr = bin_reg[A_SIZE-1:0];
    assign wptr  = gray_reg;

    always@(posedge wclk,negedge wrstn)
        if(!wrstn)
            {wrptr2,wrptr1}<=0;
        else
            {wrptr2,wrptr1}<={wrptr1,rptr};

    always@(posedge wclk,negedge wrstn)
        if(!wrstn)
            full_reg<=1'b0;
        else
            full_reg<=(wptr[A_SIZE]!=wrptr2[A_SIZE])&&(wptr[A_SIZE-1]!=wrptr2[A_SIZE-1])&&(wptr[A_SIZE-2:0]==wrptr2[A_SIZE-2:0]);

    assign full=full_reg;
endmodule


