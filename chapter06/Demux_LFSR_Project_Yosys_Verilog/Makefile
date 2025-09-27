PROJ = Demux_LFSR_Project

PIN_DEF = ../../Go_Board_Pin_Constraints.pcf
DEVICE = hx1k
PACKAGE = vq100

SRCS =  ../Demux_LFSR_Project_Verilog/LFSR_22.v \
	../Demux_LFSR_Project_Verilog/Demux_LFSR_Project_Top.v \
	../Mux_Demux/Demux_1_To_4.v

all: upload
synthesis: $(PROJ).json
place_and_route: $(PROJ).asc
create_bin: $(PROJ).bin

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
	rm -f $(PROJ).json $(PROJ).asc $(PROJ).bin
