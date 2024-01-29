EXEC = top.sv PE.sv systolic3x3.sv fifo.sv
DIR = obj_dir
FLAGS = --timing --binary --trace

default:
	verilator --timing --binary --trace top.sv systolic3x3.sv

clean:
	rm -rf $(DIR)
	rm -rf ./c_code/main ./c_code/test ./c_code/tile
	

pe:
	verilator --timing --binary --trace PE.sv

systolic:
	verilator --timing --binary --trace top.sv systolic3x3.sv

sim:
	g++ -o ./c_code/main ./c_code/main.cpp
	./c_code/main | tee sim.txt

fifo:
	verilator $(FLAGS) FIFO_tb.sv fifo.sv
	# ./obj_dir/VFIFO_tb

mux:
	verilator $(FLAGS) MUX8_tb.sv MUX8.sv

controller:
	verilator $(FLAGS) controller_tb.sv controller.sv

test:
	g++ -o ./c_code/test ./c_code/process.cpp
	./c_code/test | tee sim.txt

tile_sim:
	g++ -o ./c_code/tile ./c_code/SA_TILE.cpp
	./c_code/tile | tee sim.txt

tile:
	verilator $(FLAGS) src/tile_tb.sv src/SYSTOLIC.sv
	

.PHONY: default clean pe systolic sim mux fifo test tile_sim tile