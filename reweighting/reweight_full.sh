####################################################
#IGNORE# Prepare input file "weights.dat" in the following format: 
#IGNORE# Column 1: dV in units of kbT; column 2: timestep; column 3: dV in units of kcal/mol
 
# For AMBER14: 
#gamd_all.log  | awk 'NR%1==0' | awk '{print ($8+$7)/(0.001987*300)"                " $2  "             " ($8+$7)}' > weights.dat
awk '{printf "%-15.6f %-10s %-10.6f\n", ($8+$7)/(0.001987*300), $2, ($8+$7)}' gamd_all.log > weights.dat

####################################################
# 1D data
# Prepare input data file "Psi.dat" in one column, e.g., a dihedral angle Psi
# cpptraj can be used for AMBER simulations

# Reweighting using cumulant expansion 
python PyReweighting-1D.py -input Psi.dat -cutoff 10 -Xdim -180 180 -disc 6 -Emax 20 -job amdweight_CE -weight weights.dat | tee -a reweight_variable_Psi.log
mv -v pmf-c1-Psi.dat.xvg pmf-Psi-reweight-CE1.xvg
mv -v pmf-c2-Psi.dat.xvg pmf-Psi-reweight-CE2.xvg
mv -v pmf-c3-Psi.dat.xvg pmf-Psi-reweight-CE3.xvg
mv -v weights-c1-Psi.dat.xvg weights-Psi-reweight-CE1.xvg
mv -v weights-c2-Psi.dat.xvg weights-Psi-reweight-CE2.xvg
mv -v weights-c3-Psi.dat.xvg weights-Psi-reweight-CE3.xvg

# Reweighting using Maclaurin series expansion
python PyReweighting-1D.py -input Psi.dat -disc 6 -Emax 20 -job amdweight_MC -order 10 -weight weights.dat | tee -a reweight_variable_Psi.log
mv -v pmf-Psi.dat.xvg pmf-Psi-reweight-MC-order10.xvg
mv -v weights-Psi.dat.xvg weights-Psi-reweight-MC-order10.xvg

# Reweighting using exponential average
python PyReweighting-1D.py -input Psi.dat -disc 6 -Emax 20 -job amdweight -weight weights.dat | tee -a reweight_variable_Psi.log
mv -v pmf-Psi.dat.xvg pmf-Psi-reweight.xvg
mv -v weights-Psi.dat.xvg weights-Psi-reweight.xvg

# Analyze boost potential distribution and anharmonicity
python PyReweighting-1D.py -input Psi.dat -cutoff 10 -Xdim -180 180 -disc 6 -Emax 20 -job amd_dV -weight weights.dat | tee -a reweight_variable_Psi.log

# NOTE: Check out cumulant expansion to the 2nd order "pmf-Psi-reweight-CE2.xvg"; normally it gives the most accurate result!

####################################################

# Reweighting using cumulant expansion 
python PyReweighting-1D.py -input Omega.dat -cutoff 10 -Xdim -180 180 -disc 6 -Emax 20 -job amdweight_CE -weight weights.dat | tee -a reweight_variable_Omega.log
mv -v pmf-c1-Omega.dat.xvg pmf-Omega-reweight-CE1.xvg
mv -v pmf-c2-Omega.dat.xvg pmf-Omega-reweight-CE2.xvg
mv -v pmf-c3-Omega.dat.xvg pmf-Omega-reweight-CE3.xvg
mv -v weights-c1-Omega.dat.xvg weights-Omega-reweight-CE1.xvg
mv -v weights-c2-Omega.dat.xvg weights-Omega-reweight-CE2.xvg
mv -v weights-c3-Omega.dat.xvg weights-Omega-reweight-CE3.xvg

# Reweighting using Maclaurin series expansion
python PyReweighting-1D.py -input Omega.dat -disc 6 -Emax 20 -job amdweight_MC -order 10 -weight weights.dat | tee -a reweight_variable_Omega.log
mv -v pmf-Omega.dat.xvg pmf-Omega-reweight-MC-order10.xvg
mv -v weights-Omega.dat.xvg weights-Omega-reweight-MC-order10.xvg

# Reweighting using exponential average
python PyReweighting-1D.py -input Omega.dat -disc 6 -Emax 20 -job amdweight -weight weights.dat | tee -a reweight_variable_Omega.log
mv -v pmf-Omega.dat.xvg pmf-Omega-reweight.xvg
mv -v weights-Omega.dat.xvg weights-Omega-reweight.xvg

# Analyze boost potential distribution and anharmonicity
python PyReweighting-1D.py -input Omega.dat -cutoff 10 -Xdim -180 180 -disc 6 -Emax 20 -job amd_dV -weight weights.dat | tee -a reweight_variable_Omega.log

# NOTE: Check out cumulant expansion to the 2nd order "pmf-Psi-reweight-CE2.xvg"; normally it gives the most accurate result!

####################################################
# 2D data
# Prepare input data file "Phi_Psi.dat" in two columns
# ptraj can be used for AMBER simulations

# Reweighting using cumulant expansion 
python PyReweighting-2D.py -cutoff 10 -input Phi_Psi.dat -Xdim -180 180 -discX 6 -Ydim -180 180 -discY 6 -Emax 20 -job amdweight_CE -weight weights.dat | tee -a reweight_variable.log
mv -v pmf-c1-Phi_Psi.dat.xvg pmf-2D-Phi_Psi-reweight-CE1.xvg
mv -v pmf-c2-Phi_Psi.dat.xvg pmf-2D-Phi_Psi-reweight-CE2.xvg
mv -v pmf-c3-Phi_Psi.dat.xvg pmf-2D-Phi_Psi-reweight-CE3.xvg
mv -v 2D_Free_energy_surface.png pmf-2D-Phi_Psi-reweight-CE2.png

# Reweighting using Maclaurin series expansion
python PyReweighting-2D.py -input Phi_Psi.dat -Emax 100 -discX 6 -discY 6 -job amdweight_MC -order 10 -weight weights.dat | tee -a reweight_variable.log
mv -v pmf-Phi_Psi.dat.xvg pmf-2D-Phi_Psi-reweight-MC-order10-disc6.xvg
mv -v 2D_Free_energy_surface.png pmf-2D-Phi_Psi-reweight-MC-order10-disc6.png

# Reweighting using exponential average
python PyReweighting-2D.py -input Phi_Psi.dat -Emax 20 -discX 6 -discY 6 -job amdweight -weight weights.dat | tee -a reweight_variable.log
mv -v pmf-Phi_Psi.dat.xvg pmf-2D-Phi_Psi-reweight.xvg
mv -v 2D_Free_energy_surface.png pmf-2D-Phi_Psi-reweight.png

# Analyze boost potential distribution and anharmonicity
python PyReweighting-2D.py -cutoff 10 -input Phi_Psi.dat -Xdim -180 180 -discX 6 -Ydim -180 180 -discY 6 -Emax 20 -job amd_dV -weight weights.dat | tee -a reweight_variable.log

# NOTES: 
# 1) Maclaurin series "pmf-2D-Phi_Psi-reweight-MC-order10-disc6.png" is equivalent to cumulant expansion on the 1st order "pmf-2D-Phi_Psi-reweight-CE1.xvg"
# 2) Check out cumulant expansion to the 2nd order "pmf-2D-Phi_Psi-reweight-CE2.png"; normally it gives the most accurate result!

