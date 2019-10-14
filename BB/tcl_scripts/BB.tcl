#  This runs the basic default_richards test case.
#  This run, as written in this input file, should take
#  3 nonlinear iterations.

#
# Import the ParFlow TCL package
#
lappend auto_path $env(PARFLOW_DIR)/bin 
package require parflow
namespace import Parflow::*

pfset FileVersion 4

pfset Process.Topology.P        1
pfset Process.Topology.Q        1
pfset Process.Topology.R        1

#-----------------------------------------------------------------------------
# Make a directory for the simulation and copy inputs into it
#-----------------------------------------------------------------------------
exec mkdir "Outputs"
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
pfset GeomInput.Names "domain_input"

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

#-----------------------------------------------------------------------------
# Perm
#-----------------------------------------------------------------------------
pfset Geom.Perm.Names "domain"

pfset Geom.domain.Perm.Type     Constant
pfset Geom.domain.Perm.Value    0.0001

pfset Perm.TensorType               TensorByGeom

pfset Geom.Perm.TensorByGeom.Names  "domain"

pfset Geom.domain.Perm.TensorValX  1.0
pfset Geom.domain.Perm.TensorValY  1.0
pfset Geom.domain.Perm.TensorValZ  1.0

#-----------------------------------------------------------------------------
# Specific Storage
#-----------------------------------------------------------------------------

pfset SpecificStorage.Type            Constant
pfset SpecificStorage.GeomNames       "domain"
pfset Geom.domain.SpecificStorage.Value 1.0e-4

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
# Retardation
#-----------------------------------------------------------------------------
pfset Geom.Retardation.GeomNames           ""

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
pfset TimingInfo.StopTime        1000000.0
pfset TimingInfo.DumpInterval    1000.0

#pfset TimeStep.Type              Constant
#pfset TimeStep.Value             1.0

pfset TimeStep.Type              Growth
pfset TimeStep.InitialStep       0.0001
pfset TimeStep.GrowthFactor      1.4
pfset TimeStep.MaxStep           1000
pfset TimeStep.MinStep           0.0001

#-----------------------------------------------------------------------------
# Porosity
#-----------------------------------------------------------------------------

pfset Geom.Porosity.GeomNames          domain

pfset Geom.domain.Porosity.Type    Constant
pfset Geom.domain.Porosity.Value   0.1

#-----------------------------------------------------------------------------
# Domain
#-----------------------------------------------------------------------------
pfset Domain.GeomName domain

#-----------------------------------------------------------------------------
# Relative Permeability
#-----------------------------------------------------------------------------

pfset Phase.RelPerm.Type               VanGenuchten
pfset Phase.RelPerm.GeomNames          domain
pfset Geom.domain.RelPerm.Alpha        0.005
pfset Geom.domain.RelPerm.N            2.0    

#---------------------------------------------------------
# Saturation
#---------------------------------------------------------

pfset Phase.Saturation.Type            VanGenuchten
pfset Phase.Saturation.GeomNames       domain
pfset Geom.domain.Saturation.Alpha     0.005
pfset Geom.domain.Saturation.N         2.0
pfset Geom.domain.Saturation.SRes      0.2
pfset Geom.domain.Saturation.SSat      0.99

#-----------------------------------------------------------------------------
# Wells
#-----------------------------------------------------------------------------
pfset Wells.Names                           ""

#-----------------------------------------------------------------------------
# Time Cycles
#-----------------------------------------------------------------------------
pfset Cycle.Names constant
pfset Cycle.constant.Names		"alltime"
pfset Cycle.constant.alltime.Length	 1
pfset Cycle.constant.Repeat		-1

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
pfset Patch.top.BCPressure.alltime.Value	      0.0

#-----------------------------------------------------------------------------
# Topo slopes in x-direction
#-----------------------------------------------------------------------------
pfset TopoSlopesX.Type                                "PFBFile"
pfset TopoSlopesX.GeomNames                           "domain"
pfset TopoSlopesX.FileName                            "BB.slopex.pfb"

#---------------------------------------------------------
# Topo slopes in y-direction
#---------------------------------------------------------

pfset TopoSlopesY.Type "Constant"
pfset TopoSlopesY.GeomNames ""

pfset TopoSlopesY.Geom.domain.Value 0.0

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
pfset Solver.LSM                                        none
pfset Solver.CLM.CLMFileDir                           "clm_output/"
pfset Solver.CLM.Print1dOut                           False
pfset Solver.BinaryOutDir                             False
pfset Solver.CLM.CLMDumpInterval                      1
 
