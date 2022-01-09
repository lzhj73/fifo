module send(wclk,wen,wdata,full,rstn);
    parameter D_SIZE = 8;

    output reg          wclk,wen;
    output [D_SIZE-1:0] wdata;
    input               full;
    input               rstn;

    initial begin
        wclk = 1'b0;
        forever #5 wclk = ~wclk;
    end

    reg [4:0] counter;
    always@(posedge wclk, negedge rstn)
        if(!rstn)
            counter <= 0;
        else if(wen&~full)
            counter <= counter + 1;

    always@(posedge wclk,negedge rstn)
        if(!rstn)
            wen <= 1'b0;
        else if(!full)
            wen <= 1'b1;
        else
            wen <= 1'b0;
    assign wdata = {{D_SIZE-5{1'b0}},counter};

endmodule


