*============================================================
* IGBT BVces
* Emitter = 0 V
* Gate = 0 V
* Collector: 0 -> 1500 V
* self_heating = off
*============================================================


Electrode {
  { Name="Emitter"   Voltage=0.0 }
  { Name="Gate"      Voltage=0.0 }
  { Name="Collector" Voltage=0.0 }
}


File {
  Grid      = "n4_msh.tdr"
  Plot      = "n22_des.tdr"
  Current   = "n22_des.plt"
  Output    = "n22_des.log"
  Parameter = "pp22_des.par"
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
    Avalanche(Lackner)
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
  AvalancheGeneration

}

Math {
  Extrapolate
  Derivatives
  RelErrControl

  Digits = 5
  ErrRef(Electron) = 1e10
  ErrRef(Hole)     = 1e10

  Iterations = 50
  NotDamped  = 150

  Method = ILS
}

Solve {
  NewCurrentPrefix = "tmp_"

  Coupled(Iterations=100) { Poisson }
  Coupled(Iterations=100) { Poisson Electron Hole }


  Save(FilePrefix="BVces_eq")

  *----------------------------------------------------------
  * Final BVces sweep
  * Collector: 0 -> 1500 V
  * Final current output: n22_des.plt
  *----------------------------------------------------------
  NewCurrentPrefix = ""

  QuasiStationary(
    InitialStep = 1e-3
    Increment   = 1.15
    Decrement   = 2.0
    MinStep     = 1e-10
    MaxStep     = 2.0
    Goal { Name="Collector" Voltage=1500.0 }
    BreakCriteria {Current (Contact="Collector" Absval= 0.01 ) } 	      

  ) {
    Coupled { Poisson Electron Hole }
    
  }
}

