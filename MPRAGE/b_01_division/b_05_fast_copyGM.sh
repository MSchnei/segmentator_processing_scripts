#!/bin/bash

#### Description: Extract and copy fast grey matter files
#### To be set:
####    -path to parent directory,
####    -subject names
#### Input:
####    -fast segmentation results for all subjects
#### Output:
####    -copy of fast grey matter results for all subjects
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

# extract and copy fast grey matter files for all subjects
subjLen=${#app[@]}
for (( i=0; i<${subjLen}; i++ )); do
  subj=${app[i]}
	# get only the grey matter
  input="${parent_path}/${subj}/derived/03_division/fast/${subj}_division_seg"
	output="${parent_path}/${subj}/derived/03_division/fast/${subj}_division_GM"
	command="fslmaths ${input} -thr 2 -uthr 2 -div 2 ${output}"
	echo "${command}"
	${command}
	# copy gm file into GM directory
	destination="${parent_path}/${subj}/derived/05_gm/${subj}_division_fast_gm"
	command="cp ${output}.nii.gz ${destination}.nii.gz"
	echo "${command}"
	${command}
	# delete original filename
	command="rm -rf ${output}.nii.gz"
	echo "${command}"
	${command}
done
