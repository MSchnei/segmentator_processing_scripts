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
				"001"
				"013"
				"014"
				"019"
        )

# deduce path to data folder
data_path="${segm_path}/data"
# deduce path to analysis folder
analysis_path="${segm_path}/analysis"
# deduce path to mprage data folder
mp2rage_data_folder="${data_path}/shared_data/data_mp2rage"
# deduce path to mprage analysis folder
mp2rage_analysis_folder="${analysis_path}/MP2RAGE"
# deduce number of subjects
subjLen=${#subjects[@]}

# move files from data to analysis folder
for (( j=0; j<${subjLen}; j++ )); do
  # deduce subject name
  subj=${subjects[j]}
  # copy source files
  cp ${mp2rage_data_folder}/sub-${subj}/anat/sub-${subj}_t1_defaced2.nii.gz ${mp2rage_analysis_folder}/S${subj}/source/S${subj}_t1.nii.gz
  cp ${mp2rage_data_folder}/sub-${subj}/anat/sub-${subj}_inv1_defaced.nii.gz ${mp2rage_analysis_folder}/S${subj}/source/S${subj}_inv1.nii.gz
  cp ${mp2rage_data_folder}/sub-${subj}/anat/sub-${subj}_inv2_defaced.nii.gz ${mp2rage_analysis_folder}/S${subj}/source/S${subj}_inv2.nii.gz
  cp ${mp2rage_data_folder}/sub-${subj}/anat/sub-${subj}_uni_defaced.nii.gz ${mp2rage_analysis_folder}/S${subj}/source/S${subj}_uni.nii.gz
  cp ${mp2rage_data_folder}/sub-${subj}/anat/sub-${subj}_me_gre_defaced.nii.gz ${mp2rage_analysis_folder}/S${subj}/source/S${subj}_me_gre.nii.gz

  # copy masks
  cp ${mprage_data_folder}/derivatives/sub-${subj}/masks/sub-${subj}_brain_mask.nii.gz ${mprage_analysis_folder}/S${subj}/derived/02_masks/brain_mask.nii.gz
  cp ${mprage_data_folder}/derivatives/sub-${subj}/masks/sub-${subj}_brain_mask_nosub.nii.gz ${mprage_analysis_folder}/S${subj}/derived/02_masks/brain_mask_nosub.nii.gz
  cp ${mprage_data_folder}/derivatives/sub-${subj}/masks/sub-${subj}_artifact_mask_T2star.nii.gz ${mprage_analysis_folder}/S${subj}/derived/02_masks/artifact_mask.nii.gz

  # copy ground truth files
  cp ${mp2rage_data_folder}/derivatives/sub-${subj}/ground_truth/sub-${subj}_gm_v*.nii.gz ${mp2rage_analysis_folder}/S${subj}/derived/01_ground_truth/S${subj}_gm_01.nii.gz

  # copy T2 start map
  cp ${mp2rage_data_folder}/derivatives/sub-${subj}/t2star/sub-${subj}_t2s_map_resliced_defaced.nii.gz ${mp2rage_analysis_folder}/S${subj}/derived/04_composition/S${subj}_t2s.nii.gz

done
