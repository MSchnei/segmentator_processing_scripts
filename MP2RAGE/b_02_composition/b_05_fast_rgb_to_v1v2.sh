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

# directory:
parentpath="/home/marian/gdrive/temp_segmentator_paper_data/MP2RAGE"
codedirectory="/home/marian/gdrive/temp_segmentator_paper_data/code"
# Go to input directory
cd ${codedirectory}

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
  command+="${parentpath}/${subj}/derived/04_composition/${subj}_trio_restore_3.nii.gz "  # uni
  command+="${parentpath}/${subj}/derived/04_composition/${subj}_trio_restore_2.nii.gz "  # inv2
  command+="${parentpath}/${subj}/derived/04_composition/${subj}_trio_restore_1.nii.gz "  # t2s
  command+="${parentpath}/${subj}/derived/02_masks/brain_mask_nosub.nii.gz"
  echo ${command}
  ${command}
done
