#
# Import the ParFlow TCL package

lappend   auto_path $env(PARFLOW_DIR)/bin
package   require parflow
namespace import Parflow::*

pfset     FileVersion    4

#-----------------------------------------------------------------------------
# Set Processor topology 
#-----------------------------------------------------------------------------
pfset Process.Topology.P 1
pfset Process.Topology.Q 1
pfset Process.Topology.R 1
#-----------------------------------------------------------------------------
# Make a directory for the simulation and copy inputs into it
#-----------------------------------------------------------------------------
#exec mkdir "Outputs"
cd "./Outputs"

# ParFlow Inputs
  file copy -force "../../parflow_inputs/BB.slopex.pfb" .
# file copy -force "../../parflow_inputs/LW.slopey.pfb" .
# file copy -force "../../parflow_inputs/IndicatorFile_Gleeson.50z.pfb"   .
# file copy -force "../../parflow_inputs/press.init.pfb"  .
  file copy -force "../../parflow_inputs/BB_eff_rech.pfb" .


#CLM Inputs
# file copy -force "../../clm_inputs/drv_clmin.dat" .
# file copy -force "../../clm_inputs/drv_vegp.dat"  .
# file copy -force "../../clm_inputs/drv_vegm.alluv.dat"  . 

puts "Files Copied"

#---------------------------------------------------------
# Computational Grid
#---------------------------------------------------------
pfset ComputationalGrid.Lower.X                 0.0
pfset ComputationalGrid.Lower.Y                 0.0
pfset ComputationalGrid.Lower.Z                 0.0

pfset ComputationalGrid.DX	                 	10.0
pfset ComputationalGrid.DY                      10.0
pfset ComputationalGrid.DZ	                 	10.0

pfset ComputationalGrid.NX                      1294
pfset ComputationalGrid.NY                      1
pfset ComputationalGrid.NZ                      50


#---------------------------------------------------------
# The Names of the GeomInputs
#---------------------------------------------------------
pfset GeomInput.Names "domain_input basalt_input granite_input"


#---------------------------------------------------------
# Domain Geometry Input
#---------------------------------------------------------
pfset GeomInput.domain_input.InputType            Box
pfset GeomInput.domain_input.GeomName             domain


#---------------------------------------------------------
# Domain Geometry
#---------------------------------------------------------
pfset Geom.domain.Lower.X                          0.0 
pfset Geom.domain.Lower.Y                          0.0
pfset Geom.domain.Lower.Z                          0.0

pfset Geom.domain.Upper.X                          12940.0
pfset Geom.domain.Upper.Y                          10.0
pfset Geom.domain.Upper.Z                          500.0

pfset Geom.domain.Patches "left right front back bottom top"

#---------------------------------------------------------
# Basalt Geometry Input
#---------------------------------------------------------
pfset GeomInput.basalt_input.InputType            Box
pfset GeomInput.basalt_input.GeomName             basalt


#---------------------------------------------------------
# Basalt Geometry
#---------------------------------------------------------
pfset Geom.basalt.Lower.X                          0.0 
pfset Geom.basalt.Lower.Y                          0.0
pfset Geom.basalt.Lower.Z                          400.0

pfset Geom.basalt.Upper.X                          12940.0
pfset Geom.basalt.Upper.Y                          10.0
pfset Geom.basalt.Upper.Z                          500.0

pfset Geom.basalt.Patches "left right front back bottom top"

#---------------------------------------------------------
# Granite Geometry Input
#---------------------------------------------------------
pfset GeomInput.granite_input.InputType            Box
pfset GeomInput.granite_input.GeomName             granite


#---------------------------------------------------------
# Granite Geometry
#---------------------------------------------------------
pfset Geom.granite.Lower.X                          0.0 
pfset Geom.granite.Lower.Y                          0.0
pfset Geom.granite.Lower.Z                          0.0

pfset Geom.granite.Upper.X                          12940.0
pfset Geom.granite.Upper.Y                          10.0
pfset Geom.granite.Upper.Z                          400.0

