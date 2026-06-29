set file $::env(CURRENT_PLT)
set dataset [load_file $file -name iv]

foreach variable {
    "Gate OuterVoltage"
    "Collector OuterVoltage"
    "Collector InnerVoltage"
    "Collector TotalCurrent"
    "Collector eCurrent"
    "Collector hCurrent"
} {
    set values [get_variable_data $variable -dataset $dataset]
    set minimum [lindex $values 0]
    set maximum [lindex $values 0]
    foreach value $values {
        if {$value < $minimum} { set minimum $value }
        if {$value > $maximum} { set maximum $value }
    }
    puts "$variable POINTS=[llength $values] MIN=$minimum MAX=$maximum LAST=[lindex $values end]"
}
