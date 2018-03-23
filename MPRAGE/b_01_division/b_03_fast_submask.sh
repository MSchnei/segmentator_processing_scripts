#!/bin/bash

#### Description: Masks T1wDivPD with brain+subcortical mask
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
parentpath="/home/marian/gdrive/temp_segmentator_paper_data/MPRAGE"

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
  command+="${parentpath}/${subj}/derived/03_division/${subj}_T1wDivPD "
	# mask
  command+="-mas "
	# specify path to brain+subcortical mask image
  command+="${parentpath}/${subj}/derived/02_masks/brain_mask_nosub "
	# specify output name
  command+="${parentpath}/${subj}/derived/03_division/${subj}_T1wDivPD_bet_nosub"
  echo "${command}"
  ${command}
done