pfset Geom.granite.Patches "left right front back bottom top"

#-----------------------------------------------------------------------------
# Perm
#-----------------------------------------------------------------------------
# pfset Geom.Perm.Names "domain"
# 
# pfset Geom.domain.Perm.Type     Constant
# pfset Geom.domain.Perm.Value    0.036 

pfset Geom.Perm.Names "basalt granite"

pfset Geom.basalt.Perm.Type     Constant
pfset Geom.basalt.Perm.Value    0.036

pfset Geom.granite.Perm.Type     Constant
pfset Geom.granite.Perm.Value    0.00036


pfset Perm.TensorType               TensorByGeom

pfset Geom.Perm.TensorByGeom.Names  "domain"

pfset Geom.domain.Perm.TensorValX  1.0d0
pfset Geom.domain.Perm.TensorValY  1.0d0
pfset Geom.domain.Perm.TensorValZ  1.0d0


#-----------------------------------------------------------------------------
# Specific Storage
#-----------------------------------------------------------------------------
pfset SpecificStorage.Type                Constant
pfset SpecificStorage.GeomNames           "domain"
pfset Geom.domain.SpecificStorage.Value   1.0e-5

#-----------------------------------------------------------------------------
# Phases
#-----------------------------------------------------------------------------

pfset Phase.Names "water"

pfset Phase.water.Density.Type	Constant
pfset Phase.water.Density.Value	1.0

pfset Phase.water.Viscosity.Type	Constant
pfset Phase.water.Viscosity.Value	1.0

#-----------------------------------------------------------------------------
# Contaminants
#-----------------------------------------------------------------------------
pfset Contaminants.Names			""

#-----------------------------------------------------------------------------
# Gravity
#-----------------------------------------------------------------------------

pfset Gravity				1.0

#-----------------------------------------------------------------------------
# Setup timing info
#-----------------------------------------------------------------------------

pfset TimingInfo.BaseUnit        1.0
pfset TimingInfo.StartCount      0.0
pfset TimingInfo.StartTime       0.0
pfset TimingInfo.StopTime        10000000.0
pfset TimingInfo.DumpInterval    100000.0


pfset TimeStep.Type              Growth
pfset TimeStep.InitialStep       0.0001
pfset TimeStep.GrowthFactor      1.01
pfset TimeStep.MaxStep           100
pfset TimeStep.MinStep           0.0001

# pfset TimingInfo.BaseUnit        10.0
# pfset TimingInfo.StartCount      0
# pfset TimingInfo.StartTime       0.0
# pfset TimingInfo.StopTime        7000.0
# pfset TimingInfo.DumpInterval    1000.0
# pfset TimeStep.Type              Constant
# pfset TimeStep.Value             1000.0

#-----------------------------------------------------------------------------
# Porosity
#-----------------------------------------------------------------------------

# pfset Geom.Porosity.GeomNames          "domain"
# 
# pfset Geom.domain.Porosity.Type    Constant
# pfset Geom.domain.Porosity.Value   0.1

pfset Geom.Porosity.GeomNames          "basalt granite"

pfset Geom.basalt.Porosity.Type    Constant
pfset Geom.basalt.Porosity.Value   0.1

pfset Geom.granite.Porosity.Type    Constant
pfset Geom.granite.Porosity.Value   0.05

#-----------------------------------------------------------------------------
# Domain
#-----------------------------------------------------------------------------
pfset Domain.GeomName "domain"

#----------------------------------------------------------------------------
# Mobility
#----------------------------------------------------------------------------
pfset Phase.water.Mobility.Type        Constant
pfset Phase.water.Mobility.Value       1.0

#-----------------------------------------------------------------------------
# Wells
#-----------------------------------------------------------------------------
pfset Wells.Names                         ""

#-----------------------------------------------------------------------------
# Time Cycles
#-----------------------------------------------------------------------------
pfset Cycle.Names                         "constant"
pfset Cycle.constant.Names                "alltime"
pfset Cycle.constant.alltime.Length        1
pfset Cycle.constant.Repeat               -1

