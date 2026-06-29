Title ""

Controls {
}

IOControls {
	EnableSections
}

Definitions {
	Constant "Const.Substrate" {
		Species = "PhosphorusActiveConcentration"
		Value = 1e+15
	}
	AnalyticalProfile "Impl.pjteprof" {
		Species = "BoronActiveConcentration"
		Function = Gauss(PeakPos = 0, PeakVal = 5e+15, ValueAtDepth = 1e+15, Depth = 4)
		LateralFunction = Gauss(Factor = 0.8)
	}
	Constant "Const.PolyGate" {
		Species = "PhosphorusActiveConcentration"
		Value = 1e+21
	}
	AnalyticalProfile "Impl.pbodyprof" {
		Species = "BoronActiveConcentration"
		Function = Gauss(PeakPos = 0, PeakVal = 5e+17, ValueAtDepth = 1e+16, Depth = 3)
		LateralFunction = Erf(Length = 0.2)
	}
	AnalyticalProfile "Impl.nplusprof" {
		Species = "ArsenicActiveConcentration"
		Function = Gauss(PeakPos = 0, PeakVal = 1e+20, ValueAtDepth = 1e+18, Depth = 0.45)
		LateralFunction = Erf(Length = 0.08)
	}
	AnalyticalProfile "Impl.pbodyextenprof" {
		Species = "BoronActiveConcentration"
		Function = Gauss(PeakPos = 0, PeakVal = 1e+20, ValueAtDepth = 1e+17, Depth = 0.7)
		LateralFunction = Erf(Length = 0.1)
	}
	AnalyticalProfile "Impl.pcollectorprof" {
		Species = "BoronActiveConcentration"
		Function = Gauss(PeakPos = 0, PeakVal = 5e+19, ValueAtDepth = 5e+17, Depth = 5)
		LateralFunction = Erf(Length = 0.1)
	}
	AnalyticalProfile "Impl.ncollectorprof" {
		Species = "ArsenicActiveConcentration"
		Function = Gauss(PeakPos = 0, PeakVal = 4e+16, ValueAtDepth = 5e+14, Depth = 1)
		LateralFunction = Erf(Length = 0.1)
	}
	AnalyticalProfile "Impl.nbufferprof" {
		Species = "ArsenicActiveConcentration"
		Function = Gauss(PeakPos = 0, PeakVal = 1e+18, ValueAtDepth = 1e+14, Depth = 2)
		LateralFunction = Gauss(Factor = 0.8)
	}
	Refinement "RefDef.global" {
		MaxElementSize = ( 30 15 1 )
		MinElementSize = ( 0.5 0.5 0.5 )
	}
	Refinement "RefDef.drift" {
		MaxElementSize = ( 18 10 1 )
		MinElementSize = ( 1 1 0.5 )
	}
	Refinement "RefDef.top" {
		MaxElementSize = ( 2 1 0.5 )
		MinElementSize = ( 0.1 0.1 0.1 )
		RefineFunction = MaxTransDiff(Variable = "DopingConcentration",Value = 3)
	}
	Refinement "RefDef.pjte" {
		MaxElementSize = ( 2 1.5 0.5 )
		MinElementSize = ( 0.12 0.12 0.1 )
		RefineFunction = MaxTransDiff(Variable = "DopingConcentration",Value = 2)
	}
	Refinement "RefDef.jteJoin" {
		MaxElementSize = ( 1 0.8 0.5 )
		MinElementSize = ( 0.08 0.08 0.1 )
		RefineFunction = MaxTransDiff(Variable = "DopingConcentration",Value = 2)
	}
	Refinement "RefDef.channel" {
		MaxElementSize = ( 0.6 0.35 0.5 )
		MinElementSize = ( 0.035 0.035 0.1 )
		RefineFunction = MaxLenInt(Interface("Silicon","Oxide"), Value=0.006, factor=1.6, DoubleSide)
	}
	Refinement "RefDef.nplus" {
		MaxElementSize = ( 0.8 0.5 0.5 )
		MinElementSize = ( 0.055 0.055 0.1 )
		RefineFunction = MaxTransDiff(Variable = "DopingConcentration",Value = 2)
	}
	Refinement "RefDef.pbaseEdge" {
		MaxElementSize = ( 1 0.5 0.5 )
		MinElementSize = ( 0.075 0.075 0.1 )
		RefineFunction = MaxTransDiff(Variable = "DopingConcentration",Value = 2)
	}
	Refinement "RefDef.pbaseBottom" {
		MaxElementSize = ( 1.2 0.8 0.5 )
		MinElementSize = ( 0.1 0.1 0.1 )
		RefineFunction = MaxTransDiff(Variable = "DopingConcentration",Value = 2)
	}
	Refinement "RefDef.jfet" {
		MaxElementSize = ( 1.5 0.8 0.5 )
		MinElementSize = ( 0.13 0.13 0.1 )
		RefineFunction = MaxTransDiff(Variable = "DopingConcentration",Value = 3)
	}
	Refinement "RefDef.bottom" {
		MaxElementSize = ( 3 2 0.5 )
		MinElementSize = ( 0.12 0.12 0.2 )
		RefineFunction = MaxTransDiff(Variable = "DopingConcentration",Value = 3)
	}
	Refinement "RefDef.nbuffer" {
		MaxElementSize = ( 2 1.5 0.5 )
		MinElementSize = ( 0.1 0.1 0.2 )
		RefineFunction = MaxTransDiff(Variable = "DopingConcentration",Value = 2)
	}
	Refinement "RefDef.collectorSplit" {
		MaxElementSize = ( 1.5 0.8 0.5 )
		MinElementSize = ( 0.08 0.08 0.2 )
		RefineFunction = MaxTransDiff(Variable = "DopingConcentration",Value = 2)
	}
	Refinement "RefDef.hotspot.channel.left" {
		MaxElementSize = ( 0.3 0.3 0.5 )
		MinElementSize = ( 0.025 0.025 0.1 )
		RefineFunction = MaxTransDiff(Variable = "DopingConcentration",Value = 1.5)
	}
	Refinement "RefDef.hotspot.collector.left" {
		MaxElementSize = ( 0.5 0.5 0.5 )
		MinElementSize = ( 0.04 0.04 0.1 )
		RefineFunction = MaxTransDiff(Variable = "DopingConcentration",Value = 1.5)
	}
}

