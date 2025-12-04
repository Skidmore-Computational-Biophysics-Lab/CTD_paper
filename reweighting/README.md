Most scripts here are modified from the PyReweighting repository: https://github.com/MiaoLab20/pyreweighting

The gamd logs from each simulation of a CTD construct were combined by concatenating the last relevant number of frames of each log with 
the read_last_lines_gamd.sh script.

The reweight_angle.scr script was used to run the reweight_angle.ptraj script to produce dihedral angles for each residue in all trajectories.

Scripts run to produce weight files:

1. read_last_lines_gamd.sh
2. reweight_angle.scr
3. calc_dih.scr
4. reweight_full.scr
5. get_weights_by_frame.sh
