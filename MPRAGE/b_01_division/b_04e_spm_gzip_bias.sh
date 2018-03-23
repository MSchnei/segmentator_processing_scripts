#!/bin/bash

#### Description: Zip hard spm segmentation labels
#### To be set:
####    -path to parent directory,
####    -subject names
#### Input:
####    -unzipped hard spm segmentation labels for all subjects
#### Output:
####    -zipped hard spm segmentation labels for all subjects
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

# zip hard spm segmentation labels for all subjects
subjLen=${#app[@]}
for (( i=0; i<${subjLen}; i++ )); do
  subj=${app[i]}
	output="${parent_path}/${subj}/derived/03_division/spm/m${subj}_T1wDivPD.nii"
	# gzip
	command="gzip ${output}"
	echo "${command}"
	${command}
done
