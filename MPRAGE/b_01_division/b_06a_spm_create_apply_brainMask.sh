#!/bin/bash

#### Description: Create SPM brain mask, mask spm bias corrected T1divPD image
#### To be set:
####    -path to parent directory,
####    -subject names
#### Input:
####    -spm biased T1divPD image
####    -spm hard segmentation labels for GM, WM, CSF
#### Output:
####    -spm biased corrected T1divPD image
#### Written by: Marian Schneider - marian.schneider@maastrichtuniversity.nl

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

# create SPM brain mask, mask spm bias corrected T1divPD image for all subjects
subjLen=${#app[@]}
for (( i=0; i<${subjLen}; i++ )); do
  subj=${app[i]}
  # generate SPM brain mask from WM, GM, CSF
	command="fslmaths ${parentpath}/${subj}/derived/03_division/spm/c1${subj}_T1wDivPD_max "
	command+="-add ${parentpath}/${subj}/derived/03_division/spm/c2${subj}_T1wDivPD_max "
	command+="-add ${parentpath}/${subj}/derived/03_division/spm/c3${subj}_T1wDivPD_max "
	brainmask="${parentpath}/${subj}/derived/03_division/spm/${subj}_spm_brain_mask"
	command+="${brainmask} "
	echo "${command}"
	${command}
	# apply brain mask to restored SPM image
	input="${parentpath}/${subj}/derived/03_division/spm/m${subj}_T1wDivPD"
	output="${parentpath}/${subj}/derived/03_division/spm/m${subj}_T1wDivPD_msk"
	command="fslmaths ${input} -mas ${brainmask} ${output}"
	echo "${command}"
	${command}

done
