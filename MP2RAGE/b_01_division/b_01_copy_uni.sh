#!/bin/bash

#### Description: Copies uni image that was reoriented by cbs tools
#### To be set:
####    -path to parent directory,
####    -cbs extensions for reoriented uni images
####    -subject names
#### Input:
####    -uni.nii.gz for all subjects
#### Output:
####    -copy of uni.nii.gz for all subjects
#### Written by: Marian Schneider, Faruk Gulban

# set parent path
parentpath="/home/marian/gdrive/temp_segmentator_paper_data/MP2RAGE"

# set cbs extensions
declare -a cbs=(
	"RoyHaa_110416_S001C001_Ses2_20160411_001_020_mp2rage_iso0_7_iPAT3_mp2rage_iso0_7_iPAT3_UNI_Images_clone_transform"
	"RoyHaa_260315_S013C001_20150326_001_021_mp2rage_iso0_7_iPAT3_mp2rage_iso0_7_iPAT3_UNI_Images_clone_transform"
	"RoyHaa_080415_S014C001_20150408_001_021_mp2rage_iso0_7_iPAT3_mp2rage_iso0_7_iPAT3_UNI_Images_clone_transform"
	"RoyHaa_060515_S019C001_20150506_001_023_mp2rage_iso0_7_iPAT3_mp2rage_iso0_7_iPAT3_UNI_Images_clone_transform"
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
	ext=${cbs[i]}
	cbsuni="${parentpath}/${subj}/derived/03_uni/cbs/exp-0000/exp-0000-B/reorient/${ext}.nii.gz"
	destination="${parentpath}/${subj}/derived/03_uni/${subj}_uni.nii.gz"
  command="cp ${cbsuni} ${destination}"
  echo "${command}"
  ${command}
done
