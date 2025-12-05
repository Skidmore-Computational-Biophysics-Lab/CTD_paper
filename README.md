# Overview
This repository contains the scripts used to analyze the data for the revised version of the preprint:

MR Cohen, W Chen, SM Dewing, WP Barr, KA Sethi, RB East, OC Onwuzulu, SA Showalter, KA Ball. RNA Polymerase II CTD Ser5 phosphorylation induces competing effects of expansion and compaction. bioRxiv 2025.09. 11.675598 (2025). doi:10.1101/2025.09.11.675598

## analysis_scripts/
This folder is organized by type of analysis. It includes ptraj scripts used to analyze data, and Jupyter Notebooks and Python scripts used to produce figures. For each type of analysis, instructions are provided for replicating our analysis methods. Data is omitted due to size restrictions.

## md_sim_files/
This folder contains starting structure files used for our simulations.

## reweighting/
This folder contains the scripts used for reweighting the frames from our GaMD simulations.

# Figures
Pathways to the Jupyter Notebooks that produced the figures in the manuscript and SI

Figure 3: (A) analysis_scripts/turn_and_cis/ctd_turn-pro13cis-Con.ipynb (B) analysis_scripts/turn_and_cis/ctd_turn-pro13cis-Asn.ipynb

Figure 4: (A) analysis_scripts/radius_of_gyration/radgyr_con.ipynb (B) analysis_scripts/radius_of_gyration/radgyr_asn.ipynb

Figure 5: (A) analysis_scripts/ser5_distances/ser5_distances_Con.ipynb (B) analysis_scripts/ser5_distances/ser5_distances_Asn.ipynb

Figure 6: (A & B) analysis_scripts/SAXS_Pr/SAXS_experimental_Pr.ipynb (C) analysis_scripts/SAXS_Pr/pair_distance_distribution_Con.ipynb (D) analysis_scripts/SAXS_Pr/pair_distance_distribution_Asn.ipynb

Figure 7: (A) analysis_scripts/turn_and_cis/ctd_turn-pro13cis-Con.ipynb (B) analysis_scripts/turn_and_cis/ctd_turn-pro13cis-Asn.ipynb

Figure 8: (A & C) analysis_scripts/turn_and_cis/ctd_turn-pro13cis-Con.ipynb (B & D) analysis_scripts/turn_and_cis/ctd_turn-pro13cis-Asn.ipynb

Figure 9: (A & C) analysis_scripts/radius_of_gyration/radgyr_con.ipynb (B & D) analysis_scripts/radius_of_gyration/radgyr_asn.ipynb (E) analysis_scripts/radius_of_gyration/radgyr_con.py (F) analysis_scripts/radius_of_gyration/radgyr_asn.py

Figure 10: (A-D) analysis_scripts/contact_maps_and_clustering/contact_maps.ipynb

Figure 11: (A & B) analysis_scripts/contact_maps_and_clustering/cluster_figure.ipynb

Figure 12: (A) analysis_scripts/res5-res7_distance/pS5-S7_histogram_Con.ipynb (B) analysis_scripts/res5-res7_distance/pS5-S7_histogram_Asn.ipynb
