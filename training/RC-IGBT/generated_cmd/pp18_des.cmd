*============================================================
* IGBT Ic-Vce
* Emitter = 0 V
* Gate = 15 V
* Collector: 0 -> 10 V
* self_heating = off
*============================================================


Electrode {
  { Name="Emitter"   Voltage=0.0 Resistance=1.0 }
  { Name="Gate"      Voltage=0.0 }
  * AreaFactor=1e6 scales the specified resistance.
  * 4e5 corresponds to approximately 0.4 ohm external series resistance.
  * This provides a stable load line through the electrothermal high-current branch.
  { Name="Collector" Voltage=0.0 Resistance=1.0 }
}


File {
  Grid      = "n4_msh.tdr"
  Plot      = "n18_des.tdr"
  Current   = "n18_des.plt"
  Output    = "n18_des.log"
  Parameter = "pp18_des.par"
}

Physics {
  Temperature = 300
  AreaFactor  = 1e6


  Fermi

  EffectiveIntrinsicDensity(
    BandGapNarrowing(OldSlotboom)
  )

  Mobility(
    DopingDependence
    HighFieldSaturation
    Enormal(IALMob)
  )

  Recombination(
    SRH(DopingDependence TempDependence)
    Auger
  )
}

Plot {
  Potential
  ElectricField/Vector
  SpaceCharge

  eDensity
  hDensity
  eCurrent/Vector
  hCurrent/Vector
   TotalCurrentDensity
     TotalCurrent/Vector


  eMobility
  hMobility
  eVelocity
  hVelocity

  eQuasiFermi
  hQuasiFermi

  DopingConcentration
  DonorConcentration
  AcceptorConcentration

  SRHRecombination
  AugerRecombination

}

Math {
  RelErrControl

  Digits = 5
  ErrRef(Electron) = 1e10
  ErrRef(Hole)     = 1e10

  Iterations = 30
  NotDamped  = 50

  Method = Pardiso
  RHSmin = 1e-10
  RHSmax = 1e20
  RHSFactor = 1e30
  Number_of_threads = 4
}

Solve {
  NewCurrentPrefix = "tmp_"

  Coupled(Iterations=100) { Poisson }
  Coupled(Iterations=100) { Poisson Electron Hole }


  Save(FilePrefix="IcVce_eq")

  *----------------------------------------------------------
  * Step 1: ramp Gate to Vge = 15
  *----------------------------------------------------------
  QuasiStationary(
    InitialStep = 1e-2
    Increment   = 1.5
    Decrement   = 2.5
    MinStep     = 1e-9
    MaxStep     = 0.10
    Goal { Name="Gate" Voltage=15 }
  ) {
    Coupled { Poisson Electron Hole }
  }

  Save(FilePrefix="IcVce_Vge15")

  *----------------------------------------------------------
  * Step 2: final Ic-Vce sweep
  * Collector: 0 -> 10
  * Final current output: n18_des.plt
  *----------------------------------------------------------
  NewCurrentPrefix = ""

  QuasiStationary(
    InitialStep = 1e-3
    Increment   = 1.5
    Decrement   = 2.5
    MinStep     = 1e-10
    MaxStep     = 0.05
    Goal { Name="Collector" Voltage=10 }
  ) {
    Coupled { Poisson Electron Hole }
    CurrentPlot( Time=(Range=(0 1) Intervals=80) )
  }
}

