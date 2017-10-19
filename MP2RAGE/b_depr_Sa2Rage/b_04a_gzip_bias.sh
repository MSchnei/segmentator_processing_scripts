#!/bin/bash

#### Description: Zip bias-corrected images
#### To be set:
####    -path to parent directory,
####    -subject names
#### Input:
####    -path to folder with corrected but unzipped images
#### Output:
####    -zipped and corrected images
#### Written by: Marian Schneider - marian.schneider@maastrichtuniversity.nl

# set parent path
parentpath="/home/marian/gdrive/temp_segmentator_paper_data/MP2RAGE"

# list all subject names
declare -a app=(
					"S001"
					"S013"
					"S014"
					"S019"
                )

# zip images for all subjects
subjLen=${#app[@]}
for (( i=0; i<${subjLen}; i++ )); do
  subj=${app[i]}
	output="${parentpath}/${subj}/source/corr/"
	# cd
	echo "cd ${output}"
	cd ${output}
	# gzip
	command="gzip *"
	echo "${command}"
	${command}
done
