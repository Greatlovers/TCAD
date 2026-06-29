set files {n18_des.tdr n19_des.tdr}
set fields {
  Abs(TotalCurrentDensity-X)
  Abs(TotalCurrentDensity-Y)
  Abs(TotalCurrentDensity-U)
  Abs(TotalCurrentDensity-V)
  Abs(eCurrentDensity-X)
  Abs(eCurrentDensity-Y)
  Abs(eCurrentDensity-U)
  Abs(eCurrentDensity-V)
  Abs(hCurrentDensity-X)
  Abs(hCurrentDensity-Y)
  Abs(hCurrentDensity-U)
  Abs(hCurrentDensity-V)
  TotalCurrentDensity
  eCurrentDensity
  hCurrentDensity
  Abs(TotalCurrent-V)
  Abs(eCurrent-V)
  Abs(hCurrent-V)
  eDensity
  hDensity
  DopingConcentration
  DonorConcentration
  AcceptorConcentration
}

foreach file $files {
    set requested [file rootname $file]
    set loaded [load_file $file -name $requested]
    set plot [create_plot -dataset $loaded]
    puts "FILE=$file"
    foreach field $fields {
        if {[catch {
            calculate_field_value -plot $plot -field $field -max
        } result]} {
            puts "FIELD=$field ERROR=$result"
        } else {
            puts "FIELD=$field MAX=$result"
        }
    }
}
