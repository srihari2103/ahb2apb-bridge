
//apb_interface implementation
module apb_interface(input pwrite,penable,input [2:0] psel, input [31:0] pwdata,paddr,
output pwrite_out, penable_out, 
output [2:0] psel_out,
output [31:0] pwdata_out,paddr_out,
output reg [31:0] pr_data);

//except prdata the i/p data directly given to o/p ports
assign psel_out=psel;
assign pwrite_out=pwrite;
assign penable_out=penable;
assign paddr_out=paddr;
assign pwdata_out=pwdata;

always@(*)
begin
if(pwrite==0 && penable==1 ) //read transaction
pr_data={$random}%256; //random b/w 0-255
else
pr_data=0;
end

endmodule
