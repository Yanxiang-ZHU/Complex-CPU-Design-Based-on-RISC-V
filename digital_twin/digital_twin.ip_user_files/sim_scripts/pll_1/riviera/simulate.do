transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+pll  -L xpm -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.pll xil_defaultlib.glbl

do {pll.udo}

run 1000ns

endsim

quit -force
