
/* ahb master to generate the data for the protocol*/
module ahb_master(input hclk, hresetn, hreadyout, input [31:0] hrdata, output reg [31:0] haddr,hwdata,output reg hwrite,hready_in,output reg [1:0]htrans);
reg [2:0] hburst; //single,4,6... hready_in-write transfer and out-read operation
reg [2:0] hsize; //size 8/16 bits
integer i;

task single_write();
begin
@(posedge hclk)
#1;
begin
hwrite=1;
htrans=2'd2;
hsize=0;
hburst=0;
hready_in=1;
haddr=32'h8000_0000;
end

@(posedge hclk)
#1;
begin
hwdata=32'h24;
htrans=2'd0;
end

end
endtask

task single_read();
begin
@(posedge hclk)
#1;
begin
hwrite=0;
htrans=2'd2;
hsize=0;
hburst=0;
hready_in=1;
haddr=32'h8000_0000;
end

@(posedge hclk)
#1;
begin
htrans=2'd0;
end

end
endtask

task burst_4_incr_write(); //increement type
begin
 @(posedge hclk)
 #1;
 begin
  hwrite=1;
  htrans=2'd2;
  hsize=0;
  hburst=0;
  hready_in=1;
  haddr=32'h8000_0000;
 end

 @(posedge hclk)
 #1;
 begin
  haddr=haddr+1'b1;
  hwdata={$random}%256;//0-255 {} gives +ve values
  htrans=2'd3;
 end

 //for(i=0;i<2;i=i+1)
  //begin
   @(posedge hclk)
   #1;
   begin
    haddr=haddr+1'b1; 
    hwdata={$random}%256;//0-255 {} gives +ve values
    htrans=2'd3;
   end
   @(posedge hclk) //for 3rf and 4th clcok cycles both addr and data are same 
  //end
    begin
    end


   @(posedge hclk)
   #1;
   begin
    haddr=haddr+1'b1; 
    hwdata={$random}%256;//0-255 {} gives +ve values
    htrans=2'd3;
   end
   @(posedge hclk) //for 3rf and 4th clcok cycles both addr and data are same 
  //end
    begin
    end


 @(posedge hclk)
 #1;
 begin
  hwdata={$random}%256;//0-255 {} gives +ve values 
  htrans=2'd0; //iudle state 
 end
end
endtask



task burst_4_wrap_write(); //wrap write type
begin
 @(posedge hclk)
 #1;
 begin
  hwrite=1;
  htrans=2'd2;
  hsize=0;
  hburst=0;
  hready_in=1;
  haddr=32'h8000_0000;
 end

 @(posedge hclk)
 #1;
 begin
  haddr=32'h8000_0004;
  hwdata={$random}%256;//0-255 {} gives +ve values
  htrans=2'd3;
 end

 //for(i=0;i<2;i=i+1)
  //begin
   @(posedge hclk)
   #1;
   begin
    haddr=32'h8000_0008;
    hwdata={$random}%256;//0-255 {} gives +ve values
    htrans=2'd3;
   end
   @(posedge hclk) //for 3rf and 4th clcok cycles both addr and data are same 
  //end
    begin
    end


   @(posedge hclk)
   #1;
   begin
    haddr=32'h8000_0012; 
    hwdata={$random}%256;//0-255 {} gives +ve values
    htrans=2'd3;
   end
   @(posedge hclk) //for 3rf and 4th clcok cycles both addr and data are same 
  //end
    begin
    end


 @(posedge hclk)
 #1;
 begin
  hwdata={$random}%256;//0-255 {} gives +ve values 
  htrans=2'd0; //iudle state 
 end
end
endtask

//burst read


task burst_4_incr_read(); //increement type
begin
 @(posedge hclk)
 #1;
 begin
  hwrite=0;
  htrans=2'd2;
  hsize=0;
  hburst=0;
  hready_in=1;
  haddr=32'h8000_0000;
 end


 //for(i=0;i<2;i=i+1)
  //begin
   @(posedge hclk)
   #1;
   begin
    haddr=haddr+1'b1; 
    //hwdata={$random}%256;//0-255 {} gives +ve values
    htrans=2'd3;
   end
   @(posedge hclk) //for 3rf and 4th clcok cycles both addr and data are same 
  //end
    begin
    end


   @(posedge hclk)
   #1;
   begin
    haddr=haddr+1'b1; 
    //hwdata={$random}%256;//0-255 {} gives +ve values
    htrans=2'd3;
   end
   @(posedge hclk) //for 3rf and 4th clcok cycles both addr and data are same 
  //end
    begin
    end


 @(posedge hclk)
 #1;
 begin
  //hwdata={$random}%256;//0-255 {} gives +ve values 
  haddr=haddr+1'b1; 
  htrans=2'd3; //iudle state 
 end
 @(posedge hclk)
 begin
 end
 
 @(posedge hclk)
  begin
  htrans=2'd0;
  end

end
endtask


task burst_4_wrap_read(); //increement type
begin
 @(posedge hclk)
 #1;
 begin
  hwrite=0;
  htrans=2'd2;
  hsize=0;
  hburst=0;
  hready_in=1;
  haddr=32'h8000_0000;
 end


 //for(i=0;i<2;i=i+1)
  //begin
   @(posedge hclk)
   #1;
   begin
    haddr=32'h8000_0004;//{haddr[31:2]+haddr[1:0]+1'b1}; 
    //hwdata={$random}%256;//0-255 {} gives +ve values
    htrans=2'd3;
   end
   @(posedge hclk) //for 3rf and 4th clcok cycles both addr and data are same 
  //end
    begin
    end


   @(posedge hclk)
   #1;
   begin
    haddr=32'h8000_0008;//{haddr[31:2]+haddr[1:0]+1'b1}; 
    //hwdata={$random}%256;//0-255 {} gives +ve values
    htrans=2'd3;
   end
   @(posedge hclk) //for 3rf and 4th clcok cycles both addr and data are same 
  //end
    begin
    end


 @(posedge hclk)
 #1;
 begin
  //hwdata={$random}%256;//0-255 {} gives +ve values 
  haddr=32'h8000_0012;//{haddr[31:2]+haddr[1:0]+1'b1}; 
  htrans=2'd3;  
 end
 @(posedge hclk)
 begin
 end
 
 @(posedge hclk)
  begin
  htrans=2'd0;
  end

end
endtask
endmodule
















