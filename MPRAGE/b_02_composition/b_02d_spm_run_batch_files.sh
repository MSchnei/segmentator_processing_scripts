#!/bin/bash

#### Description: Run *.m files for spm segmentation
#### To be set:
####    -path to parent directory,
####    -subject names
#### Input:
####    -spm_div *.m files for all subjects
#### Output:
####    -spm segmentation results for all subjects
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

# create division images for all subjects
subjLen=${#app[@]}
for (( i=0; i<${subjLen}; i++ )); do
	subj=${app[i]}
	pathTextFile="${parent_path}/${subj}/derived/04_composition/spm_T1_PD_T2s/spm_comp.m"
	# run SPM batch script
	command="MATLAB -nodisplay -nodesktop -nosplash -r run('${pathTextFile}'); exit;"
	echo "${command}"
	${command}
done
