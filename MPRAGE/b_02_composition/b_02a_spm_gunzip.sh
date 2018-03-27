#!/bin/bash

#### Description: Unzip T1, Pd, T2s images so SPM can handle it
#### To be set:
####    -path to parent directory,
####    -subject names
#### Input:
####    -T1w.nii.gz for all subjects
####    -PD.nii.gz for all subjects
####    -T2s.nii.gz for all subjects
#### Output:
####    -T1w.nii for all subjects
####    -PD.nii for all subjects
####    -T2s.nii for all subjects
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

# list all contrast names
declare -a contrast=(
				"T1w"
        "PD"
        "T2s"
                )

# unzip T1, Pd, T2s images for all subjects
subjLen=${#app[@]}
contrLen=${#contrast[@]}
# loop through subjects
for (( i=0; i<${subjLen}; i++ )); do
	  subj=${app[i]}
		# loop through contrasts
		for (( j=0; j<${contrLen}; j++ )); do
			contr=${contrast[j]}
		  input="${parent_path}/${subj}/source/${subj}_${contr}.nii.gz "
			output="${parent_path}/${subj}/derived/04_composition/spm_T1_PD_T2s/${subj}_${contr}.nii.gz"
			# copy gz file into SPM directory
			command="cp ${input} ${output}"
			echo "${command}"
			${command}
			# gunzip
			command="gunzip ${output}"
			echo "${command}"
			${command}
	done
done
