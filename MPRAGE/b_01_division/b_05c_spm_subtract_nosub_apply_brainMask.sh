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

	# NOTE: We have applied a morphological operation (2 step opening) to the
	# brain mask and called it with _open suffix
	brainmask="${parent_path}/${subj}/derived/03_division/spm/spm_brain_mask_open"

  # create nosub mask
	submask="${parent_path}/${subj}/derived/02_masks/nosub.nii.gz"
	command="fslmaths ${parent_path}/${subj}/derived/02_masks/brain_mask_nosub.nii.gz -binv ${submask}"
	echo "${command}"
	${command}

	# combine brain and no submask
	brainsubmask="${parent_path}/${subj}/derived/03_division/spm/spm_brain_mask_open_nosub"
	command="fslmaths ${submask} -binv -mul ${brainmask} ${brainsubmask}"
	echo "${command}"
	${command}

	# copy spm_brain_mask and spm_brain_mask_nosub to masks folder
	destination="${parent_path}/${subj}/derived/02_masks/spm_brain_mask"
	command="cp ${brainmask}.nii.gz ${destination}.nii.gz"
	echo "${command}"
	${command}
	destination="${parent_path}/${subj}/derived/02_masks/spm_brain_mask_open_nosub"
	command="cp ${brainsubmask}.nii.gz ${destination}.nii.gz"
	echo "${command}"
	${command}

	# apply brain nosub mask to restored SPM image
	input="${parent_path}/${subj}/derived/03_division/spm/m${subj}_T1wDivPD"
	output="${parent_path}/${subj}/derived/03_division/spm/m${subj}_T1wDivPD_msk"
	command="fslmaths ${input} -mas ${destination} ${output}"
	echo "${command}"
	${command}

done
