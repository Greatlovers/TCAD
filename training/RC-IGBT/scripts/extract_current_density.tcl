set files {n10_des.tdr n11_des.tdr n18_des.tdr n19_des.tdr trial_n10_des.tdr}

foreach file $files {
    set requested [file rootname $file]
    set loaded [load_file $file -name $requested]
    set plot [create_plot -dataset $loaded]
    puts "FILE=$file"
    puts "LOADED=$loaded"
    puts "PLOT=$plot"
    if {[catch {
        calculate_field_value -plot $plot -field Abs(TotalCurrentDensity-V) -max
    } result errorOptions]} {
        puts "MAX_ERROR=$result"
    } else {
        puts "MAX_ABS_TOTAL_CURRENT_DENSITY=$result"
    }
}
