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
	output="${parentpath}/${subj}/derived/03_division/spm/m${subj}_T1wDivPD.nii"
	# gzip
	command="gzip ${output}"
	echo "${command}"
	${command}
done
