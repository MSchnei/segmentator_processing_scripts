#!/bin/bash

#### Description: Run normalized graph cuts for fast images
#### To be set:
####    -path to parent directory,
####    -subject names
####    -2D histogram properties:
####    -path to ncut.npy file
#### Input:
####    -fast biased corrected T1divPD image
#### Output:
####    -segmentator brain mask for fast GM
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
percmin="2.5"
percmax="97.5"
scale="400"
gramag="3D_scharr"
cbar_init="2.0"
cbar_max="5.0"

# set path to ncut.npy file
ncut_base="_division_restore_volHist_pMax97pt5_pMin2pt5_sc400_ncut_sp2500_c2.npy"

echo "====================="
echo "Batch Segmentator GUI"
echo "====================="
tLen=${#arr_t1[@]}
for (( i=0; i<${tLen}; i++ )); do
  subj=${arr_t1[i]}
  input_name="${parent_path}/${subj}/derived/03_division/fast/${subj}_division_restore.nii.gz"
  input_ncut="${parent_path}/${subj}/derived/03_division/fast/${subj}${ncut_base}"

  command="segmentator $input_name --ncut $input_ncut "
  command+="--percmin ${percmin} --percmax ${percmax} --scale ${scale} "
  command+="--gramag ${gramag} --cbar_init ${cbar_init} --cbar_max ${cbar_max} "
  echo "${command}"
  ${command}

done

echo -e "\nDone.\n"
