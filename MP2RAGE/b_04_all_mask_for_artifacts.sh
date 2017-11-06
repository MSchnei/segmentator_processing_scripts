#/bin/bash

parentpath="/home/marian/gdrive/temp_segmentator_paper_data/MP2RAGE"

# list all subject names
declare -a app=(
		"S001"
		"S013"
		"S014"
		"S019"
                )

declare -a arr_seg=(
    "_uni_fast_gm"
    "_uni_fast_gm_gramag"
    "_uni_fast_gm_simplex"
    "_uni_cbs_gm"
    "_uni_cbs_gm_gramag"
    "_uni_cbs_gm_simplex"
    )

echo "================================"
echo "Masking GM with artifact mask..."
echo "================================"

subjLen=${#app[@]}
gmLen=${#arr_seg[@]}

for (( i=0; i<${subjLen}; i++ )); do
	# derive subject names
	subj=${app[i]}
	# derive artifact mask name
	mask="$parentpath/${subj}/derived/02_masks/artifact_mask"
	# mask segmentations with artifact mask
	echo "...Masking segmentations with artifact mask..."
  for (( j=0; j<${gmLen}; j++ )); do
		# ribbons
    gm=${arr_seg[j]}
    input_name="${parentpath}/${subj}/derived/05_gm/${subj}${gm}"
    new_name="${input_name}_artifact_masked"
    out_dir="${parentpath}/${subj}/derived/06_gm_artifact_masked"
    new_name_out=${out_dir}/$(basename $new_name)
		command="fslmaths ${input_name} -mas ${mask} ${new_name_out}"
    echo ${command}
    ${command}
		# borders
		gm=${arr_seg[j]}
		input_name="${parentpath}/${subj}/derived/05_gm/${subj}${gm}_borders"
		new_name="${input_name}_artifact_masked"
		out_dir="${parentpath}/${subj}/derived/06_gm_artifact_masked"
		new_name_out=${out_dir}/$(basename $new_name)
		command="fslmaths ${input_name} -mas ${mask} ${new_name_out}"
		echo ${command}
		${command}
  done
	# mask ground truth with artifact mask
	echo "...Masking ground truths with artifact mask..."
	# ribbon
	input_name="${parentpath}/${subj}/derived/01_ground_truth/${subj}_gm_0?.nii.gz"
	new_name=$(echo $input_name | cut -f 1 -d '.')"_artifact_masked"
	out_dir="${parentpath}/${subj}/derived/01_ground_truth"
	new_name_out=${out_dir}/$(basename $new_name)
	command="fslmaths ${input_name} -mas ${mask} ${new_name_out}"
	echo ${command}
	${command}
	# border
	input_name="${parentpath}/${subj}/derived/01_ground_truth/${subj}_gm_0?_borders.nii.gz"
	new_name=$(echo $input_name | cut -f 1 -d '.')"_artifact_masked"
	out_dir="${parentpath}/${subj}/derived/01_ground_truth"
	new_name_out=${out_dir}/$(basename $new_name)
	command="fslmaths ${input_name} -mas ${mask} ${new_name_out}"
	echo ${command}
	${command}

done

echo -e "\nDone.\n"