module read(empty,raddr,rptr,rclk,ren,rrstn,wptr);
    parameter A_SIZE = 4;

    output              empty;
    output [A_SIZE-1:0] raddr;
    output [A_SIZE  :0] rptr;
    input               rclk,ren,rrstn;
    input  [A_SIZE:0]   wptr;

    reg  [A_SIZE:0] bin_reg,gray_reg;
    wire [A_SIZE:0] bin_next,gray_next;
    reg  [A_SIZE:0] rwptr2,rwptr1;
    reg             empty_reg;

    assign bin_next  = bin_reg+{{A_SIZE-1{1'b0}},(ren&~empty)};
    assign gray_next = {1'b0,bin_next[A_SIZE:1]} ^ bin_next;

    always@(posedge rclk,negedge rrstn)
        if(!rrstn)
            {bin_reg,gray_reg}<=0;
        else
            {bin_reg,gray_reg}<={bin_next,gray_next};

    assign raddr = bin_reg[A_SIZE-1:0];
    assign rptr  = gray_reg;

    always@(posedge rclk,negedge rrstn)
        if(!rrstn)
            {rwptr2,rwptr1}<=0;
        else
            {rwptr2,rwptr1}<={rwptr1,wptr};

    always@(posedge rclk,negedge rrstn)
        if(!rrstn)
            empty_reg<=1;
        else
            empty_reg<=(rptr==rwptr2);

    assign empty=empty_reg;
endmodule


