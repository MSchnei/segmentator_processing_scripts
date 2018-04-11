#!/bin/bash

#### Description: Correct header for cbs-reoriented uni image
#### To be set:
####    -path to parent directory,
####    -subject names
#### Input:
####    -uni_bet_nosub.nii.gz with false hdrs for all subjects
####    -brain+subcortical mask for all subjects
#### Output:
####    -uni_bet_nosub.nii.gz with correct hdrs for all subjects
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

# correct uni image hader for all subjects
subjLen=${#app[@]}
for (( i=0; i<${subjLen}; i++ )); do
	# derive particular subject name
  subj=${app[i]}
	# call to fslmaths
  command="fslmaths "
	# specify file with assumed correct header
  command+="${parent_path}/${subj}/derived/02_masks/brain_mask_nosub "
	command+="-mul 0 -add 1 -mul "
	# specify file for which header will be changed
  command+="${parent_path}/${subj}/derived/04_composition/${subj}_uni "
	# specify output path
  command+="${parent_path}/${subj}/derived/04_composition/${subj}_uni"
  echo "${command}"
  ${command}
done
