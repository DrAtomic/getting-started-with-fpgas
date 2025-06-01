PROJ = Demux_Count_Project

PIN_DEF = ../../Go_Board_Pin_Constraints.pcf
DEVICE = hx1k
PACKAGE = vq100

SRCS =  ../Demux_Count_Project_VHDL/Count_And_Toggle.vhd \
	../Mux_Demux/Demux_1_To_4.vhd \
	../Demux_Count_Project_VHDL/Demux_Count_Project_Top.vhd

all: upload

# synthesis
$(PROJ).json: $(SRCS)
	yosys -m ghdl -p 'ghdl --std=08 $(SRCS) -e Demux_LFSR_Project_Top; synth_ice40 -json $(PROJ).json'

# place and route
$(PROJ).asc: $(PROJ).json $(PIN_DEF)
	nextpnr-ice40 --$(DEVICE) --package $(PACKAGE) --json $(PROJ).json --pcf $(PIN_DEF) --asc $(PROJ).asc

# create bin
$(PROJ).bin: $(PROJ).asc
	icepack $(PROJ).asc $(PROJ).bin

# upload design
upload: $(PROJ).bin
	iceprog $(PROJ).bin

clean:
	rm $(PROJ).json $(PROJ).asc $(PROJ).bin
