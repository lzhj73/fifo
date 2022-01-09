module top();
    parameter D_SIZE=8;
    parameter A_SIZE=4;
    reg rstn;

    wire              wclk,wen;
    wire              rclk,ren;
    wire [D_SIZE-1:0] rdata,wdata;
    wire              empty,full;

    fifo #(
        .D_SIZE(D_SIZE),
        .A_SIZE(A_SIZE)
    ) dut(
        .rdata(rdata),
        .empty(empty),
        .full(full),
        .rclk(rclk),
        .ren(ren),
        .rrstn(rstn),
        .wclk(wclk),
        .wen(wen),
        .wrstn(rstn),
        .wdata(wdata)
    );

    send I_send(
        .wclk(wclk),
        .wen(wen),
        .wdata(wdata),
        .full(full),
        .rstn(rstn)
    );

    recive I_recive(
        .rclk(rclk),
        .ren(ren),
        .rdata(rdata),
        .empty(empty),
        .rstn(rstn)
    );
    
    initial begin
        rstn=1'b0;
        #40 rstn=1'b1;
        #800 $finish;
    end

    initial begin
        $fsdbDumpfile("test.fsdb");
        $fsdbDumpvars;
    end

endmodule


