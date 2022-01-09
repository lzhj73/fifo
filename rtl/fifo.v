module fifo(rdata,full,empty,rclk,ren,rrstn,wclk,wen,wrstn,wdata);
    parameter D_SIZE = 8;
    parameter A_SIZE = 4;

    output [D_SIZE-1:0] rdata;
    output              full,empty;
    input               rclk,ren,rrstn;
    input               wclk,wen,wrstn;
    input  [D_SIZE-1:0] wdata;

    wire [A_SIZE-1:0] raddr,waddr;
    wire [A_SIZE  :0] rptr,wptr;

    mem #(
        .D_SIZE(D_SIZE),
        .A_SIZE(A_SIZE)
    ) I_mem(
        .rdata(rdata),
        .raddr(raddr),
        .wclk(wclk),
        .wen(wen),
        .wdata(wdata),
        .waddr(waddr)
    );

    read #(
        .A_SIZE(A_SIZE)
    ) I_read(
        .empty(empty),
        .raddr(raddr),
        .rptr(rptr),
        .rclk(rclk),
        .wptr(wptr),
        .rrstn(rrstn),
        .ren(ren)
    );

    write #(
        .A_SIZE(A_SIZE)
    ) I_write(
        .full(full),
        .waddr(waddr),
        .wptr(wptr),
        .wclk(wclk),
        .wrstn(wrstn),
        .rptr(rptr),
        .wen(wen)
    );

endmodule




