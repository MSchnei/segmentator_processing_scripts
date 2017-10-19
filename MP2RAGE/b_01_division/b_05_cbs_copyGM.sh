uni#!/bin/bash

#### Description: Copy cbs grey matter files
#### To be set:
####    -path to parent directory,
####    -subject names
#### Input:
####    -cbs grey matter results for all subjects
#### Output:
####    -cbs grey matter results for all subjects
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

# extract and copy fast grey matter files for all subjects
subjLen=${#app[@]}
for (( i=0; i<${subjLen}; i++ )); do
  subj=${app[i]}
	# copy gm file into GM directory
	source="${parentpath}/${subj}/derived/03_uni/cbs/${subj}_t1_thresh_clone_transform_strip_mems_gm_cortex_mas"
	destination="${parentpath}/${subj}/derived/05_gm/${subj}_uni_cbs_gm"
	command="cp ${source}.nii.gz ${destination}.nii.gz"
	echo "${command}"
	${command}
done
