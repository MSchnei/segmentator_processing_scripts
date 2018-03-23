#!/bin/bash

#### Description: Mask fast gm with segmentator simplex brain mask
#### To be set:
####    -path to parent directory,
####    -subject names
#### Input:
####    -fast grey matter label
####    -segmentator brain mask for fast GM
#### Output:
####    -segmentator-masked fast grey matter label
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

# create division images for all subjects
subjLen=${#app[@]}
for (( i=0; i<${subjLen}; i++ )); do
  subj=${app[i]}
  # mask spm gm with segmentator gradient magnitude ncut brain mask
	input="${parent_path}/${subj}/derived/05_gm/${subj}_division_fast_gm"
	mask="${parent_path}/${subj}/derived/04_composition/fast_T1_PD_T2s/ilr_coord_1_labels_0"
	output="${parent_path}/${subj}/derived/05_gm/${subj}_division_fast_gm_simplex"
	command="fslmaths ${input} -mas ${mask} ${output}"
	echo "${command}"
	${command}
done
