#!/bin/bash

#### Description: Masks T1w, PD and T2s images with brain+subcortical mask
#### To be set:
####    -path to parent directory,
####    -subject names
#### Input:
####    -T1w.nii.gz for all subjects
####    -PD.nii.gz for all subjects
####    -T2s.nii.gz for all subjects
####    -brain+subcortical mask for all subjects
#### Output:
####    -T1w_bet_nosub.nii.gz for all subjects
####    -PD_bet_nosub.nii.gz for all subjects
####    -T2s_bet_nosub.nii.gz for all subjects
#### Written by: Marian Schneider, Faruk Gulban

# set parent path
parent_path="${segm_path}/analysis/MPRAGE"

# list all subject names
declare -a app=(
				"S02"
        "S03"
        "S05"
        "S06"
        "S07"
                )

# mask all images with brain mask
subjLen=${#app[@]}
for (( i=0; i<${subjLen}; i++ )); do
  subj=${app[i]}
	# T1w
  command1="fslmaths "
  command1+="${parent_path}/${subj}/source/${subj}_T1w "
  command1+="-mas "
  command1+="${parent_path}/${subj}/derived/02_masks/brain_mask_nosub "
  command1+="${parent_path}/${subj}/derived/04_composition/${subj}_T1w_bet_nosub"
  echo "${command1}"
  ${command1}
	# PDw
	command2="fslmaths "
	command2+="${parent_path}/${subj}/source/${subj}_PD "
  command2+="-mas "
  command2+="${parent_path}/${subj}/derived/02_masks/brain_mask_nosub "
  command2+="${parent_path}/${subj}/derived/04_composition/${subj}_PD_bet_nosub"
  echo "${command2}"
  ${command2}
	# T2s
  command3="fslmaths "
	command3+="${parent_path}/${subj}/source/${subj}_T2s "
  command3+="-mas "
  command3+="${parent_path}/${subj}/derived/02_masks/brain_mask_nosub "
  command3+="${parent_path}/${subj}/derived/04_composition/${subj}_T2s_bet_nosub"
  echo "${command3}"
  ${command3}
done
