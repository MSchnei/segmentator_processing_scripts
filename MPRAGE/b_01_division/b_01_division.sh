#!/bin/bash

#### Description: Divides T1w file by PD file and multiplies by 500
#### To be set:
####    -path to parent directory,
####    -subject names
#### Input:
####    -T1w.nii.gz fro all subjects
####    -PD.nii.gz for all subjects
#### Output:
####    -T1wDivPD.nii.gz for all subjects
#### Written by: Marian Schneider, Faruk Gulban

# set parent path
parentpath="/home/marian/gdrive/temp_segmentator_paper_data/MPRAGE"

# list all subject names
declare -a app=(
				"S02"
        "S03"
        "S05"
        "S06"
        "S07"
                )

# create division images for all subjects
subjLen=${#app[@]}
for (( i=0; i<${subjLen}; i++ )); do
	# derive particular subject name
  subj=${app[i]}
	# call to fslmaths
  command="fslmaths "
	# specify path to T1w image
  command+="${parentpath}/${subj}/source/${subj}_T1w "
	# divide
  command+="-div "
	# set path to Pd images
	# consider that some subject's PDs needed coregistration to T1w images
  if [[ "S06 S07" == *"$subj"* ]]
  then
    command+="${parentpath}/${subj}/source/${subj}_PD_coreg "
  else
    command+="${parentpath}/${subj}/source/${subj}_PD "
  fi
	# multiply by 500
  command+="-mul 500 "
	# specify output name
  command+="${parentpath}/${subj}/derived/03_division/${subj}_T1wDivPD"
  echo "${command}"
  ${command}
done
