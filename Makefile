EXEC = top.sv PE.sv systolic3x3.sv
DIR = obj_dir
FLAGS = --timing --binar --trace

default:
	verilator --timing --binary --trace $(EXEC)

clean:
	rm -rf $(DIR)
	rm -rf ./c_code/main

pe:
	verilator --timing --binary --trace PE.sv

systolic:
	verilator --timing --binary --trace systolic3x3.sv

sim:
	g++ -o ./c_code/main ./c_code/main.cpp
	./c_code/main

.PHONY: default clean pe systolic sim