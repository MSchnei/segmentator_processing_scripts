#!/bin/bash

#### Description: Join hemispheres, extract CBS grey matter, mask grey matter
#### To be set:
####    -path to parent directory,
####    -subject names
#### Input:
####    -right GM from CBS
####    -left GM from CBS
####    -brain_nosub mask
#### Output:
####    -GM from CBS
####    -masked GM from CBS
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

# join hemisphere segmentations for all subjects
subjLen=${#app[@]}
for (( i=0; i<${subjLen}; i++ )); do
	# derive particular subject name
  subj=${app[i]}
	# join hemispheres
  command="fslmaths "
  command+="${parent_path}/${subj}/derived/03_uni/cbs/${subj}_t1_thresh_clone_transform_strip_mems_rcr_gm_cortex "
  command+="-add "
  command+="${parent_path}/${subj}/derived/03_uni/cbs/${subj}_t1_thresh_clone_transform_strip_mems_lcr_gm_cortex "
  command+="-thr 1 -uthr 1 "
  command+="${parent_path}/${subj}/derived/03_uni/cbs/${subj}_t1_thresh_clone_transform_strip_mems_gm_cortex"
  echo "${command}"
  ${command}
	# mask with brain and no submask
	command="fslmaths "
	command+="${parent_path}/${subj}/derived/03_uni/cbs/${subj}_t1_thresh_clone_transform_strip_mems_gm_cortex "
	command+="-mas "
	command+="${parent_path}/${subj}/derived/02_masks/brain_mask_nosub "
	command+="${parent_path}/${subj}/derived/03_uni/cbs/${subj}_t1_thresh_clone_transform_strip_mems_gm_cortex_mas"
	echo "${command}"
	${command}
done
