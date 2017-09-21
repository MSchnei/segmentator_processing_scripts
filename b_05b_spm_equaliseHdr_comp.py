# -*- coding: utf-8 -*-

"""
Created on Mon Apr  3 15:59:13 2017

@author: marian
"""

import os
from nibabel import load, save, Nifti1Image

parentpath = "/home/marian/gdrive/temp_segmentator_paper_data/MPRAGE"

lsSubj = ["S02", "S03", "S05", "S06", "S07"]
lsContr = ["T1w", "PD", "T2s"]

#
for subj in lsSubj:
    for ind, contr in enumerate(lsContr):
        filename = (parentpath + "/" + subj +
                    "/derived/04_composition/spm_T1_PD_T2s/" + subj + "_" +
                    contr + ".nii")
        print filename
        nii = load(filename)
        basename = nii.get_filename().split(os.extsep, 1)[0]

        if ind == 0:
            varNiiHeader = nii.header
            varNiiAffine = nii.affine

        data = nii.get_data()

        # save as nifti
        out = Nifti1Image(data, header=varNiiHeader, affine=varNiiAffine)
        save(out, basename + "_eq.nii")
        os.remove(filename)
        print "... changed"
