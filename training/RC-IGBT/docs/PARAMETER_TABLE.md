# RC-IGBT Structure and Simulation Parameters

| Parameter | Value | Source | Meaning |
|---|---:|---|---|
| `Npbase` | `5e17` | `gtree.dat` | Workbench variable for sde; candidates {5e17}; type V |
| `toxide` | `0.06` | `gtree.dat` | Workbench variable for sde; candidates {0.06}; type V |
| `Nglobal` | `1e15` | `gtree.dat` | Workbench variable for sde; candidates {1e15}; type R |
| `self_heating` | `off` | `gtree.dat` | Workbench variable for IcVg; candidates {off on}; type V |
| `Vgemax` | `15` | `gtree.dat` | Workbench variable for IcVg; candidates {15}; type V |
| `Vce` | `5` | `gtree.dat` | Workbench variable for IcVg; candidates {5}; type R |
| `Vcemax` | `10` | `gtree.dat` | Workbench variable for IcVc; candidates {10}; type V |
| `Vge` | `15` | `gtree.dat` | Workbench variable for IcVc; candidates {15}; type R |
| `Thick` | `100` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `lJTE` | `50.0` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `xJTE` | `4.0` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `NJTE` | `5e15` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `JTEOverlap` | `2.0` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `dis_LOCOS_pbase` | `5.0` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `wLOCOS` | `lJTE` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `nGate` | `4` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `pitch` | `22` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `wPBase` | `18` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `Width` | `(+ (* 2.0 (+ wLOCOS dis_LOCOS_pbase)` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `tOxide` | `@toxide@` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `tGate` | `0.3` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `wGate` | `10` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `wGate.left_right` | `5` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `wNemit` | `4.0` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `wPexten` | `5.0` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `wNcoll` | `2` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `wPcoll` | `(- Width wNcoll)` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `overlap_Nemit_gate` | `0.5` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `Nglobal` | `@Nglobal@` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `NPBase` | `@Npbase@` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `NNemit` | `1e20` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `NPexten` | `1e20` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `NFs` | `1e19` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `NPcoll` | `5e19` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `NNcoll` | `4e16` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `tLOCOS` | `0.8` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `xGate.t` | `(- 0  tOxide tGate)` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `xGate.b` | `0` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `yGate.l` | `(+ wLOCOS dis_LOCOS_gate0)` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `yGate.r` | `(+ yGate.l wGate)` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `xOxide.t` | `(- 0 tOxide)` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `xOxide.b` | `0` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `yOxide.l` | `yGate.l` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `yOxide.r` | `yGate.r` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `yOxideleft.l` | `(+ wLOCOS dis_LOCOS_gate_leftright)` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `yOxideleft.r` | `(+ yOxideleft.l wGate.left_right)` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `yGateleft.l` | `yOxideleft.l` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `yGateleft.r` | `yOxideleft.r` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `yOxideright.l` | `(- Width wLOCOS wGate.left_right dis_LOCOS_gate_leftright)` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `yOxideright.r` | `(+ yOxideright.l wGate.left_right)` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `yGateright.l` | `yOxideright.l` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `yGateright.r` | `yOxideright.r` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `half_distance` | `(/ (- pitch wGate) 2)` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `gateEdges` | `'()` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `yGate0` | `(/ (+ yGate.l yGate.r) 2.0)` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `nPbase` | `(+ nGate 1)` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `yEmitFirst` | `(+ wLOCOS dis_LOCOS_pbase (/ wPBase 2.0))` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `emitEdges` | `'()` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `rLOCOS` | `0.1` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `yJTE.left.l` | `0.0` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `yJTE.left.r` | `(+ wLOCOS dis_LOCOS_pbase JTEOverlap)` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `yJTE.right.l` | `(- Width wLOCOS dis_LOCOS_pbase JTEOverlap)` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `yJTE.right.r` | `Width` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `pbody0.l` | `(+ wLOCOS dis_LOCOS_pbase)` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `pbody0.r` | `(+ pbody0.l wPBase)` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `emitBlockW` | `(+ (* 2.0 wNemit) wPexten)` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `emitBlock0.l` | `(- (+ pbody0.l (/ wPBase 2.0)) (/ emitBlockW 2.0))` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `nplusL0.l` | `emitBlock0.l` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `nplusL0.r` | `(+ nplusL0.l wNemit)` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `pexten0.l` | `nplusL0.r` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `pexten0.r` | `(+ pexten0.l wPexten)` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `nplusR0.l` | `pexten0.r` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `nplusR0.r` | `(+ nplusR0.l wNemit)` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `NBuf` | `1e18` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `xCollectorJ` | `5.0` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `xBufGap` | `0.2` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `xBuf` | `2.0` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `xBuf.l` | `(- Thick (+ xCollectorJ xBufGap xBuf))` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `xBuf.r` | `(- Thick (+ xCollectorJ xBufGap))` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `yBuf.l` | `0.0` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `yBuf.r` | `(- wPcoll 2.0)` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `dch` | `0.10` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `chPadY` | `2.0` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `nplusPadY` | `0.8` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `nplusX0` | `0.0` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `nplusX1` | `1.6` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `pbaseEdgePadY` | `2.0` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `pbaseEdgeX0` | `0.0` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `pbaseEdgeX1` | `7.0` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `pbaseBottomX0` | `2.0` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `pbaseBottomX1` | `8.0` | `sde_dvs.cmd` | SDE geometry, doping, mesh, or derived layout parameter |
| `AreaFactor` | `1e6` | `IcVg_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Temperature` | `300 SurfaceResistance=1e-4` | `IcVg_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Temperature` | `300` | `IcVg_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Digits` | `5` | `IcVg_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Iterations` | `20` | `IcVg_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Iterations` | `100) { Poisson` | `IcVg_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Iterations` | `100) { Poisson Electron Hole` | `IcVg_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Iterations` | `100) { Poisson Electron Hole Temperature` | `IcVg_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `NotDamped` | `50` | `IcVg_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Method` | `Pardiso` | `IcVg_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `RHSmin` | `1e-10` | `IcVg_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `RHSmax` | `1e20` | `IcVg_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `RHSFactor` | `1e30` | `IcVg_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Number_of_threads` | `4` | `IcVg_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `InitialStep` | `1e-3` | `IcVg_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `InitialStep` | `1e-2` | `IcVg_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `MinStep` | `1e-10` | `IcVg_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `MinStep` | `1e-9` | `IcVg_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `MaxStep` | `1.0` | `IcVg_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `MaxStep` | `0.10` | `IcVg_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Increment` | `2.0` | `IcVg_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Increment` | `1.5` | `IcVg_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Decrement` | `5.5` | `IcVg_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Decrement` | `2.5` | `IcVg_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `AreaFactor` | `1e6 scales the specified resistance.` | `IcVc_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `AreaFactor` | `1e6` | `IcVc_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Temperature` | `300 SurfaceResistance=1e-4` | `IcVc_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Temperature` | `300` | `IcVc_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Digits` | `5` | `IcVc_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Iterations` | `30` | `IcVc_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Iterations` | `100) { Poisson` | `IcVc_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Iterations` | `100) { Poisson Electron Hole` | `IcVc_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Iterations` | `100) { Poisson Electron Hole Temperature` | `IcVc_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `NotDamped` | `50` | `IcVc_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Method` | `Pardiso` | `IcVc_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `RHSmin` | `1e-10` | `IcVc_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `RHSmax` | `1e20` | `IcVc_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `RHSFactor` | `1e30` | `IcVc_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Number_of_threads` | `4` | `IcVc_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `InitialStep` | `1e-2` | `IcVc_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `InitialStep` | `1e-3` | `IcVc_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `MinStep` | `1e-9` | `IcVc_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `MinStep` | `1e-10` | `IcVc_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `MaxStep` | `0.10` | `IcVc_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `MaxStep` | `0.05` | `IcVc_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Increment` | `1.5` | `IcVc_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Decrement` | `2.5` | `IcVc_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `AreaFactor` | `1e6` | `BV_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Temperature` | `300 SurfaceResistance=1e-4` | `BV_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Temperature` | `300` | `BV_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Digits` | `5` | `BV_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Iterations` | `50` | `BV_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Iterations` | `100) { Poisson` | `BV_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Iterations` | `100) { Poisson Electron Hole` | `BV_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Iterations` | `100) { Poisson Electron Hole Temperature` | `BV_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `NotDamped` | `150` | `BV_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Method` | `ILS` | `BV_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `InitialStep` | `1e-3` | `BV_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `MinStep` | `1e-10` | `BV_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `MaxStep` | `2.0` | `BV_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Increment` | `1.15` | `BV_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Decrement` | `2.0` | `BV_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `AreaFactor` | `1e6, kept consistent with the already verified` | `tran_reverse_recovery_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `AreaFactor` | `1e6` | `tran_reverse_recovery_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Temperature` | `300` | `tran_reverse_recovery_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Digits` | `5` | `tran_reverse_recovery_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Iterations` | `40` | `tran_reverse_recovery_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Iterations` | `200` | `tran_reverse_recovery_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Iterations` | `80` | `tran_reverse_recovery_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Iterations` | `60` | `tran_reverse_recovery_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `NotDamped` | `80` | `tran_reverse_recovery_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Method` | `Pardiso` | `tran_reverse_recovery_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `RHSmin` | `1e-10` | `tran_reverse_recovery_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `RHSmax` | `1e20` | `tran_reverse_recovery_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `RHSFactor` | `1e30` | `tran_reverse_recovery_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Number_of_threads` | `4` | `tran_reverse_recovery_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `InitialStep` | `1e-4` | `tran_reverse_recovery_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `InitialStep` | `1.0e-10` | `tran_reverse_recovery_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `MinStep` | `1e-10` | `tran_reverse_recovery_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `MinStep` | `1.0e-18` | `tran_reverse_recovery_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `MaxStep` | `1.5` | `tran_reverse_recovery_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `MaxStep` | `2.5e-8` | `tran_reverse_recovery_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Increment` | `3` | `tran_reverse_recovery_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Increment` | `1.35` | `tran_reverse_recovery_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Decrement` | `4.0` | `tran_reverse_recovery_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Decrement` | `2.0` | `tran_reverse_recovery_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `FinalTime` | `2.70e-6` | `tran_reverse_recovery_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `InitialTime` | `0.0` | `tran_reverse_recovery_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `vdc` | `dc = 0.0` | `tran_reverse_recovery_des.cmd` | Mixed-mode Vsource_pset on nodes bus 0 |
| `lload` | `inductance = 20e-6` | `tran_reverse_recovery_des.cmd` | Mixed-mode Inductor_pset on nodes bus load_mid |
| `rload` | `resistance = 0.5` | `tran_reverse_recovery_des.cmd` | Mixed-mode Resistor_pset on nodes load_mid sw |
| `vgsrc` | `pwl = ( 0.0 0.0 1.0e-7 0.0 1.5e-7 15.0 1.15e-6 15.0 1.20e-6 0.0 1.80e-6 0.0 1.85e-6 15.0 2.35e-6 15.0 2.40e-6 0.0 2.70e-6 0.0 )` | `tran_reverse_recovery_des.cmd` | Mixed-mode Vsource_pset on nodes gate_drv 0 |
| `rg` | `resistance = 5.0` | `tran_reverse_recovery_des.cmd` | Mixed-mode Resistor_pset on nodes gate_drv gate |
| `rsw_bleed` | `resistance = 1e10` | `tran_reverse_recovery_des.cmd` | Mixed-mode Resistor_pset on nodes sw 0 |
| `AreaFactor` | `1e6 is kept consistent with the validated IcVg/IcVc/BV` | `snapback_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `AreaFactor` | `1e6` | `snapback_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Temperature` | `300 SurfaceResistance=1e-4` | `snapback_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Temperature` | `300` | `snapback_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Digits` | `5` | `snapback_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Iterations` | `60` | `snapback_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Iterations` | `100 LineSearchDamping=1e-4) { Poisson` | `snapback_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Iterations` | `100 LineSearchDamping=1e-4) { Poisson Electron Hole` | `snapback_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Iterations` | `100 LineSearchDamping=1e-4) { Poisson Electron Hole Temperature` | `snapback_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `NotDamped` | `120` | `snapback_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Method` | `Pardiso` | `snapback_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `RHSmin` | `1e-10` | `snapback_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `RHSmax` | `1e20` | `snapback_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `RHSFactor` | `1e30` | `snapback_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Number_of_threads` | `4` | `snapback_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `InitialStep` | `1e-2` | `snapback_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `MinStep` | `1e-9` | `snapback_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `MinStep` | `1e-8` | `snapback_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `MaxStep` | `0.10` | `snapback_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Increment` | `1.4` | `snapback_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Increment` | `1.25` | `snapback_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Decrement` | `2.5` | `snapback_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Decrement` | `2.0` | `snapback_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `InitialVStep` | `0.02` | `snapback_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `MaxVStep` | `0.25` | `snapback_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `MaxVoltage` | `20.0` | `snapback_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `MaxCurrent` | `0.6 A before the` | `snapback_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `MaxCurrent` | `25 A at only about 6.4 V.  The user requires collector` | `snapback_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `MaxCurrent` | `300.0` | `snapback_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `MinVoltage` | `-0.01` | `snapback_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `MinCurrent` | `0.0` | `snapback_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Vadapt` | `0.5` | `snapback_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `Iadapt` | `1e-5` | `snapback_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `MaxIFactor` | `2` | `snapback_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
| `MaxRload` | `1e17` | `snapback_des.cmd` | SDevice solver, sweep, continuation, or transient setting |
