#!/bin/bash

#### Description: Joins segmentations from two hemispheres
#### To be set:
####    -path to parent directory,
####    -corr extensions for reoriented uni images
####    -subject names
#### Input:
####    -uni.nii.gz for all subjects
#### Output:
####    -copy of uni.nii.gz for all subjects
#### Written by: Marian Schneider - marian.schneider@maastrichtuniversity.nl

# set parent path
parentpath="/home/marian/gdrive/temp_segmentator_paper_data/MP2RAGE/temp_CBS_segmentations"

# set corr extensions
declare -a corr=(
	"inv2"
	"no_corr"
          )

# list all subject names
declare -a app=(
				"S001"
        "S013"
        "S014"
        "S019"
                )

# join hemisphere segmentations for all subjects
corrLen=${#corr[@]}
subjLen=${#app[@]}
for (( i=0; i<${subjLen}; i++ )); do
	# derive particular subject name
  subj=${app[i]}
  for (( j=0; j<${corrLen}; j++ )); do
  	ext=${corr[j]}

    command="fslmaths "
    command+="${parentpath}/${subj}/${ext}/t1_thresh_clone_transform_strip_mems_rcr_gm_cortex "
    command+="-add "
    command+="${parentpath}/${subj}/${ext}/t1_thresh_clone_transform_strip_mems_lcr_gm_cortex "
    command+="-thr 1 -uthr 1 "
    command+="${parentpath}/${subj}/${ext}/t1_thresh_clone_transform_strip_mems_gm_cortex"
    echo "${command}"
    ${command}
  done
done
