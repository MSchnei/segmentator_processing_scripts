#!/bin/bash

#### Description: Run normalized graph cuts for spm images
#### To be set:
####    -path to parent directory,
####    -subject names
####    -2D histogram properties:
####    -path to ncut.npy file
#### Input:
####    -spm biased corrected T1divPD image
#### Output:
####    -segmentator brain mask for spm GM
#### Written by: Marian Schneider, Faruk Gulban

# set parent path
parent_path="${segm_path}/analysis/MPRAGE"

declare -a arr_t1=(
  "S02"
  "S03"
  "S05"
  "S06"
  "S07"
    )

# set 2D histogram properties
percmin="0.1"
percmax="99.9"
scale="400"
cbar_init="2.0"
cbar_max="5.0"
gramag="3D_scharr"

# set path to ncut.npy file
ncut_base="_T1wDivPD_msk_volHist_pMax99pt9_pMin0pt1_sc400_ncut_sp2500_c2pt0.npy"

echo "====================="
echo "Batch Segmentator GUI"
echo "====================="
tLen=${#arr_t1[@]}
for (( i=0; i<${tLen}; i++ )); do
  subj=${arr_t1[i]}
  input_name="${parent_path}/${subj}/derived/03_division/spm/m${subj}_T1wDivPD_msk.nii.gz"
  input_ncut="${parent_path}/${subj}/derived/03_division/spm/m${subj}${ncut_base}"

  command="segmentator $input_name --ncut $input_ncut "
  command+="--percmin ${percmin} --percmax ${percmax} --scale ${scale} "
  command+="--gramag ${gramag} --cbar_init ${cbar_init} --cbar_max ${cbar_max} "
  echo "${command}"
  ${command}

done

echo -e "\nDone.\n"
