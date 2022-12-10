# Stop any simulation that currently runnig
quit -sim
# if simulating with a MIF file, copy it.
if {[file exists ../Quartus/inst_mem.mif]} {
	file delete inst_mem.mif
	file copy ../Quartus/inst_mem.mif .
}

# create the default "work" library
vlib work;

# Compile the Source code in the code folder
vlog ../code/*.v 
# compile the Verilog code of the memory
vlog ../Quartus/RAM/*.v 
# Compile the verilog code  of the testbench 
vlog *.v 
# Start the simulator, including some libraries
vsim work.testbench -Lf 220model -Lf altera_mf_ver -Lf verilog
# show waveforms specified in wave.do
do wave.do
# Advance the simulation the desired amount of time
run 1 sec 