;; UCS
;----------------------------------------------------------------------
; Structure definition
;----------------------------------------------------------------------;
;total width=22n+42
;----------------------------------------------------------------------
; Structure definition
;----------------------------------------------------------------------;

(define Thick 100)

;------------------------------------------------------------
; Termination parameters
; P-wall + P-JTE are placed under the field oxide / LOCOS region.
;------------------------------------------------------------
;------------------------------------------------------------
; JTE termination parameters
; Only P-JTE is used. No P-wall.
;------------------------------------------------------------
(define lJTE       50.0)
(define xJTE       4.0)
(define NJTE       5e15)
(define JTEOverlap 2.0)

; Keep a small layout gap, but JTE will extend across this gap
; and slightly overlap the nearest P-base.
(define dis_LOCOS_pbase 5.0)

; LOCOS region is now mainly used as JTE termination region.
(define wLOCOS lJTE)

; Total width:
; left termination + active cells + right termination
; active span = wPBase + nGate*pitch
(define nGate 4)
(define pitch 22)
(define wPBase 18)
(define Width (+ (* 2.0 (+ wLOCOS dis_LOCOS_pbase))
                 wPBase
                 (* nGate pitch)))

; Codex small patch 2026-06-25 round3: use lower P-base and thinner oxide through Workbench variables.
(define tOxide 0.06)
(define tGate 0.3)
(define wGate 10)
(define wGate.left_right 5)
(define wNemit  4.0)
(define wPexten 5.0)
(define wNcoll 2)
(define wPcoll (- Width wNcoll))
(define overlap_Nemit_gate 0.5)

(define dis_LOCOS_gate0
  (+ dis_LOCOS_pbase
     (/ wPBase 2)
     (/ wPexten 2)
     (- wNemit overlap_Nemit_gate)))

(define dis_LOCOS_gate_leftright
  (- dis_LOCOS_pbase
     (+ wGate.left_right
        wNemit
        (/ wPexten 2)
        (- 0 overlap_Nemit_gate (/ wPBase 2)))))

; Codex round4 2026-06-25: restore channel variables, sweep Nglobal=1.5e14 on user geometry.
; Codex round5 2026-06-25: sweep Nglobal=2e14 on user geometry/backside patch.
; Codex round6 2026-06-25: sweep Nglobal=5e14 to test TDR current density target.
; Codex round7 2026-06-25: sweep Nglobal=1e15 for TDR current density threshold.
(define Nglobal 1e15)
(define NPBase  5e17)
(define NNemit  1e20)
(define NPexten  1e20)
(define NFs 1e19)
; Codex small patch 2026-06-24 round2: strengthen P-collector injection and reduce N-collector shunt width.
(define NPcoll 5e19)
(define NNcoll 4e16)

(define tLOCOS 0.8)
(sdegeo:set-default-boolean "BAB")

(sdegeo:create-rectangle (position 0 0 0)  (position Thick Width 0) "Silicon" "R.Si")

(define xGate.t (- 0  tOxide tGate) )
(define xGate.b 0)
(define yGate.l (+ wLOCOS dis_LOCOS_gate0))
(define yGate.r (+ yGate.l wGate))
(define xOxide.t (- 0 tOxide))
(define xOxide.b 0)
(define yOxide.l yGate.l)
(define yOxide.r yGate.r)

(define yOxideleft.l (+ wLOCOS dis_LOCOS_gate_leftright) )
(define yOxideleft.r (+ yOxideleft.l wGate.left_right))
(define yGateleft.l yOxideleft.l )
(define yGateleft.r yOxideleft.r )

(define yOxideright.l (- Width wLOCOS wGate.left_right dis_LOCOS_gate_leftright) )
(define yOxideright.r (+ yOxideright.l wGate.left_right))
(define yGateright.l yOxideright.l )
(define yGateright.r yOxideright.r )
(sdegeo:set-default-boolean "ABA")

(sdegeo:create-rectangle (position xGate.b yGateleft.l 0 )  (position xGate.t yGateleft.r 0) "PolySi" "R.Gate.Left")
(sdegeo:create-rectangle (position xGate.b yGateright.l 0 )  (position xGate.t yGateright.r 0) "PolySi" "R.Gate.Right")
(sdegeo:create-rectangle (position xOxide.b yOxideleft.l 0)  (position xOxide.t yOxideleft.r 0) "Oxide" "R.Oxide.Left")
(sdegeo:create-rectangle (position xOxide.b yOxideright.l 0)  (position xOxide.t yOxideright.r 0) "Oxide" "R.Oxide.Right")
(define gate0 (sdegeo:create-rectangle (position xGate.b yGate.l 0 )  (position xGate.t yGate.r 0) "PolySi" "R.Gate.0"))
(sdegeo:translate-selected gate0
	(transform:translation (gvector 0 pitch 0))	#t
	(- nGate 1))
