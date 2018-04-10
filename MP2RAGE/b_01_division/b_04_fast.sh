#!/bin/bash

#### Description: Run fast segmentation
#### To be set:
####    -path to parent directory,
####    -subject names
#### Input:
####    -Uni_bet_nosub.nii.gz for all subjects
#### Output:
####    -fast segmentation results for all subjects
#### Written by: Marian Schneider, Faruk Gulban

# set parent path
parent_path="${segm_path}/analysis/MP2RAGE"

# list all subject names
declare -a app=(
				"S001"
        "S013"
        "S014"
        "S019"
                )

# run fast segmentation for all subjects
subjLen=${#app[@]}
for (( i=0; i<${subjLen}; i++ )); do
  subj=${app[i]}
  command="/usr/share/fsl/5.0/bin/fast "
  command+="-t 1 -n 3 -H 0.1 -I 4 -l 20.0 --nopve -B -b "
  command+="-o ${parent_path}/${subj}/derived/03_uni/fast/${subj}_uni "
	command+="${parent_path}/${subj}/derived/03_uni/${subj}_uni_bet_nosub "
  echo "${command}"
  ${command}
done
