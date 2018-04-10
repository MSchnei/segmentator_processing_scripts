#!/bin/bash

#### Description: Masks uni with brain+subcortical mask
#### To be set:
####    -path to parent directory,
####    -subject names
#### Input:
####    -T1wDivPD.nii.gz for all subjects
####    -brain+subcortical mask for all subjects
#### Output:
####    -T1wDivPD_bet_nosub.nii.gz for all subjects
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

# mask all images with brain mask
subjLen=${#app[@]}
for (( i=0; i<${subjLen}; i++ )); do
	# derive particular subject name
  subj=${app[i]}
	# call to fslmaths
  command="fslmaths "
	# specify path to T1wDivPD image
  command+="${parent_path}/${subj}/derived/03_uni/${subj}_uni "
	# mask
  command+="-mas "
	# specify path to brain+subcortical mask image
  command+="${parent_path}/${subj}/derived/02_masks/brain_mask_nosub "
	# specify output name
  command+="${parent_path}/${subj}/derived/03_uni/${subj}_uni_bet_nosub"
  echo "${command}"
  ${command}
done
