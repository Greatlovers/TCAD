# project name
name RC-IGBT
# execution graph
job 26 -d "4"  -post { extract_vars "$nodedir" n26_des.out 26 }  -o n26_des "sdevice pp26_des.cmd"
job 27 -d "4"  -post { extract_vars "$nodedir" n27_des.out 27 }  -o n27_des "sdevice pp27_des.cmd"
job 30 -d "4"  -post { extract_vars "$nodedir" n30_des.out 30 }  -o n30_des "sdevice pp30_des.cmd"
job 31 -d "4"  -post { extract_vars "$nodedir" n31_des.out 31 }  -o n31_des "sdevice pp31_des.cmd"
job 10 -d "4"  -post { extract_vars "$nodedir" n10_des.out 10 }  -o n10_des "sdevice pp10_des.cmd"
job 11 -d "4"  -post { extract_vars "$nodedir" n11_des.out 11 }  -o n11_des "sdevice pp11_des.cmd"
job 22 -d "4"  -post { extract_vars "$nodedir" n22_des.out 22 }  -o n22_des "sdevice pp22_des.cmd"
job 23 -d "4"  -post { extract_vars "$nodedir" n23_des.out 23 }  -o n23_des "sdevice pp23_des.cmd"
job 4   -post { extract_vars "$nodedir" n4_dvs.out 4 }  -o n4_dvs "sde -e -l n4_dvs.cmd"
job 18 -d "4"  -post { extract_vars "$nodedir" n18_des.out 18 }  -o n18_des "sdevice pp18_des.cmd"
job 19 -d "4"  -post { extract_vars "$nodedir" n19_des.out 19 }  -o n19_des "sdevice pp19_des.cmd"
check sde_dvs.cmd 1782380991
check IcVg_des.cmd 1782041900
check sdevice.par 1781447902
check svisual_vis.tcl 1781529608
check IcVc_des.cmd 1782208017
check svisual1_vis.tcl 1781447800
check BV_des.cmd 1781683561
check svisual2_vis.tcl 1781447809
check tran_reverse_recovery_des.cmd 1782559301
check svisual3_vis.tcl 1781668928
check snapback_des.cmd 1782548120
check svisual4_vis.tcl 1781668937
check global_tooldb 1748002656
check gtree.dat 1782559135
check ./Oxide.par 1748001794
check ./PolySi.par 1748001794
check ./Silicon.par 1748001794
# included files
file sdevice.par included ./Oxide.par
file sdevice.par included ./PolySi.par
file sdevice.par included ./Silicon.par
