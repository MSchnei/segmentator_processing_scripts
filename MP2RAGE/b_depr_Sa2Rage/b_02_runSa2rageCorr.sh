#!/bin/bash

#### Description: Run *.m files for MP2RAGE bias correction with Sa2RAGE
#### To be set:
####    -path to parent directory,
####    -subject names
#### Input:
####    -path to MacroForCorrectionfunc.m file
####    -path to b1.nii file
####    -path to uni.nii file
####    -path to subdirectory where corrected files are to be saved
#### Output:
####    -t1_corr.nii
####    -mp2rage_corr.nii (aka corrected uni image)
####    -b1_corr.mat
#### Written by: Marian Schneider - marian.schneider@maastrichtuniversity.nl

# set parent path
parentpath="/home/marian/gdrive/temp_segmentator_paper_data/"

# list all subject names
declare -a app=(
		"S001"
        "S013"
        "S014"
        "S019"
                )

# change to code directory
codepath="${parentpath}code/MP2RAGE/correct_MP2RAGE/"
echo "cd ${codepath}"
cd ${codepath}

# run *.m files for spm segmentation
subjLen=${#app[@]}
for (( i=0; i<${subjLen}; i++ )); do
	subj=${app[i]}
	# determine B1 input
	b1="${parentpath}MP2RAGE/${subj}/source/corr/${subj}_b1.nii"
	# determine uni input
	uni="${parentpath}MP2RAGE/${subj}/source/corr/${subj}_uni.nii"
	# determine subdir where corrected images will be saved to
	subdir="${parentpath}MP2RAGE/${subj}/source/corr/"
	# run MATLAB function
	command="MATLAB -nodisplay -nodesktop -nosplash -r MacroForCorrectionfunc('${b1}','${uni}','${subdir}');exit;"
	echo "${command}"
	${command}
done
