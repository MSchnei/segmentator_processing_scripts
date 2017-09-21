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
	# get only the grey matter
  input="${parentpath}/${subj}/derived/03_division/fast/${subj}_division_seg"
	output="${parentpath}/${subj}/derived/03_division/fast/${subj}_division_GM"
	command="fslmaths ${input} -thr 2 -uthr 2 -div 2 ${output}"
	echo "${command}"
	${command}
	# copy gz file into GM directory
	destination="${parentpath}/${subj}/derived/05_gm/${subj}_division_fast_gm"
	command="cp ${output}.nii.gz ${destination}.nii.gz"
	echo "${command}"
	${command}
	# delete original filename
	command="rm -rf ${output}.nii.gz"
	echo "${command}"
	${command}
done