#-----------------------------------------------------------------------------
# Relative Permeability
#-----------------------------------------------------------------------------

pfset Phase.RelPerm.Type               VanGenuchten
pfset Phase.RelPerm.GeomNames          "domain"
pfset Geom.domain.RelPerm.Alpha        3.5
pfset Geom.domain.RelPerm.N            2.0    


#---------------------------------------------------------
# Saturation
#---------------------------------------------------------

pfset Phase.Saturation.Type            VanGenuchten
pfset Phase.Saturation.GeomNames       "domain"
pfset Geom.domain.Saturation.Alpha     3.5
pfset Geom.domain.Saturation.N         2.0
pfset Geom.domain.Saturation.SRes      0.02
pfset Geom.domain.Saturation.SSat      1.0


#-----------------------------------------------------------------------------
# Boundary Conditions: Pressure
#-----------------------------------------------------------------------------
pfset BCPressure.PatchNames "left right front back bottom top"

pfset Patch.left.BCPressure.Type			FluxConst
pfset Patch.left.BCPressure.Cycle			"constant"
pfset Patch.left.BCPressure.alltime.Value		0.0

pfset Patch.right.BCPressure.Type			FluxConst
pfset Patch.right.BCPressure.Cycle			"constant"
pfset Patch.right.BCPressure.alltime.Value		0.0

pfset Patch.front.BCPressure.Type			FluxConst
pfset Patch.front.BCPressure.Cycle			"constant"
pfset Patch.front.BCPressure.alltime.Value		0.0

pfset Patch.back.BCPressure.Type			FluxConst
pfset Patch.back.BCPressure.Cycle			"constant"
pfset Patch.back.BCPressure.alltime.Value		0.0

pfset Patch.bottom.BCPressure.Type			FluxConst
pfset Patch.bottom.BCPressure.Cycle			"constant"
pfset Patch.bottom.BCPressure.alltime.Value		0.0

pfset Patch.top.BCPressure.Type		             OverlandFlow
pfset Patch.top.BCPressure.Cycle		            "constant"
pfset Patch.top.BCPressure.alltime.Value	     		0.0

pfset Solver.EvapTransFile                            True
pfset Solver.EvapTrans.FileName                       "BB_eff_rech.pfb"



#-----------------------------------------------------------------------------
# Topo slopes in x-direction
#-----------------------------------------------------------------------------
pfset TopoSlopesX.Type                                "PFBFile"
pfset TopoSlopesX.GeomNames                           "domain"
pfset TopoSlopesX.FileName                            "BB.slopex.pfb"

# pfset TopoSlopesX.Type "Constant"
# pfset TopoSlopesX.GeomNames "domain"
# 
# pfset TopoSlopesX.Geom.domain.Value 0.0
# 

#---------------------------------------------------------
# Topo slopes in y-direction
#---------------------------------------------------------

pfset TopoSlopesY.Type 								"Constant"
pfset TopoSlopesY.GeomNames 						"domain"
pfset TopoSlopesY.Geom.domain.Value 					0.0


#-----------------------------------------------------------------------------
# Mannings coefficient
#-----------------------------------------------------------------------------
pfset Mannings.Type                                   "Constant"
pfset Mannings.GeomNames                              "domain"
pfset Mannings.Geom.domain.Value                       5.52e-6


#----------------------------------------------------------------
# CLM Settings:
# ------------------------------------------------------------
#for spin-up runs, CLM is initially turned off
#pfset Solver.LSM                                        none
# pfset Solver.CLM.CLMFileDir                           "clm_output/"
# pfset Solver.CLM.Print1dOut                           False
# pfset Solver.BinaryOutDir                             False
# pfset Solver.CLM.CLMDumpInterval                      1
 
# pfset Solver.CLM.MetForcing                           3D
# pfset Solver.CLM.MetFileName                          "NLDAS"
# pfset Solver.CLM.MetFilePath                          "../NLDAS/"
# pfset Solver.CLM.MetFileNT                            24
# pfset Solver.CLM.IstepStart                           1
 
