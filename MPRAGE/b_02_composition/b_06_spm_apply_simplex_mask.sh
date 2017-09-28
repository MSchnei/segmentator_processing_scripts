#!/bin/bash

#### Description: Mask spm gm with segmentator simplex brain mask
#### To be set:
####    -path to parent directory,
####    -subject names
#### Input:
####    -spm grey matter label
####    -segmentator brain mask for spm GM
#### Output:
####    -segmentator-masked spm grey matter label
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

# create division images for all subjects
subjLen=${#app[@]}
for (( i=0; i<${subjLen}; i++ )); do
  subj=${app[i]}
  # mask spm gm with segmentator gradient magnitude ncut brain mask
	input="${parentpath}/${subj}/derived/05_gm/${subj}_division_spm_gm"
	mask="${parentpath}/${subj}/derived/04_composition/spm_T1_PD_T2s/ilr_coord_1_labels_0"
	output="${parentpath}/${subj}/derived/05_gm/${subj}_division_spm_gm_simplex"
	command="fslmaths ${input} -mas ${mask} ${output}"
	echo "${command}"
	${command}
done
