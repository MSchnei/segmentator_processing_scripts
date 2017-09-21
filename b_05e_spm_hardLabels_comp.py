# -*- coding: utf-8 -*-

"""
Created on Mon Apr  3 15:59:13 2017

@author: marian
"""

import os
import numpy as np
from nibabel import load, save, Nifti1Image

parentpath = "/home/marian/gdrive/temp_segmentator_paper_data/MPRAGE"

lsSubj = ["S02", "S03", "S05", "S06", "S07"]
varNrInputs = 6

# loop through subjects
for subj in lsSubj:
    # %% load all files and put them in list
    data = []
    for ind in range(0, varNrInputs):
        filename = (parentpath + "/" + subj +
                    "/derived/04_composition/spm_T1_PD_T2s/c" + str(ind+1) +
                    subj + "_T1w_eq.nii")
        nii = load(filename)
        data.append(nii.get_data().reshape((nii.shape + (1,))))

    # %% find maximum prob across all files
    data = np.concatenate((data), axis=3)
    # for which tissue probability class do we get the highest probability?
    maxPos = np.argmax(data, axis=3)

    # %% assign 1 if that tissue class had highest prob in the voxel, save
    for ind in range(0, varNrInputs):
        filename = (parentpath + "/" + subj +
                    "/derived/04_composition/spm_T1_PD_T2s/c" + str(ind+1) +
                    subj + "_T1w_eq.nii")
        nii = load(filename)
        aryTemp = np.zeros((nii.shape))
        aryTemp[maxPos == ind] = 1
        basename = nii.get_filename().split(os.extsep, 1)[0]
        # save as nifti
        out = Nifti1Image(aryTemp, header=nii.header, affine=nii.affine)
        save(out, basename + "_max.nii.gz")
        os.remove(filename)
        print "... changed"
