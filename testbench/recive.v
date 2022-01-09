module recive(rclk,ren,rdata,rstn,empty);
    parameter D_SIZE=8;

    output reg         rclk,ren;
    input [D_SIZE-1:0] rdata;
    input              rstn,empty;

    initial begin
        rclk=1'b1;
        forever #10 rclk=~rclk;
    end

    always@(posedge rclk, negedge rstn)
        if(!rstn)
            ren = 1'b0;
        else if(!empty)
            ren = 1'b1;
endmodule
