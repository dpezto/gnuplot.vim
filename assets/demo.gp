#!/usr/bin/env gnuplot
# Rb-87 saturation spectroscopy, demo scan

set terminal pngcairo size 10cm, 7cm font "Iosevka,10"
set output "scan.png"

set title sprintf("run %d on %s", 42, GPVAL_TERM)
set xrange [-1.5:1.5]

$scan << EOD
-1.0  0.12
 0.0  0.98
 1.0  0.15
EOD

stats $scan using 2 name "S" nooutput
style = "with linespoints lw 2 pt 7"

if (S_max > 0.5) {
    print "peak found at ", S_max
}

do for [k = 1:3] {
    f(x) = exp(-(x/k)**2)
    plot $scan using 1:2 @style title "scan", \
         f(x) with lines dt 2 notitle
}
