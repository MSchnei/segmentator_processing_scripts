#!/bin/bash

#### Description: Get distance-based metrics for artifact-masked segmentations
#### To be set:
####    -path to parent directory,
####    -path to EvaluateSegmentation tool
####    -list with programme names for initial GM segmentation
#### Input:
####    -artifact-masked grey matter segmentations
#### Output:
####    -distance-based metrics for artifact-masked GM segmentations
#### Written by: Marian Schneider - marian.schneider@maastrichtuniversity.nl

# set path to folder with the validation data
parentpath="/home/marian/gdrive/temp_segmentator_paper_data/MP2RAGE"

# set path to evaluate segmentation (visceral project) executable
evalseg='/home/marian/EvaluateSegmentation/EvaluateSegmentation'

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
		truth="${parentpath}/${subj}/derived/01_ground_truth/${subj}_gm_0?_borders_artifact_masked.nii.gz"
	  # loop throuh different segmentation results
	  for (( i=0; i<${tLen}; i++ )); do
	    # deduce name for segmentation result file
			segm="${parentpath}/${subj}/derived/06_gm_artifact_masked/${subj}_uni_${switch}_gm${res[i]}_borders_artifact_masked.nii.gz"
	    # evaluate the segmentation
	    command="${evalseg} ${truth} ${segm} "
	    command+="-use AVGDIST "
			command+="-xml ${parentpath}/${subj}/derived/08_evaluation_artifact_masked/${switch}_artifact_masked${res[i]}_dst.xml"
	    echo "${command}"
	    ${command}
	  done
	done
done
