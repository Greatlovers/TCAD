set DATE [exec date]
set WORK [exec pwd]
puts "Date      : $DATE"
puts "Directory : $WORK"

load_file n4_msh.tdr -name msh
create_plot -dataset msh
select_plots Plot_msh

set_material_prop {Silicon Oxide PolySi} -plot Plot_msh -geom msh -show_mesh
set_plot_prop -plot Plot_msh -title "RC-IGBT SDE mesh: n4_msh.tdr"
set_axis_prop -plot Plot_msh -axis x -title "X (um)"
set_axis_prop -plot Plot_msh -axis y -title "Y (um)"

windows_style -style max
set_window_full -on
zoom_plot -plot Plot_msh -reset

export_view rcigbt_sde_mesh_full.png -plots Plot_msh -format png -resolution 1400x900 -overwrite