(define oxide0 (sdegeo:create-rectangle (position xOxide.b yOxide.l 0)  (position xOxide.t yOxide.r 0) "Oxide" "R.Oxide.0"))
(sdegeo:translate-selected oxide0
	(transform:translation (gvector 0 pitch 0))	#t
	(- nGate 1))
(sdegeo:define-contact-set "Emitter"   12  (color:rgb 1 0 0 ) "##" )
(sdegeo:define-contact-set "Collector" 12  (color:rgb 1 0 0 ) "##" )
(sdegeo:define-contact-set "Gate"     12  (color:rgb 1 0 0 ) "##" )

(define gate (sdegeo:define-2d-contact (find-edge-id (position xGate.t (/ (+ yGate.l  yGate.r) 2 ) 0.0)) "Gate"))
(define half_distance (/ (- pitch wGate) 2))

;------------------------------------------------------------
; Contacts
;------------------------------------------------------------

(sdegeo:define-contact-set "Emitter"   12  (color:rgb 1 0 0) "##")
(sdegeo:define-contact-set "Collector" 12  (color:rgb 1 0 0) "##")
(sdegeo:define-contact-set "Gate"      12  (color:rgb 1 0 0) "##")


;------------------------------------------------------------
; Gate contact: left half gate + middle gates + right half gate
;------------------------------------------------------------

