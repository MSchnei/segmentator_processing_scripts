#!/bin/bash

#### Description: Prepare normalized graph cuts for fast images
#### To be set:
####    -path to parent directory,
####    -subject names
####    -2D histogram properties:
####    -ncut_prepare properties
#### Input:
####    -fast biased corrected T1divPD image
#### Output:
####    -2D histogram.npy file
####    -ncut.npy file
#### Written by: Marian Schneider, Faruk Gulban

# set parent path
parentpath="/home/marian/gdrive/temp_segmentator_paper_data/MPRAGE"

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
cbar_init="2.0"
cbar_max="5.0"
gramag="3D_scharr"

#set ncut_prepare properties
mR="8"
sp="2500"
c="2"

echo "======================="
echo "Preparing ncut files..."
echo "======================="
tLen=${#arr_t1[@]}
for (( i=0; i<${tLen}; i++ )); do
  subj=${arr_t1[i]}
  input_name="${parentpath}/${subj}/derived/03_division/fast/${subj}_division_restore.nii.gz"
  # save 2D histogram
  command="segmentator $input_name "
  command+="--percmin ${percmin} --percmax ${percmax} --scale ${scale} "
  command+="--gramag ${gramag} --cbar_init ${cbar_init} --cbar_max ${cbar_max} "
  command+="--nogui"
  echo "${command}"
  ${command}
  # prepare ncut tree
  hist_name=${input_name%.nii*}"_volHist*_sc${scale}.npy"
  command="segmentator --ncut_prepare ${hist_name} "
  command+="--ncut_maxRec ${mR} --ncut_nrSupPix ${sp} --ncut_compactness ${c} "
  command+="--percmin ${percmin} --percmax ${percmax} --scale ${scale} "
  command+="--gramag ${gramag} --cbar_init ${cbar_init} --cbar_max ${cbar_max} "
  echo "${command}"
  ${command}

  echo -e "\n----\n"
done
