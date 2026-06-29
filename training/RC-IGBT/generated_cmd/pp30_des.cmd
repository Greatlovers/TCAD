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
*   Gate      = 15 V
*   Collector = traced by Continuation
*
* Current scale:
*   AreaFactor=1e6 is kept consistent with the validated IcVg/IcVc/BV
*   nodes in this Workbench project.
*============================================================


Electrode {
  { Name="Emitter"   Voltage=0.0 Resistance=1.0 }
  { Name="Gate"      Voltage=0.0 }
  { Name="Collector" Voltage=0.0 Resistance=1.0 }
}


File {
  Grid      = "n4_msh.tdr"
  Plot      = "n30_des.tdr"
  Current   = "n30_des.plt"
  Output    = "n30_des.log"
  Parameter = "pp30_des.par"
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
    Goal { Name="Gate" Voltage=15 }
  ) {
    Coupled { Poisson Electron Hole }
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
    Coupled { Poisson Electron Hole }

    CurrentPlot( )

  }
}

