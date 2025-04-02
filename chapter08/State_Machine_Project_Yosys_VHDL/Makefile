PROJ = State_Machine_Project

PIN_DEF = ../../Go_Board_Pin_Constraints.pcf
DEVICE = hx1k
PACKAGE = vq100

WORK_DIR = work

SRCS = ./Binary_To_7Segment.vhd \
	../../chapter06/Demux_Count_Project_VHDL/Count_And_Toggle.vhd \
	../../chapter05/Debounce_Filter.vhd \
	../../chapter06/Demux_LFSR_Project_VHDL/LFSR_22.vhd \
	../State_Machine_Project_VHDL/State_Machine_Game.vhd \
	../State_Machine_Project_VHDL/State_Machine_Project_Top.vhd \

all: upload

# synthesis
$(WORK_DIR)/$(PROJ).json: $(SRCS) $(WORK_DIR)
	yosys -m ghdl -p 'ghdl --std=08 $(SRCS) --workdir=$(WORK_DIR) -e $(PROJ)_Top; synth_ice40 -json $(WORK_DIR)/$(PROJ).json'

$(WORK_DIR):
	mkdir -p work

# place and route
$(WORK_DIR)/$(PROJ).asc: $(WORK_DIR)/$(PROJ).json $(PIN_DEF)
	nextpnr-ice40 --$(DEVICE) --package $(PACKAGE) --json $(WORK_DIR)/$(PROJ).json --pcf $(PIN_DEF) --asc $(WORK_DIR)/$(PROJ).asc

# create bin
$(WORK_DIR)/$(PROJ).bin: $(WORK_DIR)/$(PROJ).asc
	icepack $(WORK_DIR)/$(PROJ).asc $(WORK_DIR)/$(PROJ).bin

# upload design
upload: $(WORK_DIR)/$(PROJ).bin
	iceprog $(WORK_DIR)/$(PROJ).bin

clean:
	rm -r $(WORK_DIR)
