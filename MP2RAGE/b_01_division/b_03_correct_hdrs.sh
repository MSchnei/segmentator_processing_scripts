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
#### Written by: Marian Schneider - marian.schneider@maastrichtuniversity.nl

# set parent path
parentpath="/home/marian/gdrive/temp_segmentator_paper_data/MP2RAGE"

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
	# specify file with assumed correct header
  command+="${parentpath}/${subj}/derived/02_masks/brain_mask_nosub "
	command+="-mul 0 -add 1 -mul "
	# specify file for which header will be changed
  command+="${parentpath}/${subj}/derived/03_uni/${subj}_uni_bet_nosub "
	# specify output path
  command+="${parentpath}/${subj}/derived/03_uni/${subj}_uni_bet_nosub"
  echo "${command}"
  ${command}
done
