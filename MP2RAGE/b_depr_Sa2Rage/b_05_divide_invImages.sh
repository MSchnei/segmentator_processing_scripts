#!/bin/bash

#### Description: Divides inv files by b1_corr and multiplies by 1000
#### To be set:
####    -path to parent directory,
####    -subject names
#### Input:
####    -inv1.nii.gz fro all subjects
####    -inv2.nii.gz for all subjects
####    -b1_corr.nii.gz for all subjects
#### Output:
####    -inv1_corr.nii.gz for all subjects
####    -inv2_corr.nii.gz for all subjects
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

# create division images for all subjects
subjLen=${#app[@]}
for (( i=0; i<${subjLen}; i++ )); do
	# derive particular subject name
  subj=${app[i]}
	# call to fslmaths
  command="fslmaths "
	# specify path to inv1 image
  command+="${parentpath}/${subj}/source/${subj}_inv1 "
	# divide
  command+="-div "
	# set path to b1_corr images
  command+="${parentpath}/${subj}/source/corr/b1_corr "
	# multiply by 500
  command+="-mul 1000 "
	# specify output name
  command+="${parentpath}/${subj}/source/corr/inv1_corr"
  echo "${command}"
  ${command}
	# call to fslmaths
  command="fslmaths "
	# specify path to inv2 image
  command+="${parentpath}/${subj}/source/${subj}_inv2 "
	# divide
  command+="-div "
	# set path to b1_corr images
  command+="${parentpath}/${subj}/source/corr/b1_corr "
	# multiply by 500
  command+="-mul 1000 "
	# specify output name
  command+="${parentpath}/${subj}/source/corr/inv2_corr"
  echo "${command}"
  ${command}
done
