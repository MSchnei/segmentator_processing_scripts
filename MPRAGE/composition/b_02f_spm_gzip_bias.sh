#!/bin/bash

#### Description: Zip hard spm segmentation labels
#### To be set:
####    -path to parent directory,
####    -subject names
#### Input:
####    -unzipped hard spm segmentation labels for all subjects
#### Output:
####    -zipped hard spm segmentation labels for all subjects
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

# list all contrast names
declare -a contrast=(
				"T1w"
        "PD"
        "T2s"
                )

# zip hard spm segmentation labels for all subjects and contrasts
subjLen=${#app[@]}
contrLen=${#contrast[@]}

# loop through subjects
for (( i=0; i<${subjLen}; i++ )); do
  subj=${app[i]}
	# loop through contrasts
	for (( j=0; j<${contrLen}; j++ )); do
		contr=${contrast[j]}
		# get relevant filename
		output="${parentpath}/${subj}/derived/04_composition/spm_T1_PD_T2s/m${subj}_${contr}_eq.nii"
		# gzip
		command="gzip ${output}"
		echo "${command}"
		${command}
	done
done
