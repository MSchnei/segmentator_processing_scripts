#!/bin/bash

#### Description: Map files from BIDS format to analysis directory tree
#### To be set:
####    -path to designated analysis folder,
####    -list with subject names
#### Input:
####    -files in BIDS format
#### Output:
####    -files in analysis directory tree format
#### Written by: Marian Schneider, Faruk Gulban

# list all subject names
declare -a subjects=(
				"02"
				"03"
				"05"
				"06"
				"07"
        )

# deduce path to data folder
data_path="${segm_path}/data"
# deduce path to analysis folder
analysis_path="${segm_path}/analysis"
# deduce path to mprage data folder
mprage_data_folder="${data_path}/shared_data/data_mprage"
# deduce path to mprage analysis folder
mprage_analysis_folder="${analysis_path}/MPRAGE"
# deduce number of subjects
subjLen=${#subjects[@]}

# move files from data to analysis folder
for (( j=0; j<${subjLen}; j++ )); do
  # deduce subject name
  subj=${subjects[j]}
  # copy source files
  cp ${mprage_data_folder}/sub-${subj}/anat/sub-${subj}_PD_defaced.nii.gz ${mprage_analysis_folder}/S${subj}/source/S${subj}_PD.nii.gz
  cp ${mprage_data_folder}/sub-${subj}/anat/sub-${subj}_T1w_defaced.nii.gz ${mprage_analysis_folder}/S${subj}/source/S${subj}_T1w.nii.gz
  cp ${mprage_data_folder}/sub-${subj}/anat/sub-${subj}_T2star_defaced.nii.gz ${mprage_analysis_folder}/S${subj}/source/S${subj}_T2s.nii.gz
  # copy masks
  cp ${mprage_data_folder}/derivatives/sub-${subj}/masks/sub-${subj}_brain_mask.nii.gz ${mprage_analysis_folder}/S${subj}/derived/02_masks/brain_mask.nii.gz
  cp ${mprage_data_folder}/derivatives/sub-${subj}/masks/sub-${subj}_brain_mask_nosub.nii.gz ${mprage_analysis_folder}/S${subj}/derived/02_masks/brain_mask_nosub.nii.gz
  cp ${mprage_data_folder}/derivatives/sub-${subj}/masks/sub-${subj}_artifact_mask_T2star.nii.gz ${mprage_analysis_folder}/S${subj}/derived/02_masks/artifact_mask_T2s.nii.gz
  # copy ground truth files
  cp ${mprage_data_folder}/derivatives/sub-${subj}/ground_truth/sub-${subj}_gm_v*.nii.gz ${mprage_analysis_folder}/S${subj}/derived/01_ground_truth/S${subj}_gm_01.nii.gz
done
