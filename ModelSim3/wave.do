onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/clock
add wave -noupdate /testbench/reset
add wave -noupdate /testbench/run
add wave -noupdate /testbench/leds
add wave -noupdate /testbench/done
add wave -noupdate -radix unsigned /testbench/DUT/U0/Tstep_Q
add wave -noupdate -radix hexadecimal /testbench/DUT/U0/ADDR
add wave -noupdate /testbench/DUT/U0/DOUT
add wave -noupdate /testbench/DUT/U0/ADDR_in
add wave -noupdate /testbench/DUT/U0/BusWires
add wave -noupdate /testbench/DUT/U0/IR
add wave -noupdate -radix hexadecimal /testbench/DUT/U0/R7
add wave -noupdate -radix hexadecimal /testbench/DUT/U0/R5
add wave -noupdate -radix unsigned /testbench/DUT/U0/R4
add wave -noupdate -radix hexadecimal /testbench/DUT/U0/R3
add wave -noupdate -radix hexadecimal /testbench/DUT/U0/R2
add wave -noupdate -radix hexadecimal /testbench/DUT/U0/R1
add wave -noupdate -radix hexadecimal /testbench/DUT/U0/R0
add wave -noupdate /testbench/DUT/DIN
add wave -noupdate /testbench/DUT/U0/incr_pc
add wave -noupdate /testbench/DUT/U0/W
add wave -noupdate /testbench/DUT/wren
add wave -noupdate /testbench/DUT/len
add wave -noupdate /testbench/DUT/U1/wren
add wave -noupdate /testbench/DUT/U1/q
add wave -noupdate /testbench/DUT/U1/data
add wave -noupdate /testbench/DUT/U0/W_D
add wave -noupdate {/testbench/DUT/U0/Rin[7]}
add wave -noupdate -radix unsigned /testbench/DUT/U0/G
add wave -noupdate -divider PC
add wave -noupdate -radix unsigned -childformat {{{/testbench/DUT/U0/pc7/PC[8]} -radix unsigned} {{/testbench/DUT/U0/pc7/PC[7]} -radix unsigned} {{/testbench/DUT/U0/pc7/PC[6]} -radix unsigned} {{/testbench/DUT/U0/pc7/PC[5]} -radix unsigned} {{/testbench/DUT/U0/pc7/PC[4]} -radix unsigned} {{/testbench/DUT/U0/pc7/PC[3]} -radix unsigned} {{/testbench/DUT/U0/pc7/PC[2]} -radix unsigned} {{/testbench/DUT/U0/pc7/PC[1]} -radix unsigned} {{/testbench/DUT/U0/pc7/PC[0]} -radix unsigned}} -subitemconfig {{/testbench/DUT/U0/pc7/PC[8]} {-height 15 -radix unsigned} {/testbench/DUT/U0/pc7/PC[7]} {-height 15 -radix unsigned} {/testbench/DUT/U0/pc7/PC[6]} {-height 15 -radix unsigned} {/testbench/DUT/U0/pc7/PC[5]} {-height 15 -radix unsigned} {/testbench/DUT/U0/pc7/PC[4]} {-height 15 -radix unsigned} {/testbench/DUT/U0/pc7/PC[3]} {-height 15 -radix unsigned} {/testbench/DUT/U0/pc7/PC[2]} {-height 15 -radix unsigned} {/testbench/DUT/U0/pc7/PC[1]} {-height 15 -radix unsigned} {/testbench/DUT/U0/pc7/PC[0]} {-height 15 -radix unsigned}} /testbench/DUT/U0/pc7/PC
add wave -noupdate -radix unsigned /testbench/DUT/U0/pc7/Q
add wave -noupdate /testbench/DUT/U0/flag
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {120000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {1340024 ps} {2034736 ps}
