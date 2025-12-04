#!/bin/bash

awk '{print $2}' ctd_cis_dihedral_Phi.dat > Phi.dat
awk '{print $2}' ctd_cis_dihedral_Psi.dat > Psi.dat
awk '{print $2 " " $3}' ctd_cis_dihedral_Phi_Psi.dat > Phi_Psi.dat
awk '{print $2}' ctd_cis_dihedral_Omega.dat > Omega.dat
