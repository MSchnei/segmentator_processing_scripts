#!/bin/bash

#### Description: Set up the necessary directories
#### To be set:
####    -path to designated analysis folder,
####    -list with subject names
#### Output:
####    -directories for analysis
#### Written by: Marian Schneider, Faruk Gulban

# set path to designated analysis folder
parent_path="${segm_path}/analysis"

# list all subject names
declare -a subjects=(
				"S001"
				"S013"
				"S014"
				"S019"
        )

# deduce path to mp2rage folder
mp2rage_folder="${parent_path}/MP2RAGE"
# create mp2rage folder
mkdir -p ${mp2rage_folder}

# deduce number of subjects
subjLen=${#subjects[@]}

# create directory tree for all subjects
for (( j=0; j<${subjLen}; j++ )); do
  # deduce subject name
  subj=${subjects[j]}
  # create subfolders
  mkdir -p ${mp2rage_folder}/${subj}
  mkdir -p ${mp2rage_folder}/${subj}/source
  mkdir -p ${mp2rage_folder}/${subj}/source/corr
  mkdir -p ${mp2rage_folder}/${subj}/derived
  mkdir -p ${mp2rage_folder}/${subj}/derived/01_ground_truth
  mkdir -p ${mp2rage_folder}/${subj}/derived/02_masks
  mkdir -p ${mp2rage_folder}/${subj}/derived/03_uni
  mkdir -p ${mp2rage_folder}/${subj}/derived/03_uni/fast_restored_gramag
  mkdir -p ${mp2rage_folder}/${subj}/derived/03_uni/cbs
  mkdir -p ${mp2rage_folder}/${subj}/derived/03_uni/fast
  mkdir -p ${mp2rage_folder}/${subj}/derived/04_composition
  mkdir -p ${mp2rage_folder}/${subj}/derived/04_composition/00_compute_t2s
  mkdir -p ${mp2rage_folder}/${subj}/derived/05_gm
  mkdir -p ${mp2rage_folder}/${subj}/derived/06_gm_artifact_masked
  mkdir -p ${mp2rage_folder}/${subj}/derived/07_evaluation
  mkdir -p ${mp2rage_folder}/${subj}/derived/08_evaluation_artifact_masked
done