pfset Solver.CLM.MetForcing                           3D
pfset Solver.CLM.MetFileName                          "NLDAS"
pfset Solver.CLM.MetFilePath                          "../NLDAS/"
pfset Solver.CLM.MetFileNT                            24
pfset Solver.CLM.IstepStart                           1
 
pfset Solver.CLM.EvapBeta                             Linear
pfset Solver.CLM.VegWaterStress                       Saturation
pfset Solver.CLM.ResSat                               0.1
pfset Solver.CLM.WiltingPoint                         0.12
pfset Solver.CLM.FieldCapacity                        0.98
pfset Solver.CLM.IrrigationType                       none

pfset Solver.EvapTransFile                            True
pfset Solver.EvapTrans.FileName                       "BB_eff_rech.pfb"

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

#-----------------------------------------------------------------------------
# Phase sources:
#-----------------------------------------------------------------------------

pfset PhaseSources.water.Type                         Constant
pfset PhaseSources.water.GeomNames                    background
pfset PhaseSources.water.Geom.background.Value        0.0


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
# ParFlow Solution
pfset Solver                                          Richards
pfset Solver.TerrainFollowingGrid                     True
pfset Solver.Nonlinear.VariableDz                     True
pfset dzScale.GeomNames                               domain
pfset dzScale.Type                                    nzList
pfset dzScale.nzListNumber                            50 # 500 m total
pfset Cell.0.dzScale.Value                             20.0 #200 m
pfset Cell.1.dzScale.Value                             2.0 #100 m
pfset Cell.2.dzScale.Value                             2.0
pfset Cell.3.dzScale.Value                             2.0
pfset Cell.4.dzScale.Value                             2.0
pfset Cell.5.dzScale.Value                             2.0
pfset Cell.6.dzScale.Value                             1.0 #100 m
pfset Cell.7.dzScale.Value                             1.0
pfset Cell.8.dzScale.Value                             1.0
pfset Cell.9.dzScale.Value                             1.0
pfset Cell.10.dzScale.Value                            1.0
pfset Cell.11.dzScale.Value                            1.0
pfset Cell.12.dzScale.Value                            1.0
pfset Cell.13.dzScale.Value                            1.0
pfset Cell.14.dzScale.Value                            1.0
pfset Cell.15.dzScale.Value                            1.0 
pfset Cell.16.dzScale.Value                            0.5 #99 m
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
pfset Cell.35.dzScale.Value                            0.5
pfset Cell.36.dzScale.Value                            0.1
pfset Cell.37.dzScale.Value                            0.1
pfset Cell.38.dzScale.Value                            0.1
pfset Cell.39.dzScale.Value                            0.1
pfset Cell.40.dzScale.Value                            0.02 #1 m
pfset Cell.41.dzScale.Value                            0.02 
pfset Cell.42.dzScale.Value                            0.01
pfset Cell.43.dzScale.Value                            0.01
pfset Cell.44.dzScale.Value                            0.01
pfset Cell.45.dzScale.Value                            0.01
pfset Cell.46.dzScale.Value                            0.01
pfset Cell.47.dzScale.Value                            0.006
pfset Cell.48.dzScale.Value                            0.003
pfset Cell.49.dzScale.Value                            0.001

pfset Solver.MaxIter                                  25000
pfset Solver.Drop                                     1E-20
pfset Solver.AbsTol                                   1E-8
pfset Solver.MaxConvergenceFailures                   8
pfset Solver.Nonlinear.MaxIter                        80
pfset Solver.Nonlinear.ResidualTol                    1e-6

## new solver settings for Terrain Following Grid
pfset Solver.Nonlinear.EtaChoice                         EtaConstant
pfset Solver.Nonlinear.EtaValue                          0.001
pfset Solver.Nonlinear.UseJacobian                       True 
pfset Solver.Nonlinear.DerivativeEpsilon                 1e-16
pfset Solver.Nonlinear.StepTol	                         1e-30
pfset Solver.Nonlinear.Globalization                     LineSearch
pfset Solver.Linear.KrylovDimension                      70
pfset Solver.Linear.MaxRestarts                          2

pfset Solver.Linear.Preconditioner                       PFMG
pfset Solver.Linear.Preconditioner.PCMatrixType          FullJacobian

#keys for first round of spin-up
pfset OverlandFlowSpinUp                             1
pfset OverlandSpinupDampP1                           10.0
pfset OverlandSpinupDampP2                           0.1


#-----------------------------------------------------------------------------
# Distribute inputs
#-----------------------------------------------------------------------------
pfset ComputationalGrid.NX                873
pfset ComputationalGrid.NY                1 
pfset ComputationalGrid.NZ                1
pfdist BB.slopex.pfb

pfset ComputationalGrid.NX                873 
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


