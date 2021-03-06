uni#!/bin/bash

#### Description: Copy cbs grey matter files
#### To be set:
####    -path to parent directory,
####    -subject names
#### Input:
####    -cbs grey matter results for all subjects
#### Output:
####    -cbs grey matter results for all subjects
#### Written by: Marian Schneider, Faruk Gulban

# set parent path
parent_path="${segm_path}/analysis/MP2RAGE"

# list all subject names
declare -a app=(
				"S001"
        "S013"
        "S014"
        "S019"
                )

# extract and copy fast grey matter files for all subjects
subjLen=${#app[@]}
for (( i=0; i<${subjLen}; i++ )); do
  subj=${app[i]}
	# copy gm file into GM directory
	source="${parent_path}/${subj}/derived/03_uni/cbs/${subj}_t1_defaced2_thresh_clone_transform_strip_mems_gm_cortex_mas"
	destination="${parent_path}/${subj}/derived/05_gm/${subj}_uni_cbs_gm"
	command="cp ${source}.nii.gz ${destination}.nii.gz"
	echo "${command}"
	${command}
done
