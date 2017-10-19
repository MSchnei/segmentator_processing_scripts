#!/bin/bash

#### Description: Run *.m files for spm segmentation
#### To be set:
####    -path to parent directory,
####    -subject names
#### Input:
####    -spm_div *.m files for all subjects
#### Output:
####    -spm segmentation results for all subjects
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

# run *.m files for spm segmentation
subjLen=${#app[@]}
for (( i=0; i<${subjLen}; i++ )); do
	subj=${app[i]}
	pathTextFile="${parentpath}/${subj}/derived/03_division/spm/spm_div.m"
	# run SPM batch script
	command="MATLAB -nodisplay -nodesktop -nosplash -r run('${pathTextFile}'); exit;"
	echo "${command}"
	${command}
done
