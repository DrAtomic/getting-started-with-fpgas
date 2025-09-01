PROJ = Switches_To_LEDs

PIN_DEF = ../../Go_Board_Pin_Constraints.pcf
DEVICE = hx1k
PACKAGE = vq100

SRCS = ../Switches_To_LEDs.vhd

all: upload
synthesis: $(PROJ).json
place_and_route: $(PROJ).asc
create_bin: $(PROJ).bin

# synthesis
$(PROJ).json: $(SRCS)
	yosys -m ghdl -p 'ghdl --std=08 $(SRCS) -e $(PROJ); synth_ice40 -json $(PROJ).json'

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
