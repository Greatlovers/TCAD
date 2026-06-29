*============================================================
* RC-IGBT Snapback Simulation
*
* Workbench node:
*   snapback sdevice, downstream of the validated SDE mesh.
*
* Purpose:
*   Trace the collector I-V curve with Sentaurus Device Continuation
*   so that the snapback / negative-resistance branch is not lost by a
*   simple voltage-ramp or current-ramp sweep.
*
* Bias:
*   Emitter   = 0 V
*   Gate      = @Vge@ V
*   Collector = traced by Continuation
*
* Current scale:
*   AreaFactor=1e6 is kept consistent with the validated IcVg/IcVc/BV
*   nodes in this Workbench project.
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
  Extrapolate
  Derivatives
  RelErrControl

  Digits = 5
  ErrRef(Electron) = 1e10
  ErrRef(Hole)     = 1e10

  Iterations = 60
  NotDamped  = 120

  Method = Pardiso
  RHSmin = 1e-10
  RHSmax = 1e20
  RHSFactor = 1e30
  Number_of_threads = 4
}

Solve {
  *----------------------------------------------------------
  * 0. Initial equilibrium
  *----------------------------------------------------------
  NewCurrentPrefix = "tmp_"

  Coupled(Iterations=100 LineSearchDamping=1e-4) { Poisson }
  Coupled(Iterations=100 LineSearchDamping=1e-4) { Poisson Electron Hole }

#if @[string equal @self_heating@ on]@
  Coupled(Iterations=100 LineSearchDamping=1e-4) { Poisson Electron Hole Temperature }
#endif

  Save(FilePrefix="Snapback_eq")

  *----------------------------------------------------------
  * 1. Bias gate to the same Vge used by the IcVc branch.
  *----------------------------------------------------------
  QuasiStationary(
    InitialStep = 1e-2
    Increment   = 1.4
    Decrement   = 2.5
    MinStep     = 1e-9
    MaxStep     = 0.10
    Goal { Name="Gate" Voltage=@Vge@ }
  ) {
    Coupled { _EQS_ }
  }

  *----------------------------------------------------------
  * 2. Trace collector snapback with Continuation.
  *
  * The first Continuation run reached MaxCurrent=0.6 A before the
  * collector voltage exceeded 1 V.  The second run reached
  * MaxCurrent=25 A at only about 6.4 V.  The user requires collector
  * scanning to at least 15 V, so the voltage window is kept at 20 V
  * and the current window is widened further to avoid premature
  * current-limit termination before 15 V.
  *----------------------------------------------------------
  NewCurrentPrefix = "Continuation_"

  Continuation(
    Name="Collector"
    InitialVStep = 0.02
    Increment    = 1.25
    Decrement    = 2.0
    MaxVStep     = 0.25
    MinStep      = 1e-8
    NewArc
    MinVoltage   = -0.01
    MaxVoltage   = 20.0
    MinCurrent   = 0.0
    MaxCurrent   = 300.0
    Vadapt       = 0.5
    Iadapt       = 1e-5
    MaxIFactor   = 2
    MaxRload     = 1e17
  ) {
    Coupled { _EQS_ }

    CurrentPlot( )

  }
}
