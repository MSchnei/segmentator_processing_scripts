#!/bin/bash

#### Description: Get overlap-based metrics for segmentations
#### To be set:
####    -path to parent directory,
####    -path to EvaluateSegmentation tool
####    -list with programme names for initial GM segmentation
#### Input:
####    -grey matter segmentations
#### Output:
####    -overlap-based metrics for GM segmentations
#### Written by: Marian Schneider, Faruk Gulban

# set parent path
parent_path="${segm_path}/analysis/MP2RAGE"

# set path to evaluate segmentation (visceral project) executable
evalseg_path="${evalseg_path}"

# specify which segmentation results should be evaluated
declare -a programme=(
	"cbs"
	"fast"
	)

# list all subject names
declare -a app=(
				"S001"
				"S013"
				"S014"
				"S019"
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
	  truth="${parent_path}/${subj}/derived/01_ground_truth/${subj}_gm_0?.nii.gz"
	  # loop throuh different segmentation results
	  for (( i=0; i<${tLen}; i++ )); do
	    # deduce name for segmentation result file
	    segm="${parent_path}/${subj}/derived/05_gm/${subj}_uni_${switch}_gm${res[i]}.nii.gz"
	    # evaluate the segmentation
	    command="${evalseg_path} ${truth} ${segm} "
	    command+="-use DICE,SNSVTY,SPCFTY,ACURCY,PRCISON "
	    command+="-xml ${parent_path}/${subj}/derived/07_evaluation/${switch}${res[i]}_ovl.xml"
	    echo "${command}"
	    ${command}
	  done
	done
done
