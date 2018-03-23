#!/bin/bash

#### Description: Run fast segmentation
#### To be set:
####    -path to parent directory,
####    -subject names
#### Input:
####    -T1w_bet_nosub.nii.gz for all subjects
####    -PD_bet_nosub.nii.gz for all subjects
####    -T2s_bet_nosub.nii.gz for all subjects
#### Output:
####    -fast segmentation results for all subjects
#### Written by: Marian Schneider, Faruk Gulban

# set parent path
parent_path="${segm_path}/analysis/MPRAGE"

# list all subject names
declare -a app=(
				"S02"
        "S03"
        "S05"
        "S06"
        "S07"
                )

# create division images for all subjects
subjLen=${#app[@]}
for (( i=0; i<${subjLen}; i++ )); do
  subj=${app[i]}
  command="fast "
  command+="-S 3 -n 3 -H 0.1 -I 4 -l 20.0 --nopve -B -b "
  command+="-o ${parent_path}/${subj}/derived/04_composition/fast_T1_PD_T2s/${subj}_trio "
	command+="${parent_path}/${subj}/derived/04_composition/${subj}_T1w_bet_nosub "
	command+="${parent_path}/${subj}/derived/04_composition/${subj}_PD_bet_nosub "
	command+="${parent_path}/${subj}/derived/04_composition/${subj}_T2s_bet_nosub "
  echo "${command}"
  ${command}
done
