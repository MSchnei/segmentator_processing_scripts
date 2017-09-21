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
  command+="${parentpath}/${subj}/derived/03_division/${subj}_T1wDivPD "
  command+="-mas "
  command+="${parentpath}/${subj}/derived/02_masks/brain_mask_nosub "
  command+="${parentpath}/${subj}/derived/03_division/${subj}_T1wDivPD_bet_nosub"
  echo "${command}"
  ${command}
done
