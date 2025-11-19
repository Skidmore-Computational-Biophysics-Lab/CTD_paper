#!/bin/bash -f
ATOMS="9 30 49 55 69 88 94 105 126 145 151 165 184 190 201 222 241 247 261 280 286"
for atom1 in $ATOMS; do
for atom2 in $ATOMS; do
if [[ $atom1 -eq $atom2 ]]; then
continue
fi
if test -f distances/${atom2}_${atom1}.dat; then
continue
fi
#  cp contact_distance.ptraj ${i}_${j}_distance.ptraj;
sed "s/XXXXX/$atom1/g" ptraj/CA_distances.ptraj > ptraj/temp.ptraj;
sed "s/YYYYY/$atom2/g" ptraj/temp.ptraj > ptraj/${atom1}_${atom2}_distance.ptraj;
cpptraj -i ptraj/${atom1}_${atom2}_distance.ptraj;
 
rm ptraj/${atom1}_${atom2}_distance.ptraj;
done
done