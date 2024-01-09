EXEC = top.sv PE.sv systolic3x3.sv fifo.sv
DIR = obj_dir
FLAGS = --timing --binary --trace

default:
	verilator --timing --binary --trace $(EXEC)
	./obj_dir/Vtop | tee systolic-log.txt

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

fifo:
	verilator $(FLAGS) FIFO_tb.sv fifo.sv
	# ./obj_dir/VFIFO_tb

.PHONY: default clean pe systolic sim