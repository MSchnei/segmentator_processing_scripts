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
  command="fslmaths "
  command+="${parentpath}/${subj}/source/${subj}_T1w "
  command+="-div "

  if [[ "S06 S07" == *"$subj"* ]]
  then
    command+="${parentpath}/${subj}/source/${subj}_PD_coreg "
  else
    command+="${parentpath}/${subj}/source/${subj}_PD "
  fi
  command+="-mul 500 "
  command+="${parentpath}/${subj}/derived/03_division/${subj}_T1wDivPD"
  echo "${command}"
  ${command}
done
