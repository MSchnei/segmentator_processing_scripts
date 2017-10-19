#!/bin/bash

# set path to folder with the validation data
parentpath="/home/marian/gdrive/temp_segmentator_paper_data/MP2RAGE"

# set path to evaluate segmentation (visceral project) executable
evalseg='/home/marian/EvaluateSegmentation/EvaluateSegmentation'

# list all subject names
declare -a app=(
				"S001"
				"S013"
				"S014"
				"S019"
        )

# set corr extensions
declare -a corr=(
	"inv2"
	"no_corr"
          )

subjLen=${#app[@]}
tLen=${#corr[@]}
for (( j=0; j<${subjLen}; j++ )); do
  # deduce subject name
  subj=${app[j]}
  # deduce path name for ground truth
  truth="${parentpath}/${subj}/derived/01_ground_truth/${subj}_gm_0?.nii.gz"
  # loop throuh different segmentation results
  for (( i=0; i<${tLen}; i++ )); do
    # deduce name for segmentation result file
		ext=${corr[i]}
    segm="${parentpath}/temp_CBS_segmentations/${subj}/${ext}/t1_thresh_clone_transform_strip_mems_gm_cortex_mas.nii.gz"
    # evaluate the segmentation
    command="${evalseg} ${truth} ${segm} "
    command+="-use DICE,AVGDIST,SNSVTY,SPCFTY,ACURCY,PRCISON "
    command+="-xml ${parentpath}/temp_CBS_segmentations/${subj}/evaluation/${ext}.xml"
    echo "${command}"
    ${command}
  done
done
