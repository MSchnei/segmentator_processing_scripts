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

# create SPM brain mask, mask spm bias corrected T1divPD image for all subjects
subjLen=${#app[@]}
for (( i=0; i<${subjLen}; i++ )); do
  subj=${app[i]}
	echo "##########################"
	echo ${subj}
	echo "##########################"
  # generate SPM brain mask from WM, GM, CSF
	command="fslmaths ${parent_path}/${subj}/derived/03_division/spm/c1${subj}_T1wDivPD_max "
	command+="-add ${parent_path}/${subj}/derived/03_division/spm/c2${subj}_T1wDivPD_max "
	command+="-add ${parent_path}/${subj}/derived/03_division/spm/c3${subj}_T1wDivPD_max "
	brainmask="${parent_path}/${subj}/derived/03_division/spm/spm_brain_mask"

	command+="${brainmask} "
	echo "${command}"
	${command}

done
