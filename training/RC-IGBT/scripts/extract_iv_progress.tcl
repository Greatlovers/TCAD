set files {n10_des.plt n11_des.plt}

foreach file $files {
    if {![file exists $file]} {
        continue
    }

    set dataset [load_file $file -name [file rootname $file]]
    set gate [get_variable_data "Gate OuterVoltage" -dataset $dataset]
    set collector_voltage [get_variable_data "Collector OuterVoltage" -dataset $dataset]
    set collector_current [get_variable_data "Collector TotalCurrent" -dataset $dataset]

    set max_gate -1.0e300
    set max_collector_voltage -1.0e300
    set max_abs_current 0.0

    foreach value $gate {
        if {$value > $max_gate} {
            set max_gate $value
        }
    }
    foreach value $collector_voltage {
        if {$value > $max_collector_voltage} {
            set max_collector_voltage $value
        }
    }
    foreach value $collector_current {
        set magnitude [expr {abs(double($value))}]
        if {$magnitude > $max_abs_current} {
            set max_abs_current $magnitude
        }
    }

    puts "FILE=$file POINTS=[llength $gate] MAX_GATE=$max_gate MAX_COLLECTOR_VOLTAGE=$max_collector_voltage MAX_ABS_COLLECTOR_CURRENT=$max_abs_current"
}
