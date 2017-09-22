#/bin/bash

parentpath="/home/marian/gdrive/temp_segmentator_paper_data/MPRAGE"

declare -a arr_t1=(
  "S02"
  "S03"
  "S05"
  "S06"
  "S07"
    )

percmin="2.5"
percmax="97.5"
scale="400"
cbar_init="2.0"
cbar_max="5.0"
gramag="3D_scharr"
#ncut_prepare features
mR="8"
sp="2500"
c="2"

echo "======================="
echo "Preparing ncut files..."
echo "======================="
tLen=${#arr_t1[@]}
for (( i=0; i<${tLen}; i++ )); do
  subj=${arr_t1[i]}
  input_name="${parentpath}/${subj}/derived/03_division/spm/m${subj}_T1wDivPD_msk.nii.gz"
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
