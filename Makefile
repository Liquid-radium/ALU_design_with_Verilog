SIM = icarus
TOPLEVEL_LANG = verilog
VERILOG_SOURCES = $(PWD)/ALU.v $(PWD)/ALU_modules.v
TOPLEVEL = alu
MODULE = testbench
WAVES = 1
include $(shell cocotb-config --makefiles)/Makefile.sim