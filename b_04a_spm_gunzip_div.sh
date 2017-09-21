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
  input="${parentpath}/${subj}/derived/03_division/${subj}_T1wDivPD.nii.gz"
	output="${parentpath}/${subj}/derived/03_division/spm/${subj}_T1wDivPD.nii.gz"
	# copy gz file into SPM directory
	command="cp ${input} ${output}"
	echo "${command}"
	${command}
	# gunzip
	command="gunzip ${output}"
	echo "${command}"
	${command}
done
