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
	# T1w
  command1="fslmaths "
  command1+="${parentpath}/${subj}/source/${subj}_T1w "
  command1+="-mas "
  command1+="${parentpath}/${subj}/derived/02_masks/brain_mask_nosub "
  command1+="${parentpath}/${subj}/derived/04_composition/${subj}_T1w_bet_nosub"
  echo "${command1}"
  ${command1}
	# PDw
  command2="fslmaths "
	if [[ "S06 S07" == *"$subj"* ]]
	then
		command2+="${parentpath}/${subj}/source/${subj}_PD_coreg "
	else
		command2+="${parentpath}/${subj}/source/${subj}_PD "
	fi
  command2+="-mas "
  command2+="${parentpath}/${subj}/derived/02_masks/brain_mask_nosub "
  command2+="${parentpath}/${subj}/derived/04_composition/${subj}_PD_bet_nosub"
  echo "${command2}"
  ${command2}
	# T2s
  command3="fslmaths "
	if [[ "S06 S07" == *"$subj"* ]]
	then
		command3+="${parentpath}/${subj}/source/${subj}_T2s_coreg "
	else
		command3+="${parentpath}/${subj}/source/${subj}_T2s "
	fi
  command3+="-mas "
  command3+="${parentpath}/${subj}/derived/02_masks/brain_mask_nosub "
  command3+="${parentpath}/${subj}/derived/04_composition/${subj}_T2s_bet_nosub"
  echo "${command3}"
  ${command3}
done
