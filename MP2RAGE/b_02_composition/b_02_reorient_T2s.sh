#!/bin/sh

# this bash scripts helps to match headers between two files
# before you run this make sure that both the file_header_proper and the file_header_before have each been opened in itksnap and saved.

# give path to file with proper nii header (i.e. before transformations in BV)
file_header_proper="/home/faruk/gdrive/temp_segmentator_paper_data/MP2RAGE/S001/derived/02_composition/S001_uni_bet.nii.gz"

# give path to file with broken nii header (i.e. before transformations in BV) before correction
file_header_before="/home/faruk/gdrive/temp_segmentator_paper_data/MP2RAGE/S001/derived/02_composition/t2s/umpire_reslice.nii.gz"

# give path to file with broken nii header (i.e. before transformations in BV) after correction
file_header_after="/home/faruk/gdrive/temp_segmentator_paper_data/MP2RAGE/S001/derived/02_composition/t2s/umpire_reslice_reorient.nii.gz"

# fslorient -forceradiological ${file_header_before}
fslreorient2std ${file_header_before} ${file_header_after}

fslswapdim ${file_header_after} -x -y z ${file_header_after}

sformhdr=$(fslorient -getsform ${file_header_proper})
fslorient -setsform $sformhdr ${file_header_after}

qformhdr=$(fslorient -getqform ${file_header_proper})
fslorient -setqform $qformhdr ${file_header_after}

# Note: this is just an example script for a single subject file. This still needs to be batch scripted.
