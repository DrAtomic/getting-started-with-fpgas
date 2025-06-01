PROJ = State_Machine_Project

PIN_DEF = ../../Go_Board_Pin_Constraints.pcf
DEVICE = hx1k
PACKAGE = vq100

SRCS = ../State_Machine_Project_Verilog/State_Machine_Project_Top.v \
	../State_Machine_Project_Verilog/Binary_To_7Segment.v \
	../State_Machine_Project_Verilog/State_Machine_Game.v \
	../../chapter06/Demux_Count_Project_Yosys_Verilog/Count_And_Toggle.v \
	../../chapter06/Demux_LFSR_Project_Verilog/LFSR_22.v \
	../../chapter05/Debounce_Filter.v

all: upload

# synthesis
$(PROJ).json: $(SRCS)
	yosys -p 'synth_ice40 -top $(PROJ)_Top -json $(PROJ).json' $(SRCS)

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
