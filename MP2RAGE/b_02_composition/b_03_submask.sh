#!/bin/bash

#### Description: Masks Uni, Inv2 and T2s images with brain+subcortical mask
#### To be set:
####    -path to parent directory,
####    -subject names
#### Input:
####    -Uni.nii.gz for all subjects
####    -Inv2.nii.gz for all subjects
####    -T2s.nii.gz for all subjects
####    -brain+subcortical mask for all subjects
#### Output:
####    -Uni_bet_nosub.nii.gz for all subjects
####    -Inv2_bet_nosub.nii.gz for all subjects
####    -T2s_bet_nosub.nii.gz for all subjects
#### Written by: Marian Schneider, Faruk Gulban

# set parent path
parentpath="/home/marian/gdrive/temp_segmentator_paper_data/MP2RAGE"

# list all subject names
declare -a app=(
				"S001"
        "S013"
        "S014"
        "S019"
                )

# mask all images with brain mask
subjLen=${#app[@]}
for (( i=0; i<${subjLen}; i++ )); do
  subj=${app[i]}
	# Uni
  command1="fslmaths "
  command1+="${parentpath}/${subj}/derived/04_composition/${subj}_uni.nii.gz "
  command1+="-mas "
  command1+="${parentpath}/${subj}/derived/02_masks/brain_mask_nosub "
  command1+="${parentpath}/${subj}/derived/04_composition/${subj}_uni_bet_nosub"
  echo "${command1}"
  ${command1}
	# Inv2
	command2="fslmaths "
  command2+="${parentpath}/${subj}/derived/04_composition/${subj}_inv2.nii.gz "
  command2+="-mas "
  command2+="${parentpath}/${subj}/derived/02_masks/brain_mask_nosub "
  command2+="${parentpath}/${subj}/derived/04_composition/${subj}_inv2_bet_nosub"
  echo "${command2}"
  ${command2}
	# T2s
	command3="fslmaths "
  command3+="${parentpath}/${subj}/derived/04_composition/${subj}_t2s.nii.gz "
  command3+="-mas "
  command3+="${parentpath}/${subj}/derived/02_masks/brain_mask_nosub "
  command3+="${parentpath}/${subj}/derived/04_composition/${subj}_t2s_bet_nosub"
  echo "${command3}"
  ${command3}
done
