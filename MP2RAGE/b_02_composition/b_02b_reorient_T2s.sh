#!/bin/bash

#### Description: Reorient t2s to match cbs-reoriented uni image
#### To be set:
####    -path to parent directory,
####    -subject names
#### Input:
####    -t2s image in original orientation
#### Output:
####    -t2s image in reoriented cbs orientation
#### Written by: Marian Schneider, Faruk Gulban

# set parent path
parent_path="${segm_path}/analysis/MP2RAGE"

# list all subject names
declare -a app=(
				"S001"
        "S013"
        "S014"
        "S019"
                )

# mask all images with brain mask
subjLen=${#app[@]}
for (( i=0; i<${subjLen}; i++ )); do
	# derive particular subject name
  subj=${app[i]}
  # give path to file with proper nii header
  file_header_proper="${parent_path}/${subj}/derived/04_composition/${subj}_uni.nii.gz"
  # give path to file with broken nii header after correction
  file_header_broken="${parent_path}/${subj}/derived/04_composition/${subj}_t2s.nii.gz"
  # fslorient -forceradiological ${file_header_broken}
  fslreorient2std ${file_header_broken} ${file_header_broken}
  fslswapdim ${file_header_broken} -x -y z ${file_header_broken}
  sformhdr=$(fslorient -getsform ${file_header_proper})
  fslorient -setsform $sformhdr ${file_header_broken}
  qformhdr=$(fslorient -getqform ${file_header_proper})
  fslorient -setqform $qformhdr ${file_header_broken}
done
