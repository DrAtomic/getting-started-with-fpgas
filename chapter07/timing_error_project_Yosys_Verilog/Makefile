PROJ = timing_error

PIN_DEF = ../../Go_Board_Pin_Constraints.pcf
DEVICE = hx1k
PACKAGE = vq100

SRCS = ../timing_error.v

all: $(PROJ).bin
synthesis: $(PROJ).json
place_and_route: $(PROJ).asc
create_bin: $(PROJ).bin

# synthesis
$(PROJ).json: $(SRCS)
	yosys -p 'synth_ice40 -top $(PROJ) -json $(PROJ).json' $(SRCS)

# place and route
$(PROJ).asc: $(PROJ).json $(PIN_DEF)
	nextpnr-ice40 --$(DEVICE) --package $(PACKAGE) --json $(PROJ).json --pcf $(PIN_DEF) --asc $(PROJ).asc --freq 10 --pcf-allow-unconstrained

# create bin
$(PROJ).bin: $(PROJ).asc
	icepack $(PROJ).asc $(PROJ).bin

# # upload design
# upload: $(PROJ).bin
# 	iceprog $(PROJ).bin

clean:
	rm -f $(PROJ).json $(PROJ).asc $(PROJ).bin
