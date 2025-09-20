PROJ = Debounce_Project

PIN_DEF = ../../Go_Board_Pin_Constraints.pcf
DEVICE = hx1k
PACKAGE = vq100

SRCS = ../../chapter04/LED_Toggle_Project.vhd \
	../Debounce_Filter.vhd \
	../Debounce_Project_Top.vhd

all: upload
synthesis: $(PROJ).json
place_and_route: $(PROJ).asc
create_bin: $(PROJ).bin

# synthesis
$(PROJ).json: $(SRCS)
	yosys -m ghdl -p 'ghdl --std=08 $(SRCS) -e $(PROJ)_Top; synth_ice40 -json $(PROJ).json'

# place and route
$(PROJ).asc: $(PROJ).json $(PIN_DEF)
	nextpnr-ice40 --$(DEVICE) --package $(PACKAGE) --json $(PROJ).json --pcf $(PIN_DEF) --asc $(PROJ).asc

# create bin
$(PROJ).bin: $(PROJ).asc
	icepack $(PROJ).asc $(PROJ).bin

test:
	ghdl -a --std=08 $(SRCS) ../Debounce_Filter_TB.vhd
	ghdl -e --std=08 Debounce_Filter_TB
	ghdl -r --std=08 Debounce_Filter_TB --wave=$(PROJ).ghw

# upload design
upload: $(PROJ).bin
	iceprog $(PROJ).bin

clean:
	rm -f $(PROJ).json $(PROJ).asc $(PROJ).bin
