#!/usr/bin/env tclsh8.5

proc this {x} { return $x }
proc digit {} {
    lindex {no pa re ci vo mu xa ze bi so} [expr {int(rand()*10)}] }

proc number {{len 0}} {
    times digit [if {$len} {this $len} {expr {int(rand()*9+1)} }]}

proc times {proc times} {
    set result {}
    for {set i 0} {$i < $times} {incr i} {
        lappend result [eval $proc] }
    return $result }

while {![eof stdin]} {
    gets stdin
    times {puts [number 2]} 10 }
