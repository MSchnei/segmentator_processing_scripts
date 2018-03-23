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
				"S02"
				"S03"
				"S05"
				"S06"
				"S07"
        )

# deduce path to data folder
data_path="${segm_path}/data"
# deduce path to analysis folder
analysis_path="${segm_path}/analysis"
# deduce path to mprage folder
mprage_folder="${data_path}/shared_data/data_mprage"
# deduce number of subjects
subjLen=${#subjects[@]}

# move files from data to analysis folder
for (( j=0; j<${subjLen}; j++ )); do
  # deduce subject name
  subj=${subjects[j]}
  # move files
  mv ${mprage_folder}/sub-02/anat


done
