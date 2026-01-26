`timescale 1ns / 1ps
module bus_ticket_machine(ticket, fare, ON, source, destination, clk, rst);

input clk, rst, ON;
input [3:0] source, destination;
output reg ticket;
output reg [7:0] fare;

reg [3:0] s,d;

reg[2:0] state;
parameter start= 3'b000, sel_source=3'b001, sel_destination=3'b010, price=3'b011, done=3'b100;

always@(posedge clk)
begin

if (rst) 
begin
state  <= start;
s <= 4'd0;
d <= 4'd0;
fare<=8'd0;
ticket<=1'b0;
end

else
begin
case(state)
start: begin
       ticket<=1'b0;
       fare<=8'd0;
       if(ON) state<=sel_source;
       end
sel_source: begin
            s<=source;
            state<=sel_destination;
            end
sel_destination: begin
                 d<=destination;
                 state<=price;
                 end        
price: begin
       if(s>d)
       begin
       fare<=((s-d)*10);
       state<=done;
       end
       else
       begin
       fare<=((d-s)*10);
       state<=done;
       end
       end
done: begin
      ticket<=1'b1;
      state<=start;
      end

default: state<=start;

endcase
end
end
endmodule


