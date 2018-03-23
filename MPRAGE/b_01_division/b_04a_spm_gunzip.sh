#!/bin/bash

#### Description: Unzip T1wDivPD image so SPM can handle it
#### To be set:
####    -path to parent directory,
####    -subject names
#### Input:
####    -T1wDivPD.nii.gz for all subjects
#### Output:
####    -T1wDivPD.nii for all subjects
#### Written by: Marian Schneider, Faruk Gulban

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

# unzip T1wDivPD image for all subjects
subjLen=${#app[@]}
for (( i=0; i<${subjLen}; i++ )); do
	# derive particular subject name
  subj=${app[i]}
	# set input and output names for copying operation
  input="${parentpath}/${subj}/derived/03_division/${subj}_T1wDivPD.nii.gz"
	output="${parentpath}/${subj}/derived/03_division/spm/${subj}_T1wDivPD.nii.gz"
	# copy gz file into SPM directory
	command="cp ${input} ${output}"
	echo "${command}"
	${command}
	# gunzip
	command="gunzip ${output}"
	echo "${command}"
	${command}
done
