# -*- coding: utf-8 -*-

"""
Description: Convert bias corrected matlab output B1 to nifti.

To be set:
   -path to parent directory,
   -subject names
Input:
   -path to b1 matlab output
   -path to nii image with correct header (here t1_corr)
Output:
   -corrected b1 nii file
Written by: Faruk Gulban, Marian Schneider
"""

import os
from nibabel import load, Nifti1Image, save
from scipy.io import loadmat

# set parent path
parentpath = "/home/marian/gdrive/temp_segmentator_paper_data/MP2RAGE"
# list all subject names
lsSubj = ["S001", "S013", "S014", "S019"]

# loop through subjects
for subj in lsSubj:
    # read matlab script output B1 field image
    mat_file = parentpath + "/" + subj + "/source/corr/b1_corr.mat"
    mat = loadmat(mat_file)
    b1 = mat['B1corr'][0][0][0]

    # read B1 corrected image output from matlab
    nii = load(parentpath + "/" + subj + "/source/corr/t1_corr.nii")

    # save B1 field
    img = Nifti1Image(b1, header=nii.header, affine=nii.affine)
    outname = parentpath + "/" + subj + "/source/corr/b1_corr.nii.gz"
    save(img, outname)
    print "Created: " + outname
    os.remove(mat_file)
    print "Deleted: " + mat_file
