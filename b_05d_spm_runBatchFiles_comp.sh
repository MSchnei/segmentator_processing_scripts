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
	pathTextFile="${parentpath}/${subj}/derived/04_composition/spm_T1_PD_T2s/spm_comp.m"
	# run SPM batch script
	command="MATLAB -nodisplay -nodesktop -nosplash -r run('${pathTextFile}'); exit;"
	echo "${command}"
	${command}
	# remove batch file
	# command="rm -rf ${pathTextFile}"
	# echo "${command}"
	# ${command}
done
