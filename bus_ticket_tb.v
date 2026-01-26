`timescale 1ns / 1ps

module bus_ticket_tb();

wire ticket;
wire [7:0] fare;

reg [3:0] source, destination;
reg clk, rst, ON;

bus_ticket_machine dut (
    .ticket(ticket),
    .fare(fare),
    .ON(ON),
    .source(source),
    .destination(destination),
    .clk(clk),
    .rst(rst)
);
always #5 clk = ~clk;

initial begin
    clk = 1'b0;
    rst = 1'b1;
    ON  = 1'b0;
    source = 4'd0;
    destination = 4'd0;
    $monitor("Time=%0t | Source=%d Destination=%d Fare=%d Ticket=%b",
              $time, source, destination, fare, ticket);

    #10 rst = 1'b0;
    #10 source = 4'd2;
        destination = 4'd14;
    #10 ON = 1'b1;
    #10 ON = 1'b0;   
    #85 $finish;
end

endmodule
