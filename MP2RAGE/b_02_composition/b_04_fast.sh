#!/bin/bash

#### Description: Run fast segmentation
#### To be set:
####    -path to parent directory,
####    -subject names
#### Input:
####    -Uni_bet_nosub.nii.gz for all subjects
####    -Inv2_bet_nosub.nii.gz for all subjects
####    -T2s_bet_nosub.nii.gz for all subjects
#### Output:
####    -fast biased-corrected uni, inv2, t2s for all subjects
####    -fast segmentation results for all subjects [not used later]
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
  subj=${app[i]}
  command="fast "
  command+="-S 3 -n 3 -H 0.1 -I 4 -l 20.0 --nopve -B -b "
  command+="-o ${parentpath}/${subj}/derived/04_composition/${subj}_trio "
	command+="${parentpath}/${subj}/derived/04_composition/${subj}_uni_bet_nosub "
	command+="${parentpath}/${subj}/derived/04_composition/${subj}_inv2_bet_nosub "
	command+="${parentpath}/${subj}/derived/04_composition/${subj}_t2s_bet_nosub "
  echo "${command}"
  ${command}
done
