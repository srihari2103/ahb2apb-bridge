//input must be reg data type and no ports in tb

module top_tb();
reg hclk;
reg hresetn;


wire hr_readyout;
wire [31:0] hr_data, hwdata, haddr;
wire hwrite, hready_in;
wire [1:0] htrans,hresp;
//wire hwrite_reg,hwrite_reg1;
wire valid;
//wire [31:0] hwdata1,hwdata2, haddr1,hadrr2;
wire [31:0] pr_data,paddr,pwdata;
wire penable;
wire pwrite;
wire [2:0] psel;
//wire [2:0] temp_sel;

wire pwrite_out,penable_out;
wire [2:0] psel_out;
wire [31:0] paddr_out,pwdata_out;


/* write data type declarations for each port considered for bridge top and apb_controller */

ahb_master AHB (hclk,hresetn,hr_readyout, hr_data, haddr, hwdata,hwrite,
hready_in, htrans);

/*bridge_top BRIDGE (hclk, hresetn, hwrite, hready_in, htrans,hwdata,haddr,
pr_data, penable,pwrite, hr_readyout, psel,hresp, 
paddr, pwdata, hr_data);*/

apb_interface APB(pwrite,penable,psel,pwdata,paddr,pwrite_out, penable_out, 
psel_out,pwdata_out,paddr_out, pr_data);


/*apb_controller APB(hclk,hresetn,hwrite_reg,hwrite_reg1,hwrite,valid,
haddr, hwdata,hwdata1,hwdata2, haddr1,hadrr2,pr_data,temp_sel, 
penable,pwrite,hr_readyout, psel,paddr,pwdata);*/




/*initial
begin
hclk=1'b0;
#10 forever hclk=~hclk; //toggling of the data to get clk till simulation get finished
end*/

always
begin
#50;
hclk=1'b0;
#50;
hclk=1'b1;
end

task reset();
begin
@(negedge hclk); //at first neg edge of clk 
hresetn=0;
@(negedge hclk); //at 2nd neg edge of clk 
hresetn=1;
end
endtask

initial
begin
reset;
//AHB.single_write(); //function call 
//AHB.single_read();
//AHB.burst_4_incr_write;
//AHB.burst_4_wrap_write;
//AHB.burst_4_incr_read;
AHB.burst_4_wrap_read;
end
initial #1500 $finish;
endmodule


