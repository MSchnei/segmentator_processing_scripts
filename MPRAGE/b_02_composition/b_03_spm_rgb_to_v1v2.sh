#!/bin/bash

#### Description: Ilr transform for spm biased corrected T1, PD, T2s images
#### To be set:
####    -path to parent directory,
####    -path to directory with ilr transformation script
####    -subject names
#### Input:
####    -mT1w_eq.nii.gz for all subjects
####    -mPD_eq.nii.gz for all subjects
####    -mT2s_eq.nii.gz for all subjects
#### Output:
####    -ilr1 image
####    -ilr2 image
#### Written by: Marian Schneider, Faruk Gulban

# directory:
parent_path="${segm_path}/analysis/MPRAGE"
codedirectory="${segm_path}/code"
# Go to input directory
cd ${codedirectory}

# list all subject names
declare -a app=(
				"S02"
        "S03"
        "S05"
        "S06"
        "S07"
                )

subjLen=${#app[@]}
for (( i=0; i<${subjLen}; i++ )); do
  subj=${app[i]}
  print="----- Subj ${subj} SPM -----"
  echo ${print}
  command="python rgb_to_v1v2_cmdlne.py "
  command+="${parent_path}/${subj}/derived/04_composition/spm_T1_PD_T2s/m${subj}_T1w_eq.nii.gz "
  command+="${parent_path}/${subj}/derived/04_composition/spm_T1_PD_T2s/m${subj}_PD_eq.nii.gz "
  command+="${parent_path}/${subj}/derived/04_composition/spm_T1_PD_T2s/m${subj}_T2s_eq.nii.gz "
  command+="${parent_path}/${subj}/derived/02_masks/spm_brain_mask_open_nosub.nii.gz"
  echo ${command}
  ${command}
done
