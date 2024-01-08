EXEC = top.sv PE.sv systolic3x3.sv
DIR = obj_dir
FLAGS = --timing --binar --trace

default:
	verilator --timing --binary --trace $(EXEC)

clean:
	rm -rf $(DIR)

pe:
	verilator --timing --binary --trace PE.sv

systolic:
	verilator --timing --binary --trace systolic3x3.sv

.PHONY: default clean pe systolic