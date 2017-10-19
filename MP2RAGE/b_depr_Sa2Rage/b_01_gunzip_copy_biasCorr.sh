#!/bin/bash

#### Description: Unzip T1wDivPD image so SPM can handle it
#### To be set:
####    -path to parent directory,
####    -subject names
#### Input:
####    -T1wDivPD.nii.gz for all subjects
#### Output:
####    -T1wDivPD.nii for all subjects
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

# unzip T1wDivPD image for all subjects
subjLen=${#app[@]}
for (( i=0; i<${subjLen}; i++ )); do
	# derive particular subject name
  subj=${app[i]}
	# copy uni image
  input="${parentpath}/${subj}/source/${subj}_uni.nii.gz"
	output="${parentpath}/${subj}/source/corr/${subj}_uni.nii.gz"
	command="cp ${input} ${output}"
	echo "${command}"
	${command}
	# gunzip
	command="gunzip ${output}"
	echo "${command}"
	${command}
	# copy b1 image
  input="${parentpath}/${subj}/source/${subj}_b1.nii.gz"
	output="${parentpath}/${subj}/source/corr/${subj}_b1.nii.gz"
	command="cp ${input} ${output}"
	echo "${command}"
	${command}
	# gunzip
	command="gunzip ${output}"
	echo "${command}"
	${command}
done
