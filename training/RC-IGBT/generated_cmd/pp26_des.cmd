*============================================================
* RC-IGBT mixed-mode double-pulse / reverse-recovery check
*
* Purpose:
*   Check whether the present RC-IGBT structure can provide
*   reverse-conduction/freewheel current and observe the
*   reverse-recovery current when the low-side DUT turns on again.
*
* Topology, adapted from Synopsys official project:
*   Applications_Library/Power/FB-Inverter_RC-IGBT/RC-IGBT/SW_des.cmd
*
*   Q1: low-side DUT RC-IGBT
*       Emitter=0, Gate=gate node, Collector=switch node
*
*   Q2: same RC-IGBT used as reverse-conduction/freewheel device
*       Emitter=switch node, Gate=switch node, Collector=DC bus
*
*   Vdc -> Lload -> Rload -> switch node -> Q1 -> ground
*   During Q1 off-time, inductor current commutates through Q2.
*
* Conservative first-run parameter set:
*   Vdc       = 50 V
*   Lload     = 20 uH
*   Rload     = 2 ohm
*   Rgate     = 5 ohm
*   Vgate_on  = 15 V
*   ton1      = 1.0 us
*   toff1     = 0.6 us
*   ton2      = 0.5 us
*   tr/tf     = 50 ns
*
* AreaFactor:
*   AreaFactor = 1e6, kept consistent with the already verified
*   IcVg/IcVc/BV nodes in this Workbench project. This represents a
*   large effective 2D device width while keeping transient current
*   levels in the same numerical scale as the DC calibration.
*============================================================

Device RCIGBT {
  File {
    Grid            = "n4_msh.tdr"
    Plot(Collected) = "n26_des.tdr"
    Parameter       = "pp26_des.par"
    Current         = "RCIGBT_dev_n26_des.plt"
  }

  Electrode {
    { Name="Emitter"   Voltage=0.0 Resistance=1.0 }
    { Name="Gate"      Voltage=0.0 }
    { Name="Collector" Voltage=0.0 Resistance=1.0 }
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
}

File {
  Output = "n26_des.log"
}

Plot {
  Potential
  ElectricField/Vector
  SpaceCharge

  eDensity
  hDensity
  eCurrent/Vector
  hCurrent/Vector
  TotalCurrent/Vector
  TotalCurrentDensity

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
  RelErrControl

  Digits = 5
  ErrRef(Electron) = 1e10
  ErrRef(Hole)     = 1e10

  Iterations = 40
  NotDamped  = 80

  Transient = BE
  Method = Pardiso

  RHSmin = 1e-10
  RHSmax = 1e20
  RHSFactor = 1e30
  Number_of_threads = 4
  ExitOnFailure
}

System {

  *------------------------------------------------------------
  * Low-side switching DUT
  *------------------------------------------------------------
  RCIGBT Q1 (
    "Emitter"   = 0
    "Gate"      = gate_drv
    "Collector" = sw
  ) {
    File {
      Current = "Q1_n26_des.plt"
    }
  }


  *------------------------------------------------------------
  * Reverse-conduction / freewheel RC-IGBT
  * Gate tied to emitter: VGE_Q2 = 0
  * Reverse current path: sw -> bus
  *------------------------------------------------------------
  RCIGBT Q2 (
    "Emitter"   = sw
    "Gate"      = 0
    "Collector" = bus
  ) {
    File {
      Current = "Q2_n26_des.plt"
    }
  }


  *------------------------------------------------------------
  * DC bus source
  * Ramp vdc.dc to target voltage in Solve.
  *------------------------------------------------------------
  Vsource_pset vdc (bus 0) {
    dc = 0.0
  }


  *------------------------------------------------------------
  * Load inductor:
  * bus -> lload -> sw
  *------------------------------------------------------------
Inductor_pset lload (bus load_mid) {
  inductance = 20e-6
}

Resistor_pset rload (load_mid sw) {
  resistance = 0.5
}
  
  *------------------------------------------------------------
  * Gate driver for Q1
  * Directly drives gate with respect to ground.
  * No external gate resistor is used in this simplified version.
  *------------------------------------------------------------
  Vsource_pset vgsrc (gate_drv 0) {
    pwl = (
      0.0       0.0
      1.0e-7    0.0
      1.5e-7   15.0
      1.15e-6  15.0
      1.20e-6   0.0
      1.80e-6   0.0
      1.85e-6  15.0
      2.35e-6  15.0
      2.40e-6   0.0
      2.70e-6   0.0
    )
  }
Resistor_pset rg (gate_drv gate) {
  resistance = 5.0
}

  *------------------------------------------------------------
  * Optional weak switch-node bleed path
  * Helps convergence when the switching node becomes weakly defined.
  * You can keep it; it barely affects the circuit.
  *------------------------------------------------------------
  Resistor_pset rsw_bleed (sw 0) {
    resistance = 1e10
  }


  Set (0 = 0)


}
Solve {

  NewCurrentPrefix = "tmp_"

  *------------------------------------------------------------
  * Initial solution
  *------------------------------------------------------------
  Coupled(
    Iterations = 200
    LineSearchDamping = 1e-3
  ) {
    Poisson
  }

  Coupled(
    Iterations = 200
    LineSearchDamping = 1e-3
  ) {
    Poisson Electron Hole
  }

  Coupled(
    Iterations = 200
    LineSearchDamping = 1e-3
  ) {
    Poisson Electron Hole Contact Circuit
  }


  *------------------------------------------------------------
  * Ramp DC bus before switching
  *------------------------------------------------------------
  QuasiStationary(
    InitialStep = 1e-4
    Increment   = 3
    Decrement   = 4.0
    MinStep     = 1e-10
    MaxStep     = 1.5

    Goal {
      Parameter = vdc.dc
      Voltage   = 50.0
    }
  ) {
    Coupled(
      Iterations = 80
      LineSearchDamping = 1e-3
    ) {
      Poisson Electron Hole Contact Circuit
    }

    * Do not store bus-ramp current points in the main DPT plt
    CurrentPlot(Time=(-1))
  }


  Save(FilePrefix = "DPT_Vdc50_eq")


  *------------------------------------------------------------
  * Double-pulse transient
  *------------------------------------------------------------
  NewCurrentPrefix = "DPT_"

  Transient(
    InitialTime = 0.0
    FinalTime   = 2.70e-6

    InitialStep = 1.0e-10
    Increment   = 1.35
    Decrement   = 2.0
    MinStep     = 1.0e-18
    MaxStep     = 2.5e-8

    TurningPoints(
      (Condition(Time(1.0e-7;1.5e-7)) Value = 1.0e-9)
      (Condition(Time(1.15e-6;1.20e-6)) Value = 1.0e-9)
      (Condition(Time(1.80e-6;1.85e-6)) Value = 1.0e-9)
      (Condition(Time(2.35e-6;2.40e-6)) Value = 1.0e-9)

      (Condition(Time(Range = (1.75e-6 1.95e-6))) Value = 1.0e-9)
      (Condition(Time(Range = (2.30e-6 2.50e-6))) Value = 1.0e-9)
    )
  ) {

    Coupled(
      Iterations = 60
      LineSearchDamping = 1e-3
    ) {
      Poisson Electron Hole Contact Circuit
    }


    CurrentPlot(
      Time = (Range = (0.0 2.70e-6) Intervals = 400)
      NoOverwrite
    )


    Plot(
      FilePrefix = "DPT_state"
      Time       = (Range = (0.0 2.70e-6) Intervals = 12)
      NoOverwrite
    )
  }
}

