#!/bin/bash

#### Description: Ilr transform for fast biased corrected T1, PD, T2s images
#### To be set:
####    -path to parent directory,
####    -path to directory with ilr transformation script
####    -subject names
#### Input:
####    -T1w_trio_restore for all subjects
####    -PD_trio_restore for all subjects
####    -T2s_trio_restore for all subjects
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
  print="----- Subj ${subj} fast -----"
  echo ${print}
  command="python rgb_to_v1v2_cmdlne.py "
  command+="${parent_path}/${subj}/derived/04_composition/fast_T1_PD_T2s/${subj}_trio_restore_1.nii.gz "
  command+="${parent_path}/${subj}/derived/04_composition/fast_T1_PD_T2s/${subj}_trio_restore_2.nii.gz "
  command+="${parent_path}/${subj}/derived/04_composition/fast_T1_PD_T2s/${subj}_trio_restore_3.nii.gz "
  command+="${parent_path}/${subj}/derived/02_masks/brain_mask_nosub.nii.gz"
  echo ${command}
  ${command}
done