(define gateEdges '())

; Left half gate
(set! gateEdges
  (append gateEdges
    (find-edge-id
      (position xGate.t
        (/ (+ yGateleft.l yGateleft.r) 2.0)
        0.0))))

; Middle repeated gates
(define yGate0 (/ (+ yGate.l yGate.r) 2.0))

(do ((i 0 (+ i 1)))
    ((= i nGate))
  (let ((yGate (+ yGate0 (* i pitch))))
    (set! gateEdges
      (append gateEdges
        (find-edge-id
          (position xGate.t yGate 0.0))))))

; Right half gate
(set! gateEdges
  (append gateEdges
    (find-edge-id
      (position xGate.t
        (/ (+ yGateright.l yGateright.r) 2.0)
        0.0))))

(sdegeo:set-contact gateEdges "Gate")


;------------------------------------------------------------
; Emitter contact: nGate + 1 emitter windows
;------------------------------------------------------------

(define nPbase (+ nGate 1))

; emitter center is aligned with P-base / P+ contact center
(define yEmitFirst
  (+ wLOCOS dis_LOCOS_pbase (/ wPBase 2.0)))

(define emitEdges '())

(do ((i 0 (+ i 1)))
    ((= i nPbase))
  (let ((yEmit (+ yEmitFirst (* i pitch))))
    (set! emitEdges
      (append emitEdges
        (find-edge-id
          (position 0.0 yEmit 0.0))))))

(sdegeo:set-contact emitEdges "Emitter")


;------------------------------------------------------------
; Collector contact
;------------------------------------------------------------

(sdegeo:set-contact
  (find-edge-id (position Thick (/ Width 2.0) 0.0))
  "Collector")

(sdegeo:set-default-boolean "ABA")

(define R.LOCOS.dum.l (sdegeo:create-rectangle (position (/ tLOCOS 2) 0 0)  (position  (- 0 (/ tLOCOS 2)) wLOCOS 0) "Oxide" "R.LOCOS.L"))
(define  R.LOCOS.dum.r (sdegeo:create-rectangle (position (/ tLOCOS 2) (- Width wLOCOS) 0)  (position  (- 0 (/ tLOCOS 2)) Width 0) "Oxide" "R.LOCOS.R"))
(define rLOCOS 0.1)
(sdegeo:delete-region R.LOCOS.dum.l)
(sdegeo:delete-region R.LOCOS.dum.r)
; Left LOCOS inner corners at y = wLOCOS
(sdegeo:fillet-2d(find-vertex-id (position (- 0 (/ tLOCOS 2)) wLOCOS 0.0)) rLOCOS)

(sdegeo:fillet-2d(find-vertex-id (position (/ tLOCOS 2) wLOCOS 0.0)) rLOCOS)

; Right LOCOS inner corners at y = Width - wLOCOS

(sdegeo:fillet-2d(find-vertex-id (position (/ tLOCOS 2) (- Width wLOCOS) 0.0)) rLOCOS)

(sdegeo:fillet-2d(find-vertex-id (position (- 0 (/ tLOCOS 2)) (- Width wLOCOS) 0.0)) rLOCOS)


(sdegeo:set-default-boolean "BAB")
(sdegeo:create-rectangle (position (/ tLOCOS 2) 0 0)  (position  (- 0 (/ tLOCOS 2)) wLOCOS 0) "Oxide" "R.LOCOS.L")
(sdegeo:create-rectangle (position (/ tLOCOS 2) (- Width wLOCOS) 0)  (position  (- 0 (/ tLOCOS 2)) Width 0) "Oxide" "R.LOCOS.R")
(sdegeo:set-default-boolean "ABA")


; Profiles
;----------------------------------------------------------------------;
; - Substrate
(sdedr:define-constant-profile "Const.Substrate"
 "PhosphorusActiveConcentration" Nglobal )
(sdedr:define-constant-profile-material "PlaceCD.Substrate"
 "Const.Substrate" "Silicon" )
;============================================================
; P-JTE and P-wall termination
;============================================================



;------------------------------------------------------------
; P-JTE:
; Shallow P-type junction termination extension.
; It spreads the surface electric field laterally.
;------------------------------------------------------------
;------------------------------------------------------------
; P-JTE:
; Shallow P-type junction termination extension.
; It connects to the nearest P-base with a small overlap.
;------------------------------------------------------------
(sdedr:define-gaussian-profile "Impl.pjteprof"
  "BoronActiveConcentration"
  "PeakPos" 0.0
  "PeakVal" NJTE
  "ValueAtDepth" Nglobal
  "Depth" xJTE
  "Gauss" "Factor" 0.8)

; Left nearest P-base starts at:
; y = wLOCOS + dis_LOCOS_pbase
;
; Therefore left JTE ends at:
; y = wLOCOS + dis_LOCOS_pbase + JTEOverlap
(define yJTE.left.l 0.0)
(define yJTE.left.r (+ wLOCOS dis_LOCOS_pbase JTEOverlap))

(sdedr:define-refeval-window "Win.pjte.left" "Rectangle"
  (position 0.0 yJTE.left.l 0.0)
  (position xJTE yJTE.left.r 0.0))

(sdedr:define-analytical-profile-placement "Place.pjte.left"
  "Impl.pjteprof"
  "Win.pjte.left"
  "Negative"
  "NoReplace"
  "Eval")


; Right nearest P-base ends at:
; y = Width - wLOCOS - dis_LOCOS_pbase
;
; Therefore right JTE starts at:
; y = Width - wLOCOS - dis_LOCOS_pbase - JTEOverlap
(define yJTE.right.l (- Width wLOCOS dis_LOCOS_pbase JTEOverlap))
(define yJTE.right.r Width)

(sdedr:define-refeval-window "Win.pjte.right" "Rectangle"
  (position 0.0 yJTE.right.l 0.0)
  (position xJTE yJTE.right.r 0.0))

(sdedr:define-analytical-profile-placement "Place.pjte.right"
  "Impl.pjteprof"
  "Win.pjte.right"
  "Negative"
  "NoReplace"
  "Eval")

(sdedr:define-constant-profile "Const.PolyGate"
 "PhosphorusActiveConcentration" 1e+21 )
(sdedr:define-constant-profile-material "PlaceCD.PolyGate"
 "Const.PolyGate" "PolySi" )



;------------------------------------------------------------
; P-body: moderate P doping, not P+
;------------------------------------------------------------
(sdedr:define-gaussian-profile "Impl.pbodyprof"
  "BoronActiveConcentration"
  "PeakPos" 0.0
  "PeakVal" NPBase
  "ValueAtDepth" 1e16
  "Depth" 3.0
  "Erf" "Length" 0.2)

;------------------------------------------------------------
; N++ emitter: shallow and heavily doped
;------------------------------------------------------------
(sdedr:define-gaussian-profile "Impl.nplusprof"
  "ArsenicActiveConcentration"
  "PeakPos" 0.0
  "PeakVal" NNemit
  "ValueAtDepth" 1e18
  "Depth" 0.45
  "Erf" "Length" 0.08)
  ;------------------------------------------------------------
; Doping profile definitions
;------------------------------------------------------------


(sdedr:define-gaussian-profile "Impl.pbodyextenprof"
  "BoronActiveConcentration"
  "PeakPos" 0.0
  "PeakVal" NPexten
  "ValueAtDepth" 1e17
  "Depth" 0.7
  "Erf" "Length" 0.1)


;------------------------------------------------------------
; First-cell P-body location
;------------------------------------------------------------

(define pbody0.l (+ wLOCOS dis_LOCOS_pbase))
(define pbody0.r (+ pbody0.l wPBase))

;------------------------------------------------------------
; N++ / P+ emitter block inside P-body
; Layout:
; | N++ | P+ / P-body extension | N++ |
;------------------------------------------------------------

(define emitBlockW (+ (* 2.0 wNemit) wPexten))

(define emitBlock0.l
  (- (+ pbody0.l (/ wPBase 2.0)) (/ emitBlockW 2.0)))

(define nplusL0.l emitBlock0.l)
(define nplusL0.r (+ nplusL0.l wNemit))

(define pexten0.l nplusL0.r)
(define pexten0.r (+ pexten0.l wPexten))

(define nplusR0.l pexten0.r)
(define nplusR0.r (+ nplusR0.l wNemit))


;------------------------------------------------------------
; Periodic placement of P-body, N++, and P-body extension
;------------------------------------------------------------
(define nPbase (+ nGate 1))

(do ((i 0 (+ i 1)))
    ((= i nPbase))

  (let* ((dy (* i pitch))

         ; names
         (blPBodyName  (string-append "BaseLine.pbody." (number->string i)))
         (plPBodyName  (string-append "Impl.pbody."     (number->string i)))

         (blNPlusLName (string-append "BaseLine.nplusL." (number->string i)))
         (plNPlusLName (string-append "Impl.nplusL."     (number->string i)))

         (blNPlusRName (string-append "BaseLine.nplusR." (number->string i)))
         (plNPlusRName (string-append "Impl.nplusR."     (number->string i)))

         (blPExtName   (string-append "BaseLine.pbodyexten." (number->string i)))
         (plPExtName   (string-append "Impl.pbodyexten."     (number->string i))))

    ;--------------------------------------------------------
    ; P-body baseline and placement
    ;--------------------------------------------------------

    (sdedr:define-refeval-window blPBodyName "Line"
      (position 0.0 (+ pbody0.l dy) 0.0)
      (position 0.0 (+ pbody0.r dy) 0.0))

    (sdedr:define-analytical-profile-placement plPBodyName
      "Impl.pbodyprof"
      blPBodyName
      "Negative"
      "NoReplace"
      "Eval")


    ;--------------------------------------------------------
    ; Left N++ emitter baseline and placement
    ;--------------------------------------------------------

    (sdedr:define-refeval-window blNPlusLName "Line"
      (position 0.0 (+ nplusL0.l dy) 0.0)
      (position 0.0 (+ nplusL0.r dy) 0.0))

    (sdedr:define-analytical-profile-placement plNPlusLName
      "Impl.nplusprof"
      blNPlusLName
      "Negative"
      "NoReplace"
      "Eval")


    ;--------------------------------------------------------
    ; P+ / P-body extension baseline and placement
    ;--------------------------------------------------------

    (sdedr:define-refeval-window blPExtName "Line"
      (position 0.0 (+ pexten0.l dy) 0.0)
      (position 0.0 (+ pexten0.r dy) 0.0))

    (sdedr:define-analytical-profile-placement plPExtName
      "Impl.pbodyextenprof"
      blPExtName
      "Negative"
      "NoReplace"
      "Eval")


    ;--------------------------------------------------------
    ; Right N++ emitter baseline and placement
    ;--------------------------------------------------------

    (sdedr:define-refeval-window blNPlusRName "Line"
      (position 0.0 (+ nplusR0.l dy) 0.0)
      (position 0.0 (+ nplusR0.r dy) 0.0))

    (sdedr:define-analytical-profile-placement plNPlusRName
      "Impl.nplusprof"
      blNPlusRName
      "Negative"
      "NoReplace"
      "Eval")))

(sdedr:define-refeval-window "BaseLine.Pcollector" "Line"
 (position Thick 0.0 0.0)
 (position Thick wPcoll 0.0) )
(sdedr:define-gaussian-profile "Impl.pcollectorprof"
 "BoronActiveConcentration"
 "PeakPos" 0  "PeakVal" NPcoll
 "ValueAtDepth" 5e17  "Depth" 5.0
 "Erf"  "Length" 0.1)
(sdedr:define-analytical-profile-placement "Impl.pcollector"
 "Impl.pcollectorprof" "BaseLine.Pcollector" "Positive" "NoReplace" "Eval")

(sdedr:define-refeval-window "BaseLine.Ncollector" "Line"
 (position Thick wPcoll 0.0)
 (position Thick Width 0.0) 	
	)   
(sdedr:define-gaussian-profile "Impl.ncollectorprof"
 "ArsenicActiveConcentration"
 "PeakPos" 0  "PeakVal" NNcoll
 "ValueAtDepth" 5e14  "Depth" 1.0
 "Erf"  "Length" 0.1)
(sdedr:define-analytical-profile-placement "Impl.nollector"
 "Impl.ncollectorprof" "BaseLine.Ncollector" "Positive" "NoReplace" "Eval")
; Codex small patch 2026-06-24: backside injection repair only; original cell/JTE layout preserved.
;============================================================
; N-buffer / Field-stop layer
; Reference-style rectangular window near collector side
;============================================================

; N-buffer peak doping.
; For your 100 um drift region, start from 1e17.
; Sweep suggestion: 5e16 / 1e17 / 2e17.
(define NBuf 1e18)

; P/N collector implant effective depth near backside.
; Your Pcollector/Ncollector Depth is about 1.0 um.
(define xCollectorJ 5.0)

; Gap between collector implant and N-buffer.
; This avoids direct hard overlap between collector and buffer.
(define xBufGap 0.2)

; N-buffer thickness / vertical decay depth.
(define xBuf 2.0)

; N-buffer x-window.
; Silicon is x = 0 ~ Thick.
; Collector side is near x = Thick.
(define xBuf.l (- Thick (+ xCollectorJ xBufGap xBuf)))
(define xBuf.r (- Thick (+ xCollectorJ xBufGap)))

; For RC-IGBT, put N-buffer mainly under P-collector side.
; Your P collector is y = 0 ~ wPcoll.
; Keep a small margin away from P/N collector split.
(define yBuf.l 0.0)
(define yBuf.r (- wPcoll 2.0))

(sdedr:define-refeval-window "Nbuf_Win" "Rectangle"
  (position xBuf.l yBuf.l 0.0)
  (position xBuf.r yBuf.r 0.0))

(sdedr:define-gaussian-profile "Impl.nbufferprof"
  "ArsenicActiveConcentration"
  "PeakPos" 0.0
  "PeakVal" NBuf
  "ValueAtDepth" 1e14
  "Depth" xBuf
  "Gauss" "Factor" 0.8)

(sdedr:define-analytical-profile-placement "Impl.nbuffer"
  "Impl.nbufferprof"
  "Nbuf_Win"
  "Negative"
  "NoReplace"
  "Eval")
;============================================================
; Mesh refinement v4
; Reference-inspired RC-IGBT mesh strategy
;
; Strategy:
;   1. Coarse global mesh
;   2. Top active region refinement
;   3. Local channel / Si-Oxide refinement
;   4. N++ emitter / P-base refinement
;   5. P-base / N-drift junction refinement
;   6. JFET gap refinement
;   7. Bottom collector / N-buffer refinement
;   8. P/N collector split refinement
;   9. No offsetting
;============================================================


;------------------------------------------------------------
; 1. Global coarse mesh
;------------------------------------------------------------

(sdedr:define-refinement-size "RefDef.global"
  30.0 15.0 1.0
  0.50 0.50 0.50)

(sdedr:define-refeval-window "RefWin.global" "Rectangle"
  (position -1.0 -1.0 0.0)
  (position (+ Thick 1.0) (+ Width 1.0) 0.0))

(sdedr:define-refinement-placement "RefPlace.global"
  "RefDef.global"
  (list "window" "RefWin.global"))


;------------------------------------------------------------
; 2. Drift region
;    Keep drift region coarse.
;    Do not use MaxTransDiff in whole drift.
;------------------------------------------------------------

(sdedr:define-refinement-size "RefDef.drift"
  18.0 10.0 1.0
  1.0  1.0  0.50)

(sdedr:define-refeval-window "RefWin.drift" "Rectangle"
  (position 8.0 0.0 0.0)
  (position (- Thick 10.0) Width 0.0))

(sdedr:define-refinement-placement "RefPlace.drift"
  "RefDef.drift"
  (list "window" "RefWin.drift"))


;------------------------------------------------------------
; 3. Top active region refinement
;    Similar to reference Top_Win.
;    Covers MOS, emitter, P-base and channel access region.
;------------------------------------------------------------

(sdedr:define-refinement-size "RefDef.top"
  2.0 1.0 0.5
  0.10 0.10 0.10)

(sdedr:define-refeval-window "RefWin.top" "Rectangle"
  (position -0.5 0.0 0.0)
  (position 8.0 Width 0.0))

(sdedr:define-refinement-placement "RefPlace.top"
  "RefDef.top"
  (list "window" "RefWin.top"))

; Relaxed adaptive doping refinement.
; Reference uses global MaxTransDiff=1, but for your structure that is too dense.
; Use 3 in top broad window.
(sdedr:define-refinement-function "RefDef.top"
  "DopingConcentration" "MaxTransDiff" 3)
;------------------------------------------------------------
; P-JTE / P-wall termination refinement
;------------------------------------------------------------

; P-JTE refinement
(sdedr:define-refinement-size "RefDef.pjte"
  2.0 1.5 0.5
  0.12 0.12 0.10)

(sdedr:define-refinement-function "RefDef.pjte"
  "DopingConcentration" "MaxTransDiff" 2)

(sdedr:define-refinement-placement "RefPlace.pjte.left"
  "RefDef.pjte"
  (list "window" "Win.pjte.left"))

(sdedr:define-refinement-placement "RefPlace.pjte.right"
  "RefDef.pjte"
  (list "window" "Win.pjte.right"))


;------------------------------------------------------------
; P-JTE termination refinement
;------------------------------------------------------------

(sdedr:define-refinement-size "RefDef.pjte"
  2.0 1.5 0.5
  0.12 0.12 0.10)

(sdedr:define-refinement-function "RefDef.pjte"
  "DopingConcentration" "MaxTransDiff" 2)

(sdedr:define-refinement-placement "RefPlace.pjte.left"
  "RefDef.pjte"
  (list "window" "Win.pjte.left"))

(sdedr:define-refinement-placement "RefPlace.pjte.right"
  "RefDef.pjte"
  (list "window" "Win.pjte.right"))


;------------------------------------------------------------
; JTE / P-base connection refinement
; The JTE-Pbase overlap region is likely to have high field.
;------------------------------------------------------------

(sdedr:define-refinement-size "RefDef.jteJoin"
  1.0 0.8 0.5
  0.08 0.08 0.10)

(sdedr:define-refinement-function "RefDef.jteJoin"
  "DopingConcentration" "MaxTransDiff" 2)

; Left JTE connects to the first P-base around yJTE.left.r
(sdedr:define-refeval-window "Win.jteJoin.left" "Rectangle"
  (position 0.0 (- yJTE.left.r 3.0) 0.0)
  (position (+ xJTE 1.0) (+ yJTE.left.r 3.0) 0.0))

(sdedr:define-refinement-placement "RefPlace.jteJoin.left"
  "RefDef.jteJoin"
  (list "window" "Win.jteJoin.left"))

; Right JTE connects to the last P-base around yJTE.right.l
(sdedr:define-refeval-window "Win.jteJoin.right" "Rectangle"
  (position 0.0 (- yJTE.right.l 3.0) 0.0)
  (position (+ xJTE 1.0) (+ yJTE.right.l 3.0) 0.0))

(sdedr:define-refinement-placement "RefPlace.jteJoin.right"
  "RefDef.jteJoin"
  (list "window" "Win.jteJoin.right"))

;------------------------------------------------------------
; 4. Channel / Si-Oxide interface refinement
;    Reference has Ref_Ch_Defn + MaxLenInt Silicon/Oxide.
;    Here we refine local channel windows only.
;------------------------------------------------------------

(define dch 0.10)

(sdedr:define-refinement-size "RefDef.channel"
  0.60 0.35 0.5
  0.035 0.035 0.10)

(sdedr:define-refinement-function "RefDef.channel"
  "MaxLenInt" "Silicon" "Oxide"
  0.006 1.6 "DoubleSide")

; Channel windows are placed around P-base side edges.
; These are the MOS channel / JFET access areas.
(define chPadY 2.0)

(do ((i 0 (+ i 1)))
    ((= i nPbase))

  (let* ((dy (* i pitch))

         (yl (+ pbody0.l dy))
         (yr (+ pbody0.r dy))

         (winChL (string-append "RefWin.channelL." (number->string i)))
         (plChL  (string-append "RefPlace.channelL." (number->string i)))

         (winChR (string-append "RefWin.channelR." (number->string i)))
         (plChR  (string-append "RefPlace.channelR." (number->string i))))

    ; Left channel side
    (sdedr:define-refeval-window winChL "Rectangle"
      (position (- 0.0 tOxide) (- yl chPadY) 0.0)
      (position dch           (+ yl chPadY) 0.0))

    (sdedr:define-refinement-placement plChL
      "RefDef.channel"
      (list "window" winChL))


    ; Right channel side
    (sdedr:define-refeval-window winChR "Rectangle"
      (position (- 0.0 tOxide) (- yr chPadY) 0.0)
      (position dch           (+ yr chPadY) 0.0))

    (sdedr:define-refinement-placement plChR
      "RefDef.channel"
      (list "window" winChR))))


;------------------------------------------------------------
; 5. N++ emitter / P-base junction refinement
;------------------------------------------------------------

(sdedr:define-refinement-size "RefDef.nplus"
  0.80 0.50 0.5
  0.055 0.055 0.10)

(sdedr:define-refinement-function "RefDef.nplus"
  "DopingConcentration" "MaxTransDiff" 2)

(define nplusPadY 0.8)
(define nplusX0 0.0)
(define nplusX1 1.6)

(do ((i 0 (+ i 1)))
    ((= i nPbase))

  (let* ((dy (* i pitch))

         (winNL (string-append "RefWin.nplusL." (number->string i)))
         (plNL  (string-append "RefPlace.nplusL." (number->string i)))

         (winNR (string-append "RefWin.nplusR." (number->string i)))
         (plNR  (string-append "RefPlace.nplusR." (number->string i))))

    ; Left N++ emitter
    (sdedr:define-refeval-window winNL "Rectangle"
      (position nplusX0 (- (+ nplusL0.l dy) nplusPadY) 0.0)
      (position nplusX1 (+ (+ nplusL0.r dy) nplusPadY) 0.0))

    (sdedr:define-refinement-placement plNL
      "RefDef.nplus"
      (list "window" winNL))


    ; Right N++ emitter
    (sdedr:define-refeval-window winNR "Rectangle"
      (position nplusX0 (- (+ nplusR0.l dy) nplusPadY) 0.0)
      (position nplusX1 (+ (+ nplusR0.r dy) nplusPadY) 0.0))

    (sdedr:define-refinement-placement plNR
      "RefDef.nplus"
      (list "window" winNR))))


;------------------------------------------------------------
; 6. P-base / N-drift lateral junction refinement
;------------------------------------------------------------

(sdedr:define-refinement-size "RefDef.pbaseEdge"
  1.0 0.50 0.5
  0.075 0.075 0.10)

(sdedr:define-refinement-function "RefDef.pbaseEdge"
  "DopingConcentration" "MaxTransDiff" 2)

(define pbaseEdgePadY 2.0)
(define pbaseEdgeX0 0.0)
(define pbaseEdgeX1 7.0)


;------------------------------------------------------------
; 7. P-base bottom junction refinement
;------------------------------------------------------------

(sdedr:define-refinement-size "RefDef.pbaseBottom"
  1.2 0.8 0.5
  0.10 0.10 0.10)

(sdedr:define-refinement-function "RefDef.pbaseBottom"
  "DopingConcentration" "MaxTransDiff" 2)

(define pbaseBottomX0 2.0)
(define pbaseBottomX1 8.0)


(do ((i 0 (+ i 1)))
    ((= i nPbase))

  (let* ((dy (* i pitch))

         (yl (+ pbody0.l dy))
         (yr (+ pbody0.r dy))

         (winL (string-append "RefWin.pbaseEdgeL." (number->string i)))
         (plL  (string-append "RefPlace.pbaseEdgeL." (number->string i)))

         (winR (string-append "RefWin.pbaseEdgeR." (number->string i)))
         (plR  (string-append "RefPlace.pbaseEdgeR." (number->string i)))

         (winB (string-append "RefWin.pbaseBottom." (number->string i)))
         (plB  (string-append "RefPlace.pbaseBottom." (number->string i))))

    ; Left P-base / N-drift side junction
    (sdedr:define-refeval-window winL "Rectangle"
      (position pbaseEdgeX0 (- yl pbaseEdgePadY) 0.0)
      (position pbaseEdgeX1 (+ yl pbaseEdgePadY) 0.0))

    (sdedr:define-refinement-placement plL
      "RefDef.pbaseEdge"
      (list "window" winL))


    ; Right P-base / N-drift side junction
    (sdedr:define-refeval-window winR "Rectangle"
      (position pbaseEdgeX0 (- yr pbaseEdgePadY) 0.0)
      (position pbaseEdgeX1 (+ yr pbaseEdgePadY) 0.0))

    (sdedr:define-refinement-placement plR
      "RefDef.pbaseEdge"
      (list "window" winR))


    ; Bottom P-base / N-drift junction
    (sdedr:define-refeval-window winB "Rectangle"
      (position pbaseBottomX0 yl 0.0)
      (position pbaseBottomX1 yr 0.0))

    (sdedr:define-refinement-placement plB
      "RefDef.pbaseBottom"
      (list "window" winB))))


;------------------------------------------------------------
; 8. JFET / N-drift gap refinement
;    Region between adjacent P-bases under the gate.
;------------------------------------------------------------

(sdedr:define-refinement-size "RefDef.jfet"
  1.5 0.8 0.5
  0.13 0.13 0.10)

(sdedr:define-refinement-function "RefDef.jfet"
  "DopingConcentration" "MaxTransDiff" 3)

(do ((i 0 (+ i 1)))
    ((= i (- nPbase 1)))

  (let* ((dy (* i pitch))

         ; Current P-base right edge
         (yr (+ pbody0.r dy))

         ; Next P-base left edge
         (ynext (+ pbody0.l (* (+ i 1) pitch)))

         (winJ (string-append "RefWin.jfet." (number->string i)))
         (plJ  (string-append "RefPlace.jfet." (number->string i))))

    (sdedr:define-refeval-window winJ "Rectangle"
      (position 0.0 yr 0.0)
      (position 8.0 ynext 0.0))

    (sdedr:define-refinement-placement plJ
      "RefDef.jfet"
      (list "window" winJ))))


;------------------------------------------------------------
; 9. Bottom collector / N-buffer refinement
;    Similar to reference Bot_Win, but localized near backside.
;------------------------------------------------------------

(sdedr:define-refinement-size "RefDef.bottom"
  3.0 2.0 0.5
  0.12 0.12 0.20)

(sdedr:define-refeval-window "RefWin.bottom" "Rectangle"
  (position (- Thick 10.0) 0.0 0.0)
  (position Thick Width 0.0))

(sdedr:define-refinement-placement "RefPlace.bottom"
  "RefDef.bottom"
  (list "window" "RefWin.bottom"))

(sdedr:define-refinement-function "RefDef.bottom"
  "DopingConcentration" "MaxTransDiff" 3)


;------------------------------------------------------------
; 10. N-buffer local refinement
;     Directly follows the new Nbuf_Win.
;------------------------------------------------------------

(sdedr:define-refinement-size "RefDef.nbuffer"
  2.0 1.5 0.5
  0.10 0.10 0.20)

(sdedr:define-refinement-function "RefDef.nbuffer"
  "DopingConcentration" "MaxTransDiff" 2)

(sdedr:define-refinement-placement "RefPlace.nbuffer"
  "RefDef.nbuffer"
  (list "window" "Nbuf_Win"))


;------------------------------------------------------------
; 11. P-collector / N-collector split refinement
;     Important for RC-IGBT reverse conduction and snapback.
;------------------------------------------------------------

(sdedr:define-refinement-size "RefDef.collectorSplit"
  1.5 0.8 0.5
  0.08 0.08 0.20)

(sdedr:define-refinement-function "RefDef.collectorSplit"
  "DopingConcentration" "MaxTransDiff" 2)

(sdedr:define-refeval-window "RefWin.collectorSplit" "Rectangle"
  (position (- Thick 8.0) (- wPcoll 5.0) 0.0)
  (position Thick       (+ wPcoll 5.0) 0.0))

(sdedr:define-refinement-placement "RefPlace.collectorSplit"
  "RefDef.collectorSplit"
  (list "window" "RefWin.collectorSplit"))


;------------------------------------------------------------
; 12. Disable offsetting
;     Reference uses channel-specific MaxLenInt.
;     For this structure, offsetting easily over-densifies the MOS surface.
;------------------------------------------------------------

; Do not use:
; (sdedr:offset-block ...)
; (sdedr:offset-interface ...)

;------------------------------------------------------------
; 13. Local convergence hot spots
;     Repeated CNormPrint errors occur at the first left MOS
;     channel/P-base edge and the lower-left collector corner.
;------------------------------------------------------------

(sdedr:define-refinement-size "RefDef.hotspot.channel.left"
  0.30 0.30 0.5
  0.025 0.025 0.10)

(sdedr:define-refinement-function "RefDef.hotspot.channel.left"
  "DopingConcentration" "MaxTransDiff" 1.5)

(sdedr:define-refeval-window "RefWin.hotspot.channel.left" "Rectangle"
  (position 0.0 52.0 0.0)
  (position 1.0 60.0 0.0))

(sdedr:define-refinement-placement "RefPlace.hotspot.channel.left"
  "RefDef.hotspot.channel.left"
  (list "window" "RefWin.hotspot.channel.left"))

(sdedr:define-refinement-size "RefDef.hotspot.collector.left"
  0.50 0.50 0.5
  0.04 0.04 0.10)

(sdedr:define-refinement-function "RefDef.hotspot.collector.left"
  "DopingConcentration" "MaxTransDiff" 1.5)

(sdedr:define-refeval-window "RefWin.hotspot.collector.left" "Rectangle"
  (position 95.0 0.0 0.0)
  (position Thick 5.0 0.0))

(sdedr:define-refinement-placement "RefPlace.hotspot.collector.left"
  "RefDef.hotspot.collector.left"
  (list "window" "RefWin.hotspot.collector.left"))


;------------------------------------------------------------
; Save BND and CMD, then run snmesh
;------------------------------------------------------------

(sdeio:save-tdr-bnd (get-body-list) "n4_bnd.tdr")

(sdedr:write-cmd-file "n4_msh.cmd")

(system:command "snmesh n4_msh")

