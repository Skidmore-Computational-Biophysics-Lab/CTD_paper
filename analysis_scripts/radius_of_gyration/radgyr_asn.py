import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

# angle bounds for determining cis vs trans configurations

cislower = -90
cisupper = 50
translower = 100
transupper = 240

nsim = 10 # number of simulations

ctd_weights_combined_raw = pd.read_table('/data/mcohen3/CTD/asparagine/s5n7/reweighting/weights_by_frame_MC-order10.dat', header=None)
p_ctd_weights_combined_raw = pd.read_table('/data/mcohen3/CTD/asparagine/ps5n7/reweighting/weights_by_frame_MC-order10.dat', header=None)

ctd_weights_combined = ctd_weights_combined_raw/ctd_weights_combined_raw.sum()
p_ctd_weights_combined = p_ctd_weights_combined_raw/p_ctd_weights_combined_raw.sum()

ctd = pd.read_table('/data/mcohen3/CTD/asparagine/s5n7/analysis/radgyr/radgyr_a_ctd.dat', sep = r'\s+')
ctd = ctd.drop(['1-23[Max]'],axis=1)

ctd_p = pd.read_table('/data/mcohen3/CTD/asparagine/ps5n7/analysis/radgyr/radgyr_a_ctd_p.dat', sep = r'\s+')
ctd_p = ctd_p.drop(['1-23[Max]'],axis=1)

ctd_omega_angles_raw = pd.read_table('/data/mcohen3/CTD/asparagine/s5n7/analysis/turn/ctd_dihedral_Omega.dat', sep = r'\s+')
ctd_phos_omega_angles_raw = pd.read_table('/data/mcohen3/CTD/asparagine/ps5n7/analysis/turn/ctd_dihedral_Omega.dat', sep = r'\s+')

ctd['weights'] = ctd_weights_combined[0]
ctd_p['weights'] = p_ctd_weights_combined[0]

df_360 = ctd_omega_angles_raw.copy()
# loop through columns to convert numbers below -90
for col in df_360:
    df_360.loc[df_360[col] < -90, col] += 360  # Convert negative angles to a 0-360 range
    df_360[col] = round(df_360[col])  # Round angles to the nearest integer

df_360_phos = ctd_phos_omega_angles_raw # Create a new column to hold the 360-degree adjusted omega values
# loop through columns to convert numbers below -90
for col in df_360_phos:
    df_360_phos.loc[df_360_phos[col] < -90, col] += 360  # Convert negative angles to a 0-360 range
    df_360_phos[col] = round(df_360_phos[col])  # Round angles to the nearest integer

# retaining omega angle values
ctd_phos_omega_angles = df_360_phos.copy()
ctd_omega_angles = df_360.copy()

# labelling configurationgs of omega angles
temp_angles = ctd_phos_omega_angles.copy()

ctd_phos_omega_angles[(temp_angles.iloc[:,1:] >= cislower) & (temp_angles.iloc[:,1:] <= cisupper)] = "cis"
ctd_phos_omega_angles[(temp_angles.iloc[:,1:] >= translower) & (temp_angles.iloc[:,1:] <= transupper)] = "trans"
ctd_phos_omega_angles[(ctd_phos_omega_angles.iloc[:,1:] != "cis") & (ctd_phos_omega_angles.iloc[:,1:] != "trans")] = "neither"

temp_angles = ctd_omega_angles.copy()

ctd_omega_angles[(temp_angles.iloc[:,1:] >= cislower) & (temp_angles.iloc[:,1:] <= cisupper)] = "cis"
ctd_omega_angles[(temp_angles.iloc[:,1:] >= translower) & (temp_angles.iloc[:,1:] <= transupper)] = "trans"
ctd_omega_angles[(ctd_omega_angles.iloc[:,1:] != "cis") & (ctd_omega_angles.iloc[:,1:] != "trans")] = "neither"

ctd_num_cis = pd.DataFrame((ctd_omega_angles['omega:4'] == 'cis').astype(int) + (ctd_omega_angles['omega:7'] == 'cis').astype(int)
+ (ctd_omega_angles['omega:11'] == 'cis').astype(int) + (ctd_omega_angles['omega:14'] == 'cis').astype(int)
+ (ctd_omega_angles['omega:18'] == 'cis').astype(int) + (ctd_omega_angles['omega:21'] == 'cis').astype(int))

ctd_phos_num_cis = pd.DataFrame((ctd_phos_omega_angles['omega:4'] == 'cis').astype(int) + (ctd_phos_omega_angles['omega:7'] == 'cis').astype(int)
+ (ctd_phos_omega_angles['omega:11'] == 'cis').astype(int) + (ctd_phos_omega_angles['omega:14'] == 'cis').astype(int)
+ (ctd_phos_omega_angles['omega:18'] == 'cis').astype(int) + (ctd_phos_omega_angles['omega:21'] == 'cis').astype(int))

ctd['num Pro in cis'] = ctd_num_cis[0]
ctd_p['num Pro in cis'] = ctd_phos_num_cis[0]

ctd_sim_list = np.array_split(ctd, nsim)
p_ctd_sim_list = np.array_split(ctd_p, nsim)

# Define column names
columns = ['cis_0', 'cis_1', 'cis_2', 'cis_3', 'cis_4', 'cis_5', 'cis_6']

# Create an empty DataFrame with 2 rows and 5 columns
cis_radgyr = pd.DataFrame(np.nan, index=range(nsim), columns=columns)