# pfset Solver.CLM.EvapBeta                             Linear
# pfset Solver.CLM.VegWaterStress                       Saturation
# pfset Solver.CLM.ResSat                               0.1
# pfset Solver.CLM.WiltingPoint                         0.12
# pfset Solver.CLM.FieldCapacity                        0.98
# pfset Solver.CLM.IrrigationType                       none



#---------------------------------------------------------
# Initial conditions: water pressure
#---------------------------------------------------------

#pfset ICPressure.Type	 	                               PFBFile
#pfset ICPressure.GeomNames                             domain
#pfset Geom.domain.ICPressure.RefPatch                  z-upper
#pfset Geom.domain.ICPressure.FileName                  tucson.out.press.00030.pfb

pfset ICPressure.Type                                   HydroStaticPatch
pfset ICPressure.GeomNames                              domain
pfset Geom.domain.ICPressure.Value                      0.0
pfset Geom.domain.ICPressure.RefGeom                    domain
pfset Geom.domain.ICPressure.RefPatch                   bottom

pfset OverlandFlowSpinUp  1
pfset OverlandSpinupDampP1 1.0
pfset OverlandSpinupDampP2 0.00001

#-----------------------------------------------------------------------------
# Phase sources:
#-----------------------------------------------------------------------------
pfset PhaseSources.water.Type                         "Constant"
pfset PhaseSources.water.GeomNames                    "domain"
pfset PhaseSources.water.Geom.domain.Value            0.0

#-----------------------------------------------------------------------------
# Exact solution specification for error calculations
#-----------------------------------------------------------------------------

pfset KnownSolution                                    NoKnownSolution


#----------------------------------------------------------------
# Outputs
# ------------------------------------------------------------
#Writing output (all pfb):
pfset Solver.PrintSubsurfData                         True
pfset Solver.PrintPressure                            True
pfset Solver.PrintSaturation                          True
pfset Solver.PrintMask                                True

pfset Solver.WriteCLMBinary                           False
pfset Solver.PrintCLM                                 False
pfset Solver.WriteSiloSpecificStorage                 False
pfset Solver.WriteSiloMannings                        False
pfset Solver.WriteSiloMask                            False
pfset Solver.WriteSiloSlopes                          False
pfset Solver.WriteSiloSubsurfData                     False
pfset Solver.WriteSiloPressure                        False
pfset Solver.WriteSiloSaturation                      False
pfset Solver.WriteSiloEvapTrans                       False
pfset Solver.WriteSiloEvapTransSum                    False
pfset Solver.WriteSiloOverlandSum                     False
pfset Solver.WriteSiloCLM                             False


