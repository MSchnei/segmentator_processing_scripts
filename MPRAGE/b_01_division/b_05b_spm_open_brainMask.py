"""
Description: Open SPM brain mask with a morphology operation
To be set:
   -path to parent directory,
   -subject names
Input:
   -spm brain mask
Output:
   -opened spm brain mask
Written by: Marian Schneider, Faruk Gulban

"""

import os
from scipy.ndimage import morphology
from nibabel import load, save, Nifti1Image

parent_path = str(os.environ['segm_path']) + "/analysis/MPRAGE"
lsSubj = ["S02", "S03", "S05", "S06", "S07"]

# loop through subjects
for subj in lsSubj:
    filename = (parent_path + "/" + subj +
                "/derived/03_division/spm/spm_brain_mask.nii.gz")
    # load data
    nii = load(filename)
    basename = nii.get_filename().split(os.extsep, 1)[0]
    dirname = os.path.dirname(nii.get_filename())
    data = nii.get_data()

    # perform opening
    data = morphology.binary_erosion(data, iterations=1)
    data = morphology.binary_dilation(data, iterations=1)

    # save as nifti
    out = Nifti1Image(data, header=nii.header, affine=nii.affine)
    save(out, basename + "_open.nii.gz")

    print('Morphology operations ' + subj + ' ...done')
