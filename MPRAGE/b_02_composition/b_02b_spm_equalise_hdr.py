# -*- coding: utf-8 -*-

"""
Description: Equalise headers for T1w, PD, T2s images for spm segmentation
To be set:
    -path to parent directory,
    -subject names
    -contrast names T1w, PD, T2s
Input:
    -T1w.nii for all subjects
    -PD.nii for all subjects
    -T2s.nii for all subjects
Output:
    -T1w_eq.nii for all subjects
    -PD_eq.nii for all subjects
    -T2s_eq.nii for all subjects
Written by: Marian Schneider, Faruk Gulban
"""

import os
from nibabel import load, save, Nifti1Image

parent_path = str(os.environ['segm_path']) + "/analysis/MPRAGE"

lsSubj = ["S02", "S03", "S05", "S06", "S07"]
lsContr = ["T1w", "PD", "T2s"]

#
for subj in lsSubj:
    for ind, contr in enumerate(lsContr):
        filename = (parent_path + "/" + subj +
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
