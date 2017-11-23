"""
Description: Find grey matter borders for ground truth.
To be set:
   -path to parent directory,
   -subject names
Input:
   -grey matter ground truth files
Output:
   -grey matter ground truth borders
Written by: Marian Schneider, OF Gulban
"""

import os
import glob
from scipy.ndimage import morphology, generate_binary_structure
from nibabel import load, save, Nifti1Image

"""Load Data"""

parentpath = "/home/marian/gdrive/temp_segmentator_paper_data/MPRAGE"
lsSubj = ["S02", "S03", "S05", "S06", "S07"]

for subj in lsSubj:

    path = glob.glob(parentpath + "/" + subj + "/derived/01_ground_truth/" +
                     subj + "_gm_0?.nii.gz")[0]
    nii = load(path)
    basename = nii.get_filename().split(os.extsep, 1)[0]
    dirname = os.path.dirname(nii.get_filename())

    orig = nii.get_data()  # original data
    data = nii.get_data()

    # morphology structure
    struct = generate_binary_structure(3, 1)

    # find borders
    temp = morphology.binary_erosion(data, structure=struct, iterations=1)
    data = data*(1-temp)

    # save as nifti
    out = Nifti1Image(data, header=nii.header, affine=nii.affine)
    save(out, basename + "_borders.nii.gz")

    print path + '... done.'
