#!/bin/bash

#### Description: Mask fast gm with segmentator gradient magnitude brain mask
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
	input="${parent_path}/${subj}/derived/05_gm/${subj}_uni_fast_gm"
	mask="${parent_path}/${subj}/derived/03_uni/fast/${subj}_uni_restore_labels_0"
	output="${parent_path}/${subj}/derived/05_gm/${subj}_uni_fast_gm_gramag"
	# use fslmaths to perform the masking
	command="fslmaths ${input} -mas ${mask} ${output}"
	echo "${command}"
	${command}
done
