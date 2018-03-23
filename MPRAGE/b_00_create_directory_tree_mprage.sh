#!/bin/bash

#### Description: Set up the necessary directories
#### To be set:
####    -path to designated analysis folder,
####    -list with subject names
#### Output:
####    -directories for analysis
#### Written by: Marian Schneider, Faruk Gulban

# set path to designated analysis folder
parentpath="${/home/marian/gdrive/temp_segmentator_paper_data}"

# list all subject names
declare -a subjects=(
				"S02"
				"S03"
				"S05"
				"S06"
				"S07"
        )

# deduce path to mp2rage folder
mprage_folder = "${parentpath}/MPRAGE"
# create mp2rage folder
mkdir -p ${mprage_folder}

# deduce number of subjects
subjLen=${#subjects[@]}

# create directory tree for all subjects
for (( j=0; j<${subjLen}; j++ )); do
  # deduce subject name
  subj=${subjects[j]}
  # create subfolders
	mkdir -p ${mprage_folder}/${subj}
	mkdir -p ${mprage_folder}/${subj}/source
	mkdir -p ${mprage_folder}/${subj}/source/orig
	mkdir -p ${mprage_folder}/${subj}/derived
	mkdir -p ${mprage_folder}/${subj}/derived/01_ground_truth
	mkdir -p ${mprage_folder}/${subj}/derived/02_masks
	mkdir -p ${mprage_folder}/${subj}/derived/03_division
	mkdir -p ${mprage_folder}/${subj}/derived/03_division/fast
	mkdir -p ${mprage_folder}/${subj}/derived/03_division/spm
	mkdir -p ${mprage_folder}/${subj}/derived/04_composition
	mkdir -p ${mprage_folder}/${subj}/derived/04_composition/fast_T1_PD_T2s
	mkdir -p ${mprage_folder}/${subj}/derived/04_composition/spm_T1_PD_T2s
	mkdir -p ${mprage_folder}/${subj}/derived/05_gm
	mkdir -p ${mprage_folder}/${subj}/derived/06_gm_artifact_masked
	mkdir -p ${mprage_folder}/${subj}/derived/07_evaluation
	mkdir -p ${mprage_folder}/${subj}/derived/08_evaluation_artifact_masked
done
