Bridge top (AHB2APB Bridge) block diagram and functionality:
<div>
  <img alt="demo", src = ./Bridge top (AHB2APB Bridge) block diagram and functionality.png"/>
</div>
The AHB2APB bridge provides a connection between the Advanced High-Performance Bus (AHB) and Advanced Peripheral Bus (APB) in a system-on-chip (SoC) design. The bridge facilitates communication and coordination between the two bus protocols which are AHB and APB,enabling seamless data transfer and control. 

Bridge top module is a AHB slave which comprises of submodules called AHB slave interface and APB controller 
The functionalities of the AHB2APB bridge can be summarized with the following bullet points:
1. Bridge top involves in the translation of data of the AHB bus protocol used by high performance modules like CPU, DMA and on chip memories into the APB bus protocol used by low power peripherals like UART, keypad…
2. The bridge performs address mapping between the AHB address space and the APB address space. It translates AHB addresses to appropriate APB addresses, ensuring that the correct peripherals are selected and accessed.
3. The bridge handles data transfer between the AHB and APB buses. It manages read and write operations b/w bus protocols, passing data and control signals between the modules and peripherals.

AHB Master:


![AHB_master](https://github.com/Rakeshgupta2020/AHB2APB-Brdige-Implementation-uisng-verilog-HDL/assets/126176140/d767a4d3-7c04-4599-9ee6-287dbdc2f4d6)

1. AHB Master is the module which can access the bus in the protocol to perform read/write data transfer and communication between the modules, The master can be a CPU, DMA (Direct Memory Access) controller, or any other IP core that requires access to the system's resources.
2. It generates calculated address based on the type of transfer like single, burst etc and control signals for the transaction to be happened in return specifies which slave to be selected
3. In a multi-master system, where there are multiple AHB masters, the bus arbitration logic determines which master gets access to the bus when multiple masters request it simultaneously. The AHB master participates in the arbitration process to acquire the bus when it needs to perform a transaction.
4. The AHB master transfers data to or from the specified slave device or memory location. It handles the data transfer protocol and timing requirements specified by the AHB protocol.

APB Interface:


![APB_interface](https://github.com/Rakeshgupta2020/AHB2APB-Brdige-Implementation-uisng-verilog-HDL/assets/126176140/9bf9b04d-6c23-482f-a2c8-4f0b94a7f94a)

1. The APB (Advanced Peripheral Bus) is another bus protocol defined by ARM that is commonly used for connecting peripheral devices to the AHB bus in an SoC.
2. It transfers the data that is obtained from the bridge to the selected slave which is connected to the APB bus
3. Generates and transfers the data that is to be read by the AHB master from the selected slave based on the control signals.


Submodules

AHB slave interface:


![AHB_Slave_interface](https://github.com/Rakeshgupta2020/AHB2APB-Brdige-Implementation-uisng-verilog-HDL/assets/126176140/fe590e67-b6d2-40c7-bcb7-ac331be06956)

1. It performs pipelining logic of address, write data and write signals, involves in generating valid signal based on the slave address and other control signals and also involves in the peripheral mapping based on the slave address received by the AHB masters
2. It acts an interface between AHB master and APB controller

APB Controller:


![APB_controller](https://github.com/Rakeshgupta2020/AHB2APB-Brdige-Implementation-uisng-verilog-HDL/assets/126176140/2e296cd7-1710-42b7-9bfa-bf1cd4ec87eb)

1. The APB controller is a component that resides within the bridge and is responsible for managing the communication between the AHB (Advanced High-performance Bus) and APB (Advanced Peripheral Bus) interfaces. The APB controller performs various functionalities to ensure efficient and reliable data transfer between the two bus protocols. It acts as an interface between the AHB slave interface and the APB bus
2. It involves in the implementation of state machine for AHB to APB interface and generation of temporary logic which was the output of the control and data signals with one clock cycle ahead to the present and assigning the temporary logic to the actual
3. It plays a crucial role in the bridge to perform transfers in the correct way

Simulation Output Waveforms:
Bridge top output waveforms:
1. Single write:


![single_write](https://github.com/Rakeshgupta2020/AHB2APB-Brdige-Implementation-uisng-verilog-HDL/assets/126176140/5cc33cda-0388-4e73-ad68-a8c73deae089)

2. Single Read:


![single_read png ](https://github.com/Rakeshgupta2020/AHB2APB-Brdige-Implementation-uisng-verilog-HDL/assets/126176140/e5f67e6a-9973-4d3e-aa60-a92148f69bb0)

3. Burst write of increment-4 type:


![burst_write_inc](https://github.com/Rakeshgupta2020/AHB2APB-Brdige-Implementation-uisng-verilog-HDL/assets/126176140/da3c3212-fa20-4f96-8a05-02f87d1a883d)

4. Burst write of wrap4 type:


![burst_write_wrap](https://github.com/Rakeshgupta2020/AHB2APB-Brdige-Implementation-uisng-verilog-HDL/assets/126176140/1ff5a77a-9c6a-4619-b031-d9cbb4b77ccf)

5. Burst read of increment-4 type:

![burst_read_inc](https://github.com/Rakeshgupta2020/AHB2APB-Brdige-Implementation-uisng-verilog-HDL/assets/126176140/d131e2ba-652d-4540-a73e-2134e0e31c75)


6. Burst read of wrap4 type:

![burst_read_wrap png ](https://github.com/Rakeshgupta2020/AHB2APB-Brdige-Implementation-uisng-verilog-HDL/assets/126176140/dc077b5f-a25f-4141-b3b1-4a6d658fadce)


Synthesize output:


![synthesis_op](https://github.com/Rakeshgupta2020/AHB2APB-Brdige-Implementation-uisng-verilog-HDL/assets/126176140/f9b918fd-52f1-4580-9e56-12fd4277b94d)


State Machine:

![state_machine](https://github.com/Rakeshgupta2020/AHB2APB-Brdige-Implementation-uisng-verilog-HDL/assets/126176140/90848c67-929e-46a7-a7a9-d2b1c524ba97)



