#!/bin/bash

#### Description: Run fast segmentation
#### To be set:
####    -path to parent directory,
####    -subject names
#### Input:
####    -T1w_bet_nosub.nii.gz for all subjects
####    -PD_bet_nosub.nii.gz for all subjects
####    -T2s_bet_nosub.nii.gz for all subjects
#### Output:
####    -fast segmentation results for all subjects
#### Written by: Marian Schneider - marian.schneider@maastrichtuniversity.nl

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
  subj=${app[i]}
  command="fast "
  command+="-S 3 -n 3 -H 0.1 -I 4 -l 20.0 --nopve -B -b "
  command+="-o ${parentpath}/${subj}/derived/04_composition/fast_T1_PD_T2s/${subj}_trio "
	command+="${parentpath}/${subj}/derived/04_composition/${subj}_T1w_bet_nosub "
	command+="${parentpath}/${subj}/derived/04_composition/${subj}_PD_bet_nosub "
	command+="${parentpath}/${subj}/derived/04_composition/${subj}_T2s_bet_nosub "
  echo "${command}"
  ${command}
done
