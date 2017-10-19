#!/bin/bash

#### Description: Run normalized graph cuts for fast images
#### To be set:
####    -path to parent directory,
####    -subject names
####    -2D histogram properties:
####    -path to ncut.npy file
#### Input:
####    -fast biased corrected uni image
#### Output:
####    -segmentator brain mask for fast GM
#### Written by: Marian Schneider, Faruk Gulban

# set parent path
parentpath="/home/marian/gdrive/temp_segmentator_paper_data/MP2RAGE"

# list all subject names
declare -a arr_t1=(
				"S001"
        "S013"
        "S014"
        "S019"
                )

# set 2D histogram properties
percmin="0.1"
percmax="99.9"
scale="400"
gramag="3D_scharr"
cbar_init="2.0"
cbar_max="5.0"

# set path to ncut.npy file
ncut_base="_uni_restore_volHist_pMax99pt9_pMin0pt1_sc400_ncut_sp2500_c2pt0.npy"


echo "====================="
echo "Batch Segmentator GUI"
echo "====================="
tLen=${#arr_t1[@]}
for (( i=0; i<${tLen}; i++ )); do
  subj=${arr_t1[i]}
  input_name="${parentpath}/${subj}/derived/03_uni/fast/${subj}_uni_restore.nii.gz"
  input_ncut="${parentpath}/${subj}/derived/03_uni/fast/${subj}${ncut_base}"

  command="segmentator $input_name --ncut $input_ncut "
  command+="--percmin ${percmin} --percmax ${percmax} --scale ${scale} "
  command+="--gramag ${gramag} --cbar_init ${cbar_init} --cbar_max ${cbar_max} "
  echo "${command}"
  ${command}

done

echo -e "\nDone.\n"
