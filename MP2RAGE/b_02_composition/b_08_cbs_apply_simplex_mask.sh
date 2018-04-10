#!/bin/bash

#### Description: Mask cbs gm with segmentator simplex brain mask
#### To be set:
####    -path to parent directory,
####    -subject names
#### Input:
####    -cbs grey matter label
####    -segmentator simplex brain mask
#### Output:
####    -simplex-masked cbs grey matter label
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

# mask fast gm with segmentator gradient magnitude brain mask
subjLen=${#app[@]}
for (( i=0; i<${subjLen}; i++ )); do
  subj=${app[i]}
  # set path to fst GM, segmentator brain mask, output file name
	input="${parent_path}/${subj}/derived/05_gm/${subj}_uni_cbs_gm"
	mask="${parent_path}/${subj}/derived/04_composition/ilr_coord_1_labels_0"
	output="${parent_path}/${subj}/derived/05_gm/${subj}_uni_cbs_gm_simplex"
	# use fslmaths to perform the masking
	command="fslmaths ${input} -mas ${mask} ${output}"
	echo "${command}"
	${command}
done
