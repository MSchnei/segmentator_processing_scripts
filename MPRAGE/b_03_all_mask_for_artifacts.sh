#/bin/bash

parentpath="/home/marian/gdrive/temp_segmentator_paper_data/MPRAGE"

# list all subject names
declare -a app=(
				"S02"
        "S03"
        "S05"
        "S06"
        "S07"
                )

declare -a arr_seg=(
    "_division_fast_gm"
    "_division_fast_gm_gramag"
    "_division_fast_gm_simplex"
    "_division_spm_gm"
    "_division_spm_gm_gramag"
    "_division_spm_gm_simplex"
    )

echo "================================"
echo "Masking GM with atrifact mask..."
echo "================================"

subjLen=${#app[@]}
gmLen=${#arr_seg[@]}

for (( i=0; i<${subjLen}; i++ )); do
  subj=${app[i]}
  for (( j=0; j<${gmLen}; j++ )); do
    gm=${arr_seg[j]}

    input_name="${parentpath}/${subj}/derived/05_gm/${subj}${gm}"
    new_name="${input_name}_artifact_masked"
    out_dir="${parentpath}/${subj}/derived/06_gm_artifact_masked"
    new_name_out=${out_dir}/$(basename $new_name)
    mask="$parentpath/${subj}/derived/02_masks/artifact_mask_T2s"
    command="fslmaths ${mask} -mul -1 -add 1 -mul ${input_name} ${new_name_out}"
    echo ${command}
    ${command}

  done
done

echo -e "\nDone.\n"