Placements {
	Constant "PlaceCD.Substrate" {
		Reference = "Const.Substrate"
		EvaluateWindow {
			Element = material ["Silicon"]
		}
	}
	AnalyticalProfile "Place.pjte.left" {
		Reference = "Impl.pjteprof"
		ReferenceElement {
			Element = Rectangle [(0 0) (4 57)]
			Direction = negative
		}
	}
	AnalyticalProfile "Place.pjte.right" {
		Reference = "Impl.pjteprof"
		ReferenceElement {
			Element = Rectangle [(0 159) (4 216)]
			Direction = negative
		}
	}
	Constant "PlaceCD.PolyGate" {
		Reference = "Const.PolyGate"
		EvaluateWindow {
			Element = material ["PolySi"]
		}
	}
	AnalyticalProfile "Impl.pbody.0" {
		Reference = "Impl.pbodyprof"
		ReferenceElement {
			Element = Line [(0 55) (0 73)]
			Direction = negative
		}
	}
	AnalyticalProfile "Impl.nplusL.0" {
		Reference = "Impl.nplusprof"
		ReferenceElement {
			Element = Line [(0 57.5) (0 61.5)]
			Direction = negative
		}
	}
	AnalyticalProfile "Impl.pbodyexten.0" {
		Reference = "Impl.pbodyextenprof"
		ReferenceElement {
			Element = Line [(0 61.5) (0 66.5)]
			Direction = negative
		}
	}
	AnalyticalProfile "Impl.nplusR.0" {
		Reference = "Impl.nplusprof"
		ReferenceElement {
			Element = Line [(0 66.5) (0 70.5)]
			Direction = negative
		}
	}
	AnalyticalProfile "Impl.pbody.1" {
		Reference = "Impl.pbodyprof"
		ReferenceElement {
			Element = Line [(0 77) (0 95)]
			Direction = negative
		}
	}
	AnalyticalProfile "Impl.nplusL.1" {
		Reference = "Impl.nplusprof"
		ReferenceElement {
			Element = Line [(0 79.5) (0 83.5)]
			Direction = negative
		}
	}
	AnalyticalProfile "Impl.pbodyexten.1" {
		Reference = "Impl.pbodyextenprof"
		ReferenceElement {
			Element = Line [(0 83.5) (0 88.5)]
			Direction = negative
		}
	}
	AnalyticalProfile "Impl.nplusR.1" {
		Reference = "Impl.nplusprof"
		ReferenceElement {
			Element = Line [(0 88.5) (0 92.5)]
			Direction = negative
		}
	}
	AnalyticalProfile "Impl.pbody.2" {
		Reference = "Impl.pbodyprof"
		ReferenceElement {
			Element = Line [(0 99) (0 117)]
			Direction = negative
		}
	}
	AnalyticalProfile "Impl.nplusL.2" {
		Reference = "Impl.nplusprof"
		ReferenceElement {
			Element = Line [(0 101.5) (0 105.5)]
			Direction = negative
		}
	}
	AnalyticalProfile "Impl.pbodyexten.2" {
		Reference = "Impl.pbodyextenprof"
		ReferenceElement {
			Element = Line [(0 105.5) (0 110.5)]
			Direction = negative
		}
	}
	AnalyticalProfile "Impl.nplusR.2" {
		Reference = "Impl.nplusprof"
		ReferenceElement {
			Element = Line [(0 110.5) (0 114.5)]
			Direction = negative
		}
	}
	AnalyticalProfile "Impl.pbody.3" {
		Reference = "Impl.pbodyprof"
		ReferenceElement {
			Element = Line [(0 121) (0 139)]
			Direction = negative
		}
	}
	AnalyticalProfile "Impl.nplusL.3" {
		Reference = "Impl.nplusprof"
		ReferenceElement {
			Element = Line [(0 123.5) (0 127.5)]
			Direction = negative
		}
	}
	AnalyticalProfile "Impl.pbodyexten.3" {
		Reference = "Impl.pbodyextenprof"
		ReferenceElement {
			Element = Line [(0 127.5) (0 132.5)]
			Direction = negative
		}
	}
	AnalyticalProfile "Impl.nplusR.3" {
		Reference = "Impl.nplusprof"
		ReferenceElement {
			Element = Line [(0 132.5) (0 136.5)]
			Direction = negative
		}
	}
	AnalyticalProfile "Impl.pbody.4" {
		Reference = "Impl.pbodyprof"
		ReferenceElement {
			Element = Line [(0 143) (0 161)]
			Direction = negative
		}
	}
	AnalyticalProfile "Impl.nplusL.4" {
		Reference = "Impl.nplusprof"
		ReferenceElement {
			Element = Line [(0 145.5) (0 149.5)]
			Direction = negative
		}
	}
	AnalyticalProfile "Impl.pbodyexten.4" {
		Reference = "Impl.pbodyextenprof"
		ReferenceElement {
			Element = Line [(0 149.5) (0 154.5)]
			Direction = negative
		}
	}
	AnalyticalProfile "Impl.nplusR.4" {
		Reference = "Impl.nplusprof"
		ReferenceElement {
			Element = Line [(0 154.5) (0 158.5)]
			Direction = negative
		}
	}
	AnalyticalProfile "Impl.pcollector" {
		Reference = "Impl.pcollectorprof"
		ReferenceElement {
			Element = Line [(100 0) (100 214)]
			Direction = positive
		}
	}
	AnalyticalProfile "Impl.nollector" {
		Reference = "Impl.ncollectorprof"
		ReferenceElement {
			Element = Line [(100 214) (100 216)]
			Direction = positive
		}
	}
	AnalyticalProfile "Impl.nbuffer" {
		Reference = "Impl.nbufferprof"
		ReferenceElement {
			Element = Rectangle [(92.8 0) (94.8 212)]
			Direction = negative
		}
	}
	Refinement "RefPlace.global" {
		Reference = "RefDef.global"
		RefineWindow = Rectangle [(-1 -1) (101 217)]
	}
	Refinement "RefPlace.drift" {
		Reference = "RefDef.drift"
		RefineWindow = Rectangle [(8 0) (90 216)]
	}
	Refinement "RefPlace.top" {
		Reference = "RefDef.top"
		RefineWindow = Rectangle [(-0.5 0) (8 216)]
	}
	Refinement "RefPlace.pjte.left" {
		Reference = "RefDef.pjte"
		RefineWindow = Rectangle [(0 0) (4 57)]
	}
	Refinement "RefPlace.pjte.right" {
		Reference = "RefDef.pjte"
		RefineWindow = Rectangle [(0 159) (4 216)]
	}
	Refinement "RefPlace.jteJoin.left" {
		Reference = "RefDef.jteJoin"
		RefineWindow = Rectangle [(0 54) (5 60)]
	}
	Refinement "RefPlace.jteJoin.right" {
		Reference = "RefDef.jteJoin"
		RefineWindow = Rectangle [(0 156) (5 162)]
	}
	Refinement "RefPlace.channelL.0" {
		Reference = "RefDef.channel"
		RefineWindow = Rectangle [(-0.06 53) (0.1 57)]
	}
	Refinement "RefPlace.channelR.0" {
		Reference = "RefDef.channel"
		RefineWindow = Rectangle [(-0.06 71) (0.1 75)]
	}
	Refinement "RefPlace.channelL.1" {
		Reference = "RefDef.channel"
		RefineWindow = Rectangle [(-0.06 75) (0.1 79)]
	}
	Refinement "RefPlace.channelR.1" {
		Reference = "RefDef.channel"
		RefineWindow = Rectangle [(-0.06 93) (0.1 97)]
	}
	Refinement "RefPlace.channelL.2" {
		Reference = "RefDef.channel"
		RefineWindow = Rectangle [(-0.06 97) (0.1 101)]
	}
	Refinement "RefPlace.channelR.2" {
		Reference = "RefDef.channel"
		RefineWindow = Rectangle [(-0.06 115) (0.1 119)]
	}
	Refinement "RefPlace.channelL.3" {
		Reference = "RefDef.channel"
		RefineWindow = Rectangle [(-0.06 119) (0.1 123)]
	}
	Refinement "RefPlace.channelR.3" {
		Reference = "RefDef.channel"
		RefineWindow = Rectangle [(-0.06 137) (0.1 141)]
	}
	Refinement "RefPlace.channelL.4" {
		Reference = "RefDef.channel"
		RefineWindow = Rectangle [(-0.06 141) (0.1 145)]
	}
	Refinement "RefPlace.channelR.4" {
		Reference = "RefDef.channel"
		RefineWindow = Rectangle [(-0.06 159) (0.1 163)]
	}
	Refinement "RefPlace.nplusL.0" {
		Reference = "RefDef.nplus"
		RefineWindow = Rectangle [(0 56.7) (1.6 62.3)]
	}
	Refinement "RefPlace.nplusR.0" {
		Reference = "RefDef.nplus"
		RefineWindow = Rectangle [(0 65.7) (1.6 71.3)]
	}
	Refinement "RefPlace.nplusL.1" {
		Reference = "RefDef.nplus"
		RefineWindow = Rectangle [(0 78.7) (1.6 84.3)]
	}
	Refinement "RefPlace.nplusR.1" {
		Reference = "RefDef.nplus"
		RefineWindow = Rectangle [(0 87.7) (1.6 93.3)]
	}
	Refinement "RefPlace.nplusL.2" {
		Reference = "RefDef.nplus"
		RefineWindow = Rectangle [(0 100.7) (1.6 106.3)]
	}
	Refinement "RefPlace.nplusR.2" {
		Reference = "RefDef.nplus"
		RefineWindow = Rectangle [(0 109.7) (1.6 115.3)]
	}
	Refinement "RefPlace.nplusL.3" {
		Reference = "RefDef.nplus"
		RefineWindow = Rectangle [(0 122.7) (1.6 128.3)]
	}
	Refinement "RefPlace.nplusR.3" {
		Reference = "RefDef.nplus"
		RefineWindow = Rectangle [(0 131.7) (1.6 137.3)]
	}
	Refinement "RefPlace.nplusL.4" {
		Reference = "RefDef.nplus"
		RefineWindow = Rectangle [(0 144.7) (1.6 150.3)]
	}
	Refinement "RefPlace.nplusR.4" {
		Reference = "RefDef.nplus"
		RefineWindow = Rectangle [(0 153.7) (1.6 159.3)]
	}
	Refinement "RefPlace.pbaseEdgeL.0" {
		Reference = "RefDef.pbaseEdge"
		RefineWindow = Rectangle [(0 53) (7 57)]
	}
	Refinement "RefPlace.pbaseEdgeR.0" {
		Reference = "RefDef.pbaseEdge"
		RefineWindow = Rectangle [(0 71) (7 75)]
	}
	Refinement "RefPlace.pbaseBottom.0" {
		Reference = "RefDef.pbaseBottom"
		RefineWindow = Rectangle [(2 55) (8 73)]
	}
	Refinement "RefPlace.pbaseEdgeL.1" {
		Reference = "RefDef.pbaseEdge"
		RefineWindow = Rectangle [(0 75) (7 79)]
	}
	Refinement "RefPlace.pbaseEdgeR.1" {
		Reference = "RefDef.pbaseEdge"
		RefineWindow = Rectangle [(0 93) (7 97)]
	}
	Refinement "RefPlace.pbaseBottom.1" {
		Reference = "RefDef.pbaseBottom"
		RefineWindow = Rectangle [(2 77) (8 95)]
	}
	Refinement "RefPlace.pbaseEdgeL.2" {
		Reference = "RefDef.pbaseEdge"
		RefineWindow = Rectangle [(0 97) (7 101)]
	}
	Refinement "RefPlace.pbaseEdgeR.2" {
		Reference = "RefDef.pbaseEdge"
		RefineWindow = Rectangle [(0 115) (7 119)]
	}
	Refinement "RefPlace.pbaseBottom.2" {
		Reference = "RefDef.pbaseBottom"
		RefineWindow = Rectangle [(2 99) (8 117)]
	}
	Refinement "RefPlace.pbaseEdgeL.3" {
		Reference = "RefDef.pbaseEdge"
		RefineWindow = Rectangle [(0 119) (7 123)]
	}
	Refinement "RefPlace.pbaseEdgeR.3" {
		Reference = "RefDef.pbaseEdge"
		RefineWindow = Rectangle [(0 137) (7 141)]
	}
	Refinement "RefPlace.pbaseBottom.3" {
		Reference = "RefDef.pbaseBottom"
		RefineWindow = Rectangle [(2 121) (8 139)]
	}
	Refinement "RefPlace.pbaseEdgeL.4" {
		Reference = "RefDef.pbaseEdge"
		RefineWindow = Rectangle [(0 141) (7 145)]
	}
	Refinement "RefPlace.pbaseEdgeR.4" {
		Reference = "RefDef.pbaseEdge"
		RefineWindow = Rectangle [(0 159) (7 163)]
	}
	Refinement "RefPlace.pbaseBottom.4" {
		Reference = "RefDef.pbaseBottom"
		RefineWindow = Rectangle [(2 143) (8 161)]
	}
	Refinement "RefPlace.jfet.0" {
		Reference = "RefDef.jfet"
		RefineWindow = Rectangle [(0 73) (8 77)]
	}
	Refinement "RefPlace.jfet.1" {
		Reference = "RefDef.jfet"
		RefineWindow = Rectangle [(0 95) (8 99)]
	}
	Refinement "RefPlace.jfet.2" {
		Reference = "RefDef.jfet"
		RefineWindow = Rectangle [(0 117) (8 121)]
	}
	Refinement "RefPlace.jfet.3" {
		Reference = "RefDef.jfet"
		RefineWindow = Rectangle [(0 139) (8 143)]
	}
	Refinement "RefPlace.bottom" {
		Reference = "RefDef.bottom"
		RefineWindow = Rectangle [(90 0) (100 216)]
	}
	Refinement "RefPlace.nbuffer" {
		Reference = "RefDef.nbuffer"
		RefineWindow = Rectangle [(92.8 0) (94.8 212)]
	}
	Refinement "RefPlace.collectorSplit" {
		Reference = "RefDef.collectorSplit"
		RefineWindow = Rectangle [(92 209) (100 219)]
	}
	Refinement "RefPlace.hotspot.channel.left" {
		Reference = "RefDef.hotspot.channel.left"
		RefineWindow = Rectangle [(0 52) (1 60)]
	}
	Refinement "RefPlace.hotspot.collector.left" {
		Reference = "RefDef.hotspot.collector.left"
		RefineWindow = Rectangle [(95 0) (100 5)]
	}
}

