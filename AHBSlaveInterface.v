
/*functionalities of this block are below  
-->pipeline logic of haddr,hwdata and hwrite (hwrite_reg,hwrite_reg_1)
-->valid
-->Temp_selx*/

module ahb_slave_interface(input hclk,hresetn,hwrite,hready_in,
input [1:0] htrans, input [31:0] hwdata,haddr,pr_data,
output reg hwrite_reg,hwrite_reg1,valid,
output [1:0] hresp,
output reg [31:0] hwdata1, hwdata2, haddr1, haddr2,
output [31:0] hr_data,
output reg [2:0] temp_selx);


always@(posedge hclk)
begin
if(!hresetn)
 begin
 haddr1<=0;
 haddr2<=0;
 end
else
 begin
 haddr1<=haddr;
 haddr2<=haddr1;
 end
end

always@(posedge hclk)
begin
if(!hresetn)
 begin
 hwdata1<=0;
 hwdata2<=0;
 end
else
 begin
 hwdata1<=hwdata;
 hwdata2<=hwdata1;
 end
end

always@(posedge hclk)
begin
if(!hresetn)
 begin
 hwrite_reg<=0;
 hwrite_reg1<=0;
 end
else
 begin
 hwrite_reg<=hwrite;
 hwrite_reg1<=hwrite_reg;
 end
end

/*2.conditions for valid=1 
1.hready_in==1, if and only if transaction is ready to takes place
2. haddr>=32'h8000_0000 && haddr<=32'h8c00_0000
for htran idle and busy are not fit for the transaction to be happen
so
3.htrans==2'b11 or 2'b10
*/

always@(*)
begin 
if(hready_in==1 && haddr>=32'h8000_0000 && haddr<=32'h8c00_0000 && htrans==2'b11 || htrans==2'b10)
  begin
  valid=1'b1;
  end
else
 begin
 valid=1'b0;
 end
end

/*3.peripheral mapping
temp_selx selects the appropriate peripheral (where temp_selx was like a enable signal a/c to the address mapping)*/
always@(*)
begin
if(haddr>=32'h8000_0000 && haddr<32'h8400_0000)
temp_selx=3'b001;
else if(haddr>=32'h8400_0000 && haddr<32'h8800_0000)
temp_selx=3'b010;
else if(haddr>=32'h8800_0000 && haddr<32'h8c00_0000)
temp_selx=3'b100;
else
temp_selx=3'b000;
end

assign hr_data=pr_data;
assign hresp=0;
endmodule 
