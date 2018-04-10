#!/bin/bash

#### Description: Copies uni image that was reoriented by cbs tools
#### To be set:
####    -path to reoriented cbs images,
####	-path to target MP2RAGE analysis folder
####    -cbs extensions for reoriented uni images
####    -subject names
#### Input:
####    -uni.nii.gz for all subjects
#### Output:
####    -copy of uni.nii.gz for all subjects
#### Written by: Marian Schneider, Faruk Gulban


# deduce path to cbs data
cbs_path="${segm_path}/data/shared_data/data_mp2rage/derivatives"
# deduce path to mp2rage analysis folder
mp2rage_analysis_folder="${segm_path}/analysis/MP2RAGE"

# set cbs extensions
declare -a cbs=(
	"sub-001_uni_defaced_clone_transform"
	"sub-013_uni_defaced_clone_transform"
	"sub-014_uni_defaced_clone_transform"
	"sub-019_uni_defaced_clone_transform")

# list all subject names
declare -a app=(
		"001"
        "013"
        "014"
        "019"
                )

# create division images for all subjects
subjLen=${#app[@]}
for (( i=0; i<${subjLen}; i++ )); do
	# derive particular subject name
  	subj=${app[i]}
	ext=${cbs[i]}
	cbsuni="${cbs_path}/sub-${subj}/cbs/exp-0000/exp-0000-B/reorient/${ext}.nii.gz"
	destination="${mp2rage_analysis_folder}/S${subj}/derived/03_uni/S${subj}_uni.nii.gz"
  	command="cp ${cbsuni} ${destination}"
  	echo "${command}"
  	${command}
done
