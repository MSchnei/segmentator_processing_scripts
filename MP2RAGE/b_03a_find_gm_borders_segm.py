"""

Description: Find grey matter borders for GM segmentations.
To be set:
   -path to parent directory,
   -subject names
   -list of grey matter segmentations
Input:
   -grey matter segmentations
Output:
   -grey matter segmentation borders
Written by: Marian Schneider, Faruk Gulban
"""

import os
from scipy.ndimage import morphology, generate_binary_structure
from nibabel import load, save, Nifti1Image

"""Load Data"""

parent_path = str(os.environ['segm_path']) + "/analysis/MP2RAGE"
lsSubj = ["S001", "S013", "S014", "S019"]
lsGM = ["_uni_fast_gm", "_uni_fast_gm_gramag",
        "_uni_fast_gm_simplex", "_uni_cbs_gm",
        "_uni_cbs_gm_gramag", "_uni_cbs_gm_simplex"]

for subj in lsSubj:
    for gm in lsGM:
        path = parent_path + "/" + subj + "/derived/05_gm/" + subj + gm
        nii = load(path + ".nii.gz")
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
