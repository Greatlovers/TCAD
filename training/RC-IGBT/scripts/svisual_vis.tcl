#============================================================
# Vth.tcl
# S-Visual Tcl script
# Extract IGBT threshold voltage from Ic-Vg curve
# Method: constant-current method
# Vth = Vg at |Ic| = 1 mA/mm
#============================================================

#set Vth x

load_file ./n@node|-1@_des.plt -name @node|-1@_data

create_plot -1d
select_plots {Plot_1}

# Ic-Vg curve
create_curve -axisX {Gate OuterVoltage} -axisY {Collector TotalCurrent} -dataset @node|-1@_data -plot Plot_1
# Curve_1

set Vgs [get_curve_data Curve_1 -axisX]
set Ics [get_curve_data Curve_1 -axisY]

#------------------------------------------------------------
# Threshold current
# If AreaFactor = 1000 um = 1 mm, 1 mA/mm = 1e-3 A
#------------------------------------------------------------
set Ith 1.0e-3

set Vth x

#------------------------------------------------------------
# Find first crossing point: |Ic| >= Ith
# Linear interpolation between two adjacent points
#------------------------------------------------------------
for {set i 1} {$i < [llength $Vgs]} {incr i} {

    set vg1 [lindex $Vgs [expr $i-1]]
    set vg2 [lindex $Vgs $i]

    set ic1 [expr abs([lindex $Ics [expr $i-1]])]
    set ic2 [expr abs([lindex $Ics $i])]

    if {($ic1 < $Ith) && ($ic2 >= $Ith)} {

        set Vth [expr $vg1 + ($Ith-$ic1)*($vg2-$vg1)/($ic2-$ic1)]

        break
    }
}

puts "DOE: Vth [format %.4f $Vth]"