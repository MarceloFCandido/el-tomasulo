onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tomasulim/CLK
add wave -noupdate /tomasulim/CLR
add wave -noupdate /tomasulim/addrOut
add wave -noupdate /tomasulim/q
add wave -noupdate /tomasulim/cheio
add wave -noupdate /tomasulim/vazio
add wave -noupdate /tomasulim/adc
add wave -noupdate /tomasulim/rtr
add wave -noupdate /tomasulim/instrOut
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 174
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {978 ps}
view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue 0 -period 100ps -dutycycle 50 -starttime 0ps -endtime 1000ps sim:/tomasulim/CLK 
wave create -driver freeze -pattern constant -value 0 -starttime 0ps -endtime 1000ps sim:/tomasulim/CLR 
wave modify -driver freeze -pattern constant -value 1 -starttime 0ps -endtime 10ps Edit:/tomasulim/CLR 
WaveCollapseAll -1
wave clipboard restore
