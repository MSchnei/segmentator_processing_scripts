#!/bin/bash

#### Description: Delete unncessary b1 and uni files
#### To be set:
####    -path to parent directory,
####    -subject names
#### Input:
####    -path to uni images in corr folder
####    -path to b1 images in corr folder
#### Output:
####    -none; files are deleted
#### Written by: Marian Schneider - marian.schneider@maastrichtuniversity.nl

# set parent path
parentpath="/home/marian/gdrive/temp_segmentator_paper_data/MP2RAGE"

# list all subject names
declare -a app=(
					"S001"
					"S013"
					"S014"
					"S019"
                )

# zip images for all subjects
subjLen=${#app[@]}
for (( i=0; i<${subjLen}; i++ )); do
  subj=${app[i]}
	# remove uni
	output="${parentpath}/${subj}/source/corr/${subj}_uni.nii.gz"
	command="rm -rf ${output}"
	echo "${command}"
	${command}
	# remove b1
	output="${parentpath}/${subj}/source/corr/${subj}_b1.nii.gz"
	command="rm -rf ${output}"
	echo "${command}"
	${command}
done
