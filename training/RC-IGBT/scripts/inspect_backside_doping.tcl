set input $::env(INPUT_TDR)
set output $::env(OUTPUT_CSV)
set ycut $::env(YCUT)

set dataset [load_file $input -name mesh]
set plot [create_plot -dataset $dataset]
set cut [create_cutline -plot $plot -type y -at $ycut]

export_variables {X DopingConcentration DonorConcentration AcceptorConcentration} \
    -dataset $cut -filename $output -overwrite
