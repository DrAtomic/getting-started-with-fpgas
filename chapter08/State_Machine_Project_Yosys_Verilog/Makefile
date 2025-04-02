PROJ = State_Machine_Project

PIN_DEF = ../../Go_Board_Pin_Constraints.pcf
DEVICE = hx1k
PACKAGE = vq100

WORK_DIR = work

SRCS = ../State_Machine_Project_Verilog/State_Machine_Project_Top.v \
	../State_Machine_Project_Verilog/Binary_To_7Segment.v \
	../State_Machine_Project_Verilog/State_Machine_Game.v \
	../../chapter06/Demux_Count_Project_Yosys_Verilog/Count_And_Toggle.v \
	../../chapter06/Demux_LFSR_Project_Verilog/LFSR_22.v \
	../../chapter05/Debounce_Filter.v

all: upload

# synthesis
$(WORK_DIR)/$(PROJ).json: $(SRCS) $(WORK_DIR)
	yosys -p 'synth_ice40 -top $(PROJ)_Top -json $(WORK_DIR)/$(PROJ).json' $(SRCS)

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
