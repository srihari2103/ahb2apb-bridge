module bridge_top (input hclk, hresetn, hwrite, hready_in, input[1:0] htrans, input [31:0] hwdata,haddr,pr_data, 
output penable,pwrite, hr_readyout, output [2:0] psel, output [1:0] hresp, output [31:0] paddr, pwdata, hr_data);

wire [31:0] hwdata1,hwdata2,haddr1, haddr2;//hwdata_2;
wire hwrite_reg,hwrite_reg1;
wire [2:0] temp_selx;
wire valid;

ahb_slave_interface Ahb_sl (hclk,hresetn,hwrite,hready_in,htrans,hwdata,haddr,pr_data,
hwrite_reg,hwrite_reg1,valid,hresp, hwdata1, hwdata2, haddr1, haddr2,hr_data,
temp_selx); //add hresp just incase error occurs
//if you have to change hwdata1 to hwdata_1 

apb_controller apb_c (hclk,hresetn,hwrite_reg,hwrite_reg1,hwrite,valid,
haddr, hwdata,hwdata1,hwdata2, haddr1,haddr2,pr_data,temp_selx, 
penable,pwrite,hr_readyout, psel,paddr,pwdata);


endmodule

//bridge top consists of 2 blocks which are ahb_slave_interface and apb_controller/*