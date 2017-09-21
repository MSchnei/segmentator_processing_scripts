#/bin/bash

parentpath="/home/marian/gdrive/temp_segmentator_paper_data/MPRAGE"

declare -a arr_t1=(
  "S02"
  "S03"
  "S05"
  "S06"
  "S07"
    )

ncut_base="_division_restore_volHist_pMax97pt5_pMin2pt5_sc400_ncut_sp2500_c2.npy"

echo "====================="
echo "Batch Segmentator GUI"
echo "====================="
tLen=${#arr_t1[@]}
for (( i=0; i<${tLen}; i++ )); do
  subj=${arr_t1[i]}
  input_name="${parentpath}/${subj}/derived/03_division/fast/${subj}_division_restore.nii.gz"
  input_ncut="${parentpath}/${subj}/derived/03_division/fast/${subj}${ncut_base}"

  command="segmentator $input_name --ncut $input_ncut "
  command+="--percmin 2.5 --percmax 97.5 --scale 400"
  echo "${command}"
  ${command}

  # # move outputs to a separate folder
  # mask_name=${input_name%.nii*}"_label*"
  # out_dir=${working_dir}"/04_segmentator_ncut"
  # mask_out_name=${out_dir}/$(basename $mask_name)
  #
  # command="mv $mask_name $mask_out_name"
  # ${command}
  # echo -e "\nmoved to $mask_out_name \n"

done

echo -e "\nDone.\n"
