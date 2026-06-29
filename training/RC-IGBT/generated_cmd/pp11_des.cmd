*============================================================
* IGBT Ic-Vg
* Emitter = 0 V
* Collector = 5 V
* Gate: 0 -> 15 V
* self_heating = on
*============================================================


Electrode {
  { Name="Emitter"   Voltage=0.0 Resistance=1.0 }
  { Name="Gate"      Voltage=0.0 }
  { Name="Collector" Voltage=0.0 Resistance=1.0 }
}

Thermode {
  { Name="Collector" Temperature=300 SurfaceResistance=1e-4 }
  { Name="Emitter"   Temperature=300 SurfaceResistance=1e-4 }
}

File {
  Grid      = "n4_msh.tdr"
  Plot      = "n11_des.tdr"
  Current   = "n11_des.plt"
  Output    = "n11_des.log"
  Parameter = "pp11_des.par"
}

Physics {
  Temperature = 300
  AreaFactor  = 1e6

  Thermodynamic
  AnalyticTEP

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

  Temperature
  TotalHeat
  lHeatFlux/Vector
}

Math {
  RelErrControl

  Digits = 5
  ErrRef(Electron) = 1e10
  ErrRef(Hole)     = 1e10

  Iterations = 20
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

  Coupled(Iterations=100) { Poisson Electron Hole Temperature }

  Save(FilePrefix="IcVg_eq")

  *----------------------------------------------------------
  * Step 1: ramp Collector to Vce = 5
  *----------------------------------------------------------
  QuasiStationary(
    InitialStep = 1e-3
    Increment   = 2.0
    Decrement   = 5.5
    MinStep     = 1e-10
    MaxStep     = 1.0
    Goal { Name="Collector" Voltage=5 }
  ) {
    Coupled { Poisson Electron Hole Temperature }
  }

  Save(FilePrefix="IcVg_Vce5")

  *----------------------------------------------------------
  * Step 2: final Ic-Vg sweep
  * Gate: 0 -> 15
  * Final current output: n11_des.plt
  *----------------------------------------------------------
  NewCurrentPrefix = ""

  QuasiStationary(
    InitialStep = 1e-2
    Increment   = 1.5
    Decrement   = 2.5
    MinStep     = 1e-9
    MaxStep     = 0.10
    Goal { Name="Gate" Voltage=15 }
  ) {
    Coupled { Poisson Electron Hole Temperature }
    CurrentPlot( Time=(Range=(0 1) Intervals=40) )
  }
}

