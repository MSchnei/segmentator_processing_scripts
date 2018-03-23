#!/bin/bash

#### Description: Masks T1wDivPD with brain mask from bet
#### To be set:
####    -path to parent directory,
####    -subject names
#### Input:
####    -T1wDivPD.nii.gz for all subjects
####    -brain masks for all subjects
#### Output:
####    -T1wDivPD_bet.nii.gz for all subjects
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

# mask all images with brain mask
subjLen=${#app[@]}
for (( i=0; i<${subjLen}; i++ )); do
	# derive particular subject name
  subj=${app[i]}
	# call to fslmaths
  command="fslmaths "
	# specify path to T1wDivPD image
  command+="${parent_path}/${subj}/derived/03_division/${subj}_T1wDivPD "
	# mask
  command+="-mas "
	# specify path to brain mask image
  command+="${parent_path}/${subj}/derived/02_masks/brain_mask "
	# specify output name
  command+="${parent_path}/${subj}/derived/03_division/${subj}_T1wDivPD_bet"
  echo "${command}"
  ${command}
done
