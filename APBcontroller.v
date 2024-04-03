
module apb_controller(input hclk,hresetn,hwrite_reg,hwrite_reg1,hwrite,valid,
input[31:0] haddr, hwdata,hwdata1,hwdata2, haddr1,haddr2,pr_data,input [2:0] temp_sel, 
output reg penable,pwrite,output reg hr_readyout, output reg[2:0]psel, output reg[31:0]paddr,pwdata);


reg penable_temp,pwrite_temp,hr_readyout_temp;
reg [2:0] psel_temp;
reg [31:0] paddr_temp,pwdata_temp;

parameter  ST_IDLE=3'b000,
                ST_READ=3'b001,
                ST_WWAIT=3'b010,
                ST_WRITE=3'b011,
                ST_WRITEP=3'b100,
                ST_RENABLE=3'b101,
                ST_WENABLE=3'b110,
                ST_WENABLEP=3'b111;

reg[2:0] present,next;

//present state logic
always@(posedge hclk)
begin
 if(!hresetn)
  present<=ST_IDLE;
 else
  present<=next;
 end

//next state logic
always@(*)
 begin
 next=ST_IDLE;
 case(present)
ST_IDLE: if(valid==1 && hwrite==1)
                 next=ST_WWAIT;
                 else if(valid==1 && hwrite==0)
                 next=ST_READ;
                 else
                 next=ST_IDLE;
 ST_WWAIT: if(valid==1)
                       next=ST_WRITEP;
                       else
                       next=ST_WRITE;
 ST_READ: next=ST_RENABLE;
 ST_WRITE:if(valid==0)
                     next=ST_WENABLE;
                     else
                     next=ST_WENABLEP;
 ST_WRITEP:next=ST_WENABLEP;
 ST_RENABLE: if(valid==0)
                              next=ST_IDLE;
                              else if(valid==1 && hwrite==0)
                              next=ST_READ;
                              else 
                              next=ST_WWAIT;
  ST_WENABLE: if(valid==0)
                              next=ST_IDLE;
                              else if(valid==1 && hwrite==0)
                              next=ST_READ;
                              else 
                              next=ST_WWAIT;
  ST_WENABLEP:  if(valid==0 && hwrite_reg==1)
                next=ST_WRITE;
                else if(valid==1 && hwrite_reg==1)
                next=ST_WRITEP;
                else
                next=ST_READ;
                
       

endcase
end

//temporary o/p logic
always@(*)
begin
case(present)
ST_IDLE: if(valid==1 && hwrite==0) //when next state is read transaction
                begin
                 paddr_temp=haddr;
                 pwrite_temp=hwrite;
                 psel_temp=temp_sel;
                 penable_temp=0;
                 hr_readyout_temp=0;
                end
                else if(valid==1 && hwrite==1)
                begin
                 psel_temp=0;
                 penable_temp=0;
                 hr_readyout_temp=1;
                end
                else
                begin
                 psel_temp=0;
                 penable_temp=0;
                 hr_readyout_temp=1;
                end
ST_READ: begin
                 penable_temp=1;
                 hr_readyout_temp=1;
                 end

ST_RENABLE:if(valid==1 && hwrite==0) //read transaction same as idle state
                begin
                 paddr_temp=haddr;
                 pwrite_temp=hwrite;
                 psel_temp=temp_sel;
                 penable_temp=0;
                 hr_readyout_temp=0;
                end
                else if(valid==1 && hwrite==1)
                begin
                 psel_temp=0;
                 penable_temp=0;
                 hr_readyout_temp=1;
                end
                else
                begin
                 psel_temp=0;
                 penable_temp=0;
                 hr_readyout_temp=1;
                end


ST_WWAIT:begin
                   paddr_temp=haddr1; //1 cycle delay of haddr
                   pwdata_temp=hwdata;
                   pwrite_temp=hwrite;
                   psel_temp=temp_sel;
                   penable_temp=0;
                   hr_readyout_temp=0;
                   end
            
ST_WRITEP: begin
                       hr_readyout_temp=1;
                       penable_temp=1;
                       end

ST_WENABLEP: begin
             paddr_temp=haddr2; //haddr1 intially which was wrong given in the code
             pwdata_temp=hwdata;
             pwrite_temp=hwrite;
             psel_temp=temp_sel;
             penable_temp=0;
             hr_readyout_temp=0;
             end
             
ST_WENABLE:     if(valid==1 && hwrite==0) //read transaction same as idle state
                begin
                 paddr_temp=haddr;
                 pwrite_temp=hwrite;
                 psel_temp=temp_sel;
                 penable_temp=0;
                 hr_readyout_temp=0;
                end
                else if(valid==1 && hwrite==1)
                begin
                 psel_temp=0;
                 penable_temp=0;
                 hr_readyout_temp=1;
                end
                else
                begin
                 psel_temp=0;
                 penable_temp=0;
                 hr_readyout_temp=1;
                end

                       
                    
ST_WRITE: begin
                 penable_temp=1;
                 hr_readyout_temp=1;
                end

endcase
end





always@(posedge hclk)
begin
if(!hresetn)
begin
paddr<=0;
pwdata<=0;
pwrite<=0;
psel<=0;
penable<=0;
hr_readyout=1;
end

else
begin
paddr<=paddr_temp;
pwdata<=pwdata_temp;
pwrite<=pwrite_temp;
psel<=psel_temp;
penable<=penable_temp;
hr_readyout<=hr_readyout_temp;
end
end
endmodule




/*APB controller converts ahb transactiosn to APB transactions in bridge

APB to AHB transaction
 read,write
single read
burst read
single write
burst write
back to back(write and read consecutively)



verilog code: based on FSM of APB controller*/

     