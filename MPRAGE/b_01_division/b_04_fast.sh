#!/bin/bash

#### Description: Run fast segmentation
#### To be set:
####    -path to parent directory,
####    -subject names
#### Input:
####    -T1divPD.nii.gz for all subjects
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

# run fast segmentation for all subjects
subjLen=${#app[@]}
for (( i=0; i<${subjLen}; i++ )); do
  subj=${app[i]}
  command="/usr/share/fsl/5.0/bin/fast "
  command+="-t 1 -n 3 -H 0.1 -I 4 -l 20.0 --nopve -B -b "
  command+="-o ${parent_path}/${subj}/derived/03_division/fast/${subj}_division "
	command+="${parent_path}/${subj}/derived/03_division/${subj}_T1wDivPD_bet_nosub "
  echo "${command}"
  ${command}
done
