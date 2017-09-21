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
	# copy gm file into GM directory
	source="${parentpath}/${subj}/derived/03_division/spm/c1${subj}_T1wDivPD_max"
	destination="${parentpath}/${subj}/derived/05_gm/${subj}_division_spm_gm"
	command="cp ${source}.nii.gz ${destination}_unmsk.nii.gz"
	echo "${command}"
	${command}

	# mask with the nosub mask
	mask="${parentpath}/${subj}/derived/02_masks/nosub"
	command="fslmaths $mask -mul -1 -add 1 -mul ${destination}_unmsk ${destination}"
	echo "${command}"
	${command}

	# delete original filename
	command="rm -rf ${destination}_unmsk.nii.gz"
	echo "${command}"
	${command}
done
