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

# mask fast gm with segmentator gradient magnitude brain mask
subjLen=${#app[@]}
for (( i=0; i<${subjLen}; i++ )); do
  subj=${app[i]}
  # set path to fst GM, segmentator brain mask, output file name
	input="${parentpath}/${subj}/derived/05_gm/${subj}_division_fast_gm"
	mask="${parentpath}/${subj}/derived/03_division/fast/${subj}_division_restore_labels_0"
	output="${parentpath}/${subj}/derived/05_gm/${subj}_division_fast_gm_gramag"
	# use fslmaths to perform the masking
	command="fslmaths ${input} -mas ${mask} ${output}"
	echo "${command}"
	${command}
done
