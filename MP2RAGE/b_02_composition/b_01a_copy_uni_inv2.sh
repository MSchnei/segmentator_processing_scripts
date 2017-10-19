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
#### Written by: Marian Schneider - marian.schneider@maastrichtuniversity.nl

# set parent path
parentpath="/home/marian/gdrive/temp_segmentator_paper_data/MP2RAGE"

# set cbs extensions
declare -a uni=(
	"RoyHaa_110416_S001C001_Ses2_20160411_001_020_mp2rage_iso0_7_iPAT3_mp2rage_iso0_7_iPAT3_UNI_Images_clone_transform"
	"RoyHaa_260315_S013C001_20150326_001_021_mp2rage_iso0_7_iPAT3_mp2rage_iso0_7_iPAT3_UNI_Images_clone_transform"
	"RoyHaa_080415_S014C001_20150408_001_021_mp2rage_iso0_7_iPAT3_mp2rage_iso0_7_iPAT3_UNI_Images_clone_transform"
	"RoyHaa_060515_S019C001_20150506_001_023_mp2rage_iso0_7_iPAT3_mp2rage_iso0_7_iPAT3_UNI_Images_clone_transform"
								)

declare -a inv2=(
	"unknown"
	"unknown"
	"unknown"
	"unknown"
								)

# list all subject names
declare -a app=(
				"S001"
        "S013"
        "S014"
        "S019"
                )

# create division images for all subjects
subjLen=${#app[@]}
for (( i=0; i<${subjLen}; i++ )); do
	# derive particular subject name
  subj=${app[i]}
	# copy uni imgaes
	extuni=${uni[i]}
	cbsuni="${parentpath}/${subj}/derived/03_uni/cbs/exp-0000/exp-0000-B/reorient/${extuni}.nii.gz"
	destination="${parentpath}/${subj}/derived/04_composition/${subj}_uni.nii.gz"
  command="cp ${cbsuni} ${destination}"
  echo "${command}"
  ${command}
	# copy inv2 images
	extinv2=${inv2[i]}
	cbsuni="${parentpath}/${subj}/derived/03_uni/cbs/exp-0000/exp-0000-?/reorient/${extinv2}.nii.gz"
	destination="${parentpath}/${subj}/derived/04_composition/${subj}_inv2.nii.gz"
  command="cp ${cbsuni} ${destination}"
  echo "${command}"
  ${command}
done
