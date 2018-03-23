#!/bin/bash

#### Description: Get distance-based metrics for segmentations
#### To be set:
####    -path to parent directory,
####    -path to EvaluateSegmentation tool
####    -list with programme names for initial GM segmentation
#### Input:
####    -grey matter segmentations
#### Output:
####    -distance-based metrics for GM segmentations
#### Written by: Marian Schneider, Faruk Gulban

# set path to folder with the validation data
parent_path="${segm_path}/analysis/MPRAGE"

# set path to evaluate segmentation (visceral project) executable
evalseg=${evalseg_path}

# specify which segmentation results should be evaluated
declare -a programme=(
	"spm"
	"fast"
	)

# list all subject names
declare -a app=(
				"S02"
        "S03"
        "S05"
        "S06"
        "S07"
        )

# set segmentation labels
declare -a res=(
				""
        "_gramag"
        "_simplex"
        )

subjLen=${#app[@]}
tLen=${#res[@]}
switchLen=${#programme[@]}

for (( k=0; k<${switchLen}; k++ )); do
	# deduce programme name
	switch=${programme[k]}
	for (( j=0; j<${subjLen}; j++ )); do
	  # deduce subject name
	  subj=${app[j]}
	  # deduce path name for ground truth
	  truth="${parent_path}/${subj}/derived/01_ground_truth/${subj}_gm_0?_borders.nii.gz"
	  # loop throuh different segmentation results
	  for (( i=0; i<${tLen}; i++ )); do
	    # deduce name for segmentation result file
	    segm="${parent_path}/${subj}/derived/05_gm/${subj}_division_${switch}_gm${res[i]}_borders.nii.gz"
	    # evaluate the segmentation
	    command="${evalseg} ${truth} ${segm} "
	    command+="-use AVGDIST "
	    command+="-xml ${parent_path}/${subj}/derived/07_evaluation/${switch}${res[i]}_dst.xml"
	    echo "${command}"
	    ${command}
	  done
	done
done
