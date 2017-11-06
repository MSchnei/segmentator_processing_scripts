#!/bin/bash

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
	  truth="${parentpath}/${subj}/derived/01_ground_truth/${subj}_gm_0?.nii.gz"
	  # loop throuh different segmentation results
	  for (( i=0; i<${tLen}; i++ )); do
	    # deduce name for segmentation result file
	    segm="${parentpath}/${subj}/derived/05_gm/${subj}_uni_${switch}_gm${res[i]}.nii.gz"
	    # evaluate the segmentation
	    command="${evalseg} ${truth} ${segm} "
	    command+="-use DICE,SNSVTY,SPCFTY,ACURCY,PRCISON "
	    command+="-xml ${parentpath}/${subj}/derived/07_evaluation/${switch}${res[i]}_ovl.xml"
	    echo "${command}"
	    ${command}
	  done
	done
done
