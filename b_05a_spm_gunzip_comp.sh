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

# list all contrast names
declare -a contrast=(
				"T1w"
        "PD"
        "T2s"
                )

# create division images for all subjects
subjLen=${#app[@]}
contrLen=${#contrast[@]}
# loop through subjects
for (( i=0; i<${subjLen}; i++ )); do
	  subj=${app[i]}
		# loop through contrasts
		for (( j=0; j<${contrLen}; j++ )); do
			contr=${contrast[j]}
			if [[ "S06 S07" == *"$subj"* ]] && [[ "PD T2s" == *"$contr"* ]]
		  then
		    input="${parentpath}/${subj}/source/${subj}_${contr}_coreg.nii.gz "
		  else
		    input="${parentpath}/${subj}/source/${subj}_${contr}.nii.gz "
		  fi
			output="${parentpath}/${subj}/derived/04_composition/spm_T1_PD_T2s/${subj}_${contr}.nii.gz"
			# copy gz file into SPM directory
			command="cp ${input} ${output}"
			echo "${command}"
			${command}
			# gunzip
			command="gunzip ${output}"
			echo "${command}"
			${command}
	done
done
