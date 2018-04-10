#!/bin/bash

#### Description: Ilr transform for fast biased corrected Uni, Inv2, T2s images
#### To be set:
####    -path to parent directory,
####    -path to directory with ilr transformation script
####    -subject names
#### Input:
####    -Uni_trio_restore for all subjects
####    -Inv2_trio_restore for all subjects
####    -T2s_trio_restore for all subjects
#### Output:
####    -ilr1 image
####    -ilr2 image
#### Written by: Marian Schneider, Faruk Gulban

# set parent path
parent_path="${segm_path}/analysis/MP2RAGE"
# set path to code directory
code_directory="${segm_path}/code"
# Go to input directory
cd ${code_directory}

# list all subject names
declare -a app=(
				"S001"
        "S013"
        "S014"
        "S019"
                )

subjLen=${#app[@]}
for (( i=0; i<${subjLen}; i++ )); do
  subj=${app[i]}
  print="----- Subj ${subj} fast -----"
  echo ${print}
  command="python rgb_to_v1v2_cmdlne.py "
  command+="${parent_path}/${subj}/derived/04_composition/${subj}_trio_restore_3.nii.gz "  # uni
  command+="${parent_path}/${subj}/derived/04_composition/${subj}_trio_restore_2.nii.gz "  # inv2
  command+="${parent_path}/${subj}/derived/04_composition/${subj}_trio_restore_1.nii.gz "  # t2s
  command+="${parent_path}/${subj}/derived/02_masks/brain_mask_nosub.nii.gz"
  echo ${command}
  ${command}
done
