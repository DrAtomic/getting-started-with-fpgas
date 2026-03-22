all: RAM_2Port_TB RAM_1Port_TB FIFO_TB

RAM_2Port_TB: ../source/RAM_2Port.vhd RAM_2Port_TB.vhd
	ghdl -a --std=08 $^
	ghdl -e --std=08 $@
	ghdl -r --std=08 $@ --wave=$@.ghw

RAM_1Port_TB: ../source/RAM_1Port.vhd RAM_1Port_TB.vhd
	ghdl -a --std=08 $^
	ghdl -e --std=08 $@
	ghdl -r --std=08 $@ --wave=$@.ghw

FIFO_TB: ../source/RAM_2Port.vhd ../source/FIFO.vhd FIFO_TB.vhd
	ghdl -a --std=08 $^
	ghdl -e --std=08 $@
	ghdl -r --std=08 $@ --wave=$@.ghw
