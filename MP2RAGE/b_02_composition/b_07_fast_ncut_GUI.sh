#!/bin/bash

#### Description: Run normalized graph cuts for fast composition images
#### To be set:
####    -path to parent directory,
####    -subject names
####    -2D histogram properties:
####    -path to ncut.npy file
#### Input:
####    -ilr1 image
####    -ilr2 image
#### Output:
####    -segmentator brain mask for fast GM
#### Written by: Marian Schneider, Faruk Gulban

# set parent path
parent_path="${segm_path}/analysis/MP2RAGE"

declare -a arr_t1=(
    "S001"
    "S013"
    "S014"
    "S019"
    )

# set 2D histogram properties
percmin="0.25"
percmax="99.75"
scale="400"
cbar_init="2.5"
cbar_max="5.0"

# set path to ncut.npy file
ncut_base="_volHist_pMax99pt75_pMin0pt25_sc400_ncut_sp2500_c2pt0.npy"

echo "====================="
echo "Batch Segmentator GUI"
echo "====================="
tLen=${#arr_t1[@]}
for (( i=0; i<${tLen}; i++ )); do
  subj=${arr_t1[i]}
  input_name1="${parent_path}/${subj}/derived/04_composition/ilr_coord_1.nii.gz"
  input_name2="${parent_path}/${subj}/derived/04_composition/ilr_coord_2.nii.gz"
  input_ncut="${parent_path}/${subj}/derived/04_composition/ilr_coord_1${ncut_base}"

  command="segmentator $input_name1 --ncut $input_ncut "
  command+="--percmin ${percmin} --percmax ${percmax} --scale ${scale} "
  command+="--gramag ${input_name2} "
  command+="--cbar_init ${cbar_init} --cbar_max ${cbar_max} "

  echo "${command}"
  ${command}

done

echo -e "\nDone.\n"
