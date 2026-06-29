*============================================================
* IGBT Ic-Vg
* Emitter = 0 V
* Collector = @Vce@ V
* Gate: 0 -> @Vgemax@ V
* self_heating = @self_heating@
*============================================================

#if @[string equal @self_heating@ on]@
#define _EQS_ Poisson Electron Hole Temperature
#else
#define _EQS_ Poisson Electron Hole
#endif

Electrode {
  { Name="Emitter"   Voltage=0.0 Resistance=1.0 }
  { Name="Gate"      Voltage=0.0 }
  { Name="Collector" Voltage=0.0 Resistance=1.0 }
}

#if @[string equal @self_heating@ on]@
Thermode {
  { Name="Collector" Temperature=300 SurfaceResistance=1e-4 }
  { Name="Emitter"   Temperature=300 SurfaceResistance=1e-4 }
}
#endif

File {
  Grid      = "@tdr@"
  Plot      = "@tdrdat@"
  Current   = "@plot@"
  Output    = "@log@"
  Parameter = "@parameter@"
}

Physics {
  Temperature = 300
  AreaFactor  = 1e6

#if @[string equal @self_heating@ on]@
  Thermodynamic
  AnalyticTEP
#endif

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

#if @[string equal @self_heating@ on]@
  Temperature
  TotalHeat
  lHeatFlux/Vector
#endif
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

#if @[string equal @self_heating@ on]@
  Coupled(Iterations=100) { Poisson Electron Hole Temperature }
#endif

  Save(FilePrefix="IcVg_eq")

  *----------------------------------------------------------
  * Step 1: ramp Collector to Vce = @Vce@
  *----------------------------------------------------------
  QuasiStationary(
    InitialStep = 1e-3
    Increment   = 2.0
    Decrement   = 5.5
    MinStep     = 1e-10
    MaxStep     = 1.0
    Goal { Name="Collector" Voltage=@Vce@ }
  ) {
    Coupled { _EQS_ }
  }

  Save(FilePrefix="IcVg_Vce@Vce@")

  *----------------------------------------------------------
  * Step 2: final Ic-Vg sweep
  * Gate: 0 -> @Vgemax@
  * Final current output: @plot@
  *----------------------------------------------------------
  NewCurrentPrefix = ""

  QuasiStationary(
    InitialStep = 1e-2
    Increment   = 1.5
    Decrement   = 2.5
    MinStep     = 1e-9
    MaxStep     = 0.10
    Goal { Name="Gate" Voltage=@Vgemax@ }
  ) {
    Coupled { _EQS_ }
    CurrentPlot( Time=(Range=(0 1) Intervals=40) )
  }
}