i = 0
for sim in ctd_sim_list:
    
    cis_0_true = ((sim['num Pro in cis'] == 0)*sim['weights']).sum()
    cis_1_true = ((sim['num Pro in cis'] == 1)*sim['weights']).sum()
    cis_2_true = ((sim['num Pro in cis'] == 2)*sim['weights']).sum()
    cis_3_true = ((sim['num Pro in cis'] == 3)*sim['weights']).sum()
    cis_4_true = ((sim['num Pro in cis'] == 4)*sim['weights']).sum()
    cis_5_true = ((sim['num Pro in cis'] == 5)*sim['weights']).sum()
    cis_6_true = ((sim['num Pro in cis'] == 6)*sim['weights']).sum()

    mean = sim['1-23'].mul((sim['num Pro in cis'] == 0)*sim['weights'], 0).sum()/cis_0_true
    cis_radgyr.at[i, 'cis_0'] = mean
    mean = sim['1-23'].mul((sim['num Pro in cis'] == 1)*sim['weights'], 0).sum()/cis_1_true
    cis_radgyr.at[i, 'cis_1'] = mean
    mean = sim['1-23'].mul((sim['num Pro in cis'] == 2)*sim['weights'], 0).sum()/cis_2_true
    cis_radgyr.at[i, 'cis_2'] = mean
    mean = sim['1-23'].mul((sim['num Pro in cis'] == 3)*sim['weights'], 0).sum()/cis_3_true
    cis_radgyr.at[i, 'cis_3'] = mean
    mean = sim['1-23'].mul((sim['num Pro in cis'] == 4)*sim['weights'], 0).sum()/cis_4_true
    cis_radgyr.at[i, 'cis_4'] = mean
    mean = sim['1-23'].mul((sim['num Pro in cis'] == 5)*sim['weights'], 0).sum()/cis_5_true
    cis_radgyr.at[i, 'cis_5'] = mean
    mean = sim['1-23'].mul((sim['num Pro in cis'] == 6)*sim['weights'], 0).sum()/cis_6_true
    cis_radgyr.at[i, 'cis_6'] = mean
    
    i += 1

# Calculate the SEM (standard error of the mean)
mean_values = cis_radgyr.mean()
sem_values = cis_radgyr.sem()

# Append as a new row labeled 'sem'
df_with_mean = pd.concat([cis_radgyr, pd.DataFrame([mean_values], index=['mean'])])
cis_radgyr_final = pd.concat([df_with_mean, pd.DataFrame([sem_values], index=['sem'])])

cis_radgyr_final.to_csv('analysis_data/asn_cis_radgyr_final.csv')
# Define column names
columns = ['cis_0', 'cis_1', 'cis_2', 'cis_3', 'cis_4', 'cis_5', 'cis_6']

# Create an empty DataFrame with 2 rows and 5 columns
p_cis_radgyr = pd.DataFrame(np.nan, index=range(nsim), columns=columns)

i = 0
for sim in p_ctd_sim_list:
    
    cis_0_true = ((sim['num Pro in cis'] == 0)*sim['weights']).sum()
    cis_1_true = ((sim['num Pro in cis'] == 1)*sim['weights']).sum()
    cis_2_true = ((sim['num Pro in cis'] == 2)*sim['weights']).sum()
    cis_3_true = ((sim['num Pro in cis'] == 3)*sim['weights']).sum()
    cis_4_true = ((sim['num Pro in cis'] == 4)*sim['weights']).sum()
    cis_5_true = ((sim['num Pro in cis'] == 5)*sim['weights']).sum()
    cis_6_true = ((sim['num Pro in cis'] == 6)*sim['weights']).sum()

    mean = sim['1-23'].mul((sim['num Pro in cis'] == 0)*sim['weights'], 0).sum()/cis_0_true
    p_cis_radgyr.at[i, 'cis_0'] = mean
    mean = sim['1-23'].mul((sim['num Pro in cis'] == 1)*sim['weights'], 0).sum()/cis_1_true
    p_cis_radgyr.at[i, 'cis_1'] = mean
    mean = sim['1-23'].mul((sim['num Pro in cis'] == 2)*sim['weights'], 0).sum()/cis_2_true
    p_cis_radgyr.at[i, 'cis_2'] = mean
    mean = sim['1-23'].mul((sim['num Pro in cis'] == 3)*sim['weights'], 0).sum()/cis_3_true
    p_cis_radgyr.at[i, 'cis_3'] = mean
    mean = sim['1-23'].mul((sim['num Pro in cis'] == 4)*sim['weights'], 0).sum()/cis_4_true
    p_cis_radgyr.at[i, 'cis_4'] = mean
    mean = sim['1-23'].mul((sim['num Pro in cis'] == 5)*sim['weights'], 0).sum()/cis_5_true
    p_cis_radgyr.at[i, 'cis_5'] = mean
    mean = sim['1-23'].mul((sim['num Pro in cis'] == 6)*sim['weights'], 0).sum()/cis_6_true
    p_cis_radgyr.at[i, 'cis_6'] = mean
    
    i += 1

# Calculate the SEM (standard error of the mean)
mean_values = p_cis_radgyr.mean()
sem_values = p_cis_radgyr.sem()

# Append as a new row labeled 'sem'
df_with_mean = pd.concat([p_cis_radgyr, pd.DataFrame([mean_values], index=['mean'])])
p_cis_radgyr_final = pd.concat([df_with_mean, pd.DataFrame([sem_values], index=['sem'])])

p_cis_radgyr_final.to_csv('analysis_data/asn_p_cis_radgyr_final.csv')
