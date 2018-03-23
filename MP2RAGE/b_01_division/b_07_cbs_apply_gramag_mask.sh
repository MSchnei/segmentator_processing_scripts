#!/bin/bash

#### Description: Mask cbs gm with segmentator gradient magnitude brain mask
#### To be set:
####    -path to parent directory,
####    -subject names
#### Input:
####    -cbs grey matter label
####    -segmentator brain mask for fast GM
#### Output:
####    -segmentator-masked cbs grey matter label
#### Written by: Marian Schneider, Faruk Gulban

# set parent path
parentpath="/home/marian/gdrive/temp_segmentator_paper_data/MP2RAGE"

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
	input="${parentpath}/${subj}/derived/05_gm/${subj}_uni_cbs_gm"
	mask="${parentpath}/${subj}/derived/03_uni/fast/${subj}_uni_restore_labels_0"
	output="${parentpath}/${subj}/derived/05_gm/${subj}_uni_cbs_gm_gramag"
	# use fslmaths to perform the masking
	command="fslmaths ${input} -mas ${mask} ${output}"
	echo "${command}"
	${command}
done
