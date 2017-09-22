# set parent path

parentpath="/home/marian/gdrive/temp_segmentator_paper_data/MPRAGE"

# list all subject names
declare -a app=(
				"S02"
        "S03"
        "S05"
        "S06"
        "S07"
                )

# create division images for all subjects
subjLen=${#app[@]}
for (( i=0; i<${subjLen}; i++ )); do
  subj=${app[i]}
  # mask fast gm with segmentator gradient magnitude ncut brain mask
	input="${parentpath}/${subj}/derived/05_gm/${subj}_division_spm_gm"
	mask="${parentpath}/${subj}/derived/03_division/spm/m${subj}_T1wDivPD_msk_labels_0"
	output="${parentpath}/${subj}/derived/05_gm/${subj}_division_spm_gm_gramag"
	command="fslmaths ${input} -mas ${mask} ${output}"
	echo "${command}"
	${command}
done
