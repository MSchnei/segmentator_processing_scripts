#!/bin/bash

#### Description: Copies uni and inv2 images that was reoriented by cbs tools
#### To be set:
####    -path to parent directory,
####    -cbs extensions for reoriented uni images
####    -cbs extensions for reoriented inv2 images
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
declare -a uni=(
	"sub-001_uni_defaced_clone_transform"
	"sub-013_uni_defaced_clone_transform"
	"sub-014_uni_defaced_clone_transform"
	"sub-019_uni_defaced_clone_transform")

declare -a inv2=(
	"sub-001_inv2_defaced_clone_transform"
	"sub-013_inv2_defaced_clone_transform"
	"sub-014_inv2_defaced_clone_transform"
	"sub-019_inv2_defaced_clone_transform"
								)

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
	# copy uni imgaes
	extuni=${uni[i]}
	cbsuni="${cbs_path}/sub-${subj}/cbs/exp-0000/exp-0000-B/reorient/${extuni}.nii.gz"
	destination="${mp2rage_analysis_folder}/S${subj}/derived/04_composition/S${subj}_uni.nii.gz"
  command="cp ${cbsuni} ${destination}"
  echo "${command}"
  ${command}
	# copy inv2 images
	extinv2=${inv2[i]}
	cbsinv2="${cbs_path}/sub-${subj}/cbs/exp-0000/exp-0000-C/reorient/${extinv2}.nii.gz"
	destination="${mp2rage_analysis_folder}/S${subj}/derived/04_composition/S${subj}_inv2.nii.gz"
  command="cp ${cbsinv2} ${destination}"
  echo "${command}"
  ${command}
done
