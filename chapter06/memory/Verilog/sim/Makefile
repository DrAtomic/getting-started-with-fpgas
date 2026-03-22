all: RAM_2Port_TB RAM_1Port_TB FIFO_TB

RAM_2Port_TB: ../source/RAM_2Port.v RAM_2Port_TB.v
	iverilog -g2005-sv -o $@.vvp $^
	vvp $@.vvp

RAM_1Port_TB: ../source/RAM_1Port.v RAM_1Port_TB.v
	iverilog -g2005-sv -o $@.vvp $^
	vvp $@.vvp

FIFO_TB: ../source/RAM_2Port.v ../source/FIFO.v FIFO_TB.v
	iverilog -g2005-sv -o $@.vvp $^
	vvp $@.vvp
