#!/bin/bash

#### Description: Copy spm grey matter files, mask with nosub mask
#### To be set:
####    -path to parent directory,
####    -subject names
#### Input:
####    -spm grey matter results for all subjects
#### Output:
####    -nosub masked spm grey matter results for all subjects
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

# copy spm grey matter files, mask with nosub mask for all subjects
subjLen=${#app[@]}
for (( i=0; i<${subjLen}; i++ )); do
  subj=${app[i]}
	# copy gm file into GM directory
	source="${parentpath}/${subj}/derived/03_division/spm/c1${subj}_T1wDivPD_max"
	destination="${parentpath}/${subj}/derived/05_gm/${subj}_division_spm_gm"
	command="cp ${source}.nii.gz ${destination}_unmsk.nii.gz"
	echo "${command}"
	${command}

	# mask with the nosub mask
	mask="${parentpath}/${subj}/derived/02_masks/spm_brain_mask_open_nosub"
	command="fslmaths ${destination}_unmsk -mas ${mask}  ${destination}"
	echo "${command}"
	${command}

	# delete original filename
	command="rm -rf ${destination}_unmsk.nii.gz"
	echo "${command}"
	${command}
done
