#!/bin/bash

#### Description: Copies cbs GM segmentations to analysis folder
#### To be set:
####    -path to (reoriented) cbs GM segmentations images,
####		-path to target MP2RAGE analysis folder
####    -cbs extensions for reoriented uni images
####    -subject names
#### Input:
####    -cbs GM segmentations for all subjects
#### Output:
####    -copy of cbs GM segmentations for all subjects
#### Written by: Marian Schneider, Faruk Gulban


# deduce path to cbs data
cbs_path="${segm_path}/data/shared_data/data_mp2rage/derivatives"
# deduce path to mp2rage analysis folder
mp2rage_analysis_folder="${segm_path}/analysis/MP2RAGE"

# set cbs extensions
declare -a cbs=(
	"_t1_defaced2_thresh_clone_transform_strip_mems_rcr_gm_cortex"
	"_t1_defaced2_thresh_clone_transform_strip_mems_lcr_gm_cortex"
								)

# list all subject names
declare -a app=(
				"001"
        "013"
        "014"
        "019"
                )

# copy cbs GM segmentations for all subjects
cbsLen=${#cbs[@]}
subjLen=${#app[@]}
for (( i=0; i<${subjLen}; i++ )); do
	# derive particular subject name
  subj=${app[i]}
	for (( j=0; j<${cbsLen}; j++ )); do
		# derive extension for the cbs hemisphere
		ext=${cbs[j]}
		cbsuni="${cbs_path}/sub-${subj}/cbs/sub-${subj}${ext}.nii.gz"
		destination="${mp2rage_analysis_folder}/S${subj}/derived/03_uni/cbs/S${subj}${ext}.nii.gz"
		command="cp ${cbsuni} ${destination}"
		echo "${command}"
		${command}
	done
done
