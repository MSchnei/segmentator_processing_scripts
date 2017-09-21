#/bin/bash

parentpath="/home/marian/gdrive/temp_segmentator_paper_data/MPRAGE"

declare -a arr_t1=(
  "S02"
  "S03"
  "S05"
  "S06"
  "S07"
    )

echo "======================="
echo "Preparing ncut files..."
echo "======================="
tLen=${#arr_t1[@]}
for (( i=0; i<${tLen}; i++ )); do
  subj=${arr_t1[i]}
  input_name="${parentpath}/${subj}/derived/03_division/fast/${subj}_division_restore.nii.gz"
  # save 2D histogram
  command="segmentator $input_name "
  command+="--percmin 2.5 --percmax 97.5 --scale 400 --nogui"
  echo "${command}"
  ${command}
  # prepare ncut tree
  hist_name=${input_name%.nii*}"_volHist*.npy"
  command="segmentator --ncut_prepare ${hist_name}"
  echo "${command}"
  ${command}

  echo -e "\n----\n"
done
