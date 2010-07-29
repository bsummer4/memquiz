#!/usr/bin/env tclsh8.5

proc this {x} { return $x }
proc digit {} {
	lindex {no pa re ci vo mu xa ze bi so} [expr {int(rand()*10)}] }

proc number {{len 0}} {
	times [if {$len} {this $len} {expr {int(rand()*9+1)} }] digit}

proc withresult script {
	uplevel {set result {}}
	upvar result r
	uplevel $script
	return $r }

proc dotimes {n script} { for {} {$n > 0} {incr n -1} { uplevel $script }}
proc times {n script} {
	withresult {
		dotimes $n { lappend result [uplevel $script] }}}

set len 2
while {![eof stdin]} {
	gets stdin l;
	set l [string trim $l]
	if {[string length $l] && [string is integer $l]} { set len $l }
	dotimes 10 {puts [number $len]}}