#-----------------------------------------------------------------------------
# Set solver parameters
#-----------------------------------------------------------------------------
# Variable dz
pfset Solver.Nonlinear.VariableDz                     True
pfset dzScale.GeomNames                               domain
pfset dzScale.Type                                    nzList
pfset dzScale.nzListNumber                            50 
pfset Cell.0.dzScale.Value                             10.0 
pfset Cell.1.dzScale.Value                             8.0 
pfset Cell.2.dzScale.Value                             6.0
pfset Cell.3.dzScale.Value                             2.0
pfset Cell.4.dzScale.Value                             2.0
pfset Cell.5.dzScale.Value                             2.0 
pfset Cell.6.dzScale.Value                             1.0 
pfset Cell.7.dzScale.Value                             1.0
pfset Cell.8.dzScale.Value                             1.0
pfset Cell.9.dzScale.Value                             1.0
pfset Cell.10.dzScale.Value                            1.0
pfset Cell.11.dzScale.Value                            1.0
pfset Cell.12.dzScale.Value                            1.0
pfset Cell.13.dzScale.Value                            1.0
pfset Cell.14.dzScale.Value                            1.0
pfset Cell.15.dzScale.Value                            1.0 
pfset Cell.16.dzScale.Value                            0.5 
pfset Cell.17.dzScale.Value                            0.5
pfset Cell.18.dzScale.Value                            0.5
pfset Cell.19.dzScale.Value                            0.5
pfset Cell.20.dzScale.Value                            0.5
pfset Cell.21.dzScale.Value                            0.5
pfset Cell.22.dzScale.Value                            0.5
pfset Cell.23.dzScale.Value                            0.5
pfset Cell.24.dzScale.Value                            0.5
pfset Cell.25.dzScale.Value                            0.5
pfset Cell.26.dzScale.Value                            0.5
pfset Cell.27.dzScale.Value                            0.5
pfset Cell.28.dzScale.Value                            0.5
pfset Cell.29.dzScale.Value                            0.5
pfset Cell.30.dzScale.Value                            0.5
pfset Cell.31.dzScale.Value                            0.5
pfset Cell.32.dzScale.Value                            0.5
pfset Cell.33.dzScale.Value                            0.5
pfset Cell.34.dzScale.Value                            0.5 
pfset Cell.35.dzScale.Value                            0.1 
pfset Cell.36.dzScale.Value                            0.1
pfset Cell.37.dzScale.Value                            0.1
pfset Cell.38.dzScale.Value                            0.05
pfset Cell.39.dzScale.Value                            0.05 
pfset Cell.40.dzScale.Value                            0.02 
pfset Cell.41.dzScale.Value                            0.02 
pfset Cell.42.dzScale.Value                            0.01
pfset Cell.43.dzScale.Value                            0.01
pfset Cell.44.dzScale.Value                            0.01
pfset Cell.45.dzScale.Value                            0.01
pfset Cell.46.dzScale.Value                            0.01
pfset Cell.47.dzScale.Value                            0.006
pfset Cell.48.dzScale.Value                            0.003
pfset Cell.49.dzScale.Value                            0.001 

#Parflow solution
pfset Solver                                             Richards
pfset Solver.MaxIter                                     2500

pfset Solver.TerrainFollowingGrid                        True


pfset Solver.Nonlinear.MaxIter                           80 
pfset Solver.Nonlinear.ResidualTol                       1e-5
pfset Solver.Nonlinear.EtaValue                          0.001


pfset Solver.PrintSubsurf								False
pfset  Solver.Drop                                      1E-20
pfset Solver.AbsTol                                     1E-10


pfset Solver.Nonlinear.EtaChoice                         EtaConstant
pfset Solver.Nonlinear.EtaValue                          0.001
pfset Solver.Nonlinear.UseJacobian                       True 
pfset Solver.Nonlinear.StepTol							 1e-25
pfset Solver.Nonlinear.Globalization                     LineSearch
pfset Solver.Linear.KrylovDimension                      80
pfset Solver.Linear.MaxRestarts                           2

pfset Solver.Linear.Preconditioner                       MGSemi
pfset Solver.Linear.Preconditioner                       PFMG
pfset Solver.Linear.Preconditioner.PCMatrixType     	FullJacobian


#-----------------------------------------------------------------------------
# Distribute inputs
#-----------------------------------------------------------------------------
pfset ComputationalGrid.NX                1294
pfset ComputationalGrid.NY                1 
pfset ComputationalGrid.NZ                1
pfdist BB.slopex.pfb

pfset ComputationalGrid.NX                1294 
pfset ComputationalGrid.NY                1 
pfset ComputationalGrid.NZ                50
#pfdist geology_indicator.pfb
pfdist BB_eff_rech.pfb


#-----------------------------------------------------------------------------
# Run Simulation 
#-----------------------------------------------------------------------------
set runname "BB"
puts $runname
#pfwritedb $runname
pfrun    $runname

##-----------------------------------------------------------------------------
## Undistribute outputs
##-----------------------------------------------------------------------------
pfundist $runname
#pfundist press.init.pfb
pfundist BB.slopex.pfb
#pfundist tucson.slopey.pfb
#pfundist geology_indicator.pfb
pfundist BB_eff_rech.pfb

puts "ParFlow run Complete"

#


