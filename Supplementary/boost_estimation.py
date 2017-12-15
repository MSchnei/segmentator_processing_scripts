"""Compute approximate time savings using Segmentator.

The boost is estimated in comparison to the manual slice-by-slice correction of
automatic segmentation mistakes.
"""

import numpy as np
from nibabel import load


# ground truth
gt = load("/path/to/S019_gm_07_artifact_masked.nii.gz")
# automatic segmentation process output (eg. fsl-fast, cbs-tools, spm)
nii_1 = load("/path/to/S019_uni_cbs_gm_artifact_masked.nii.gz")
# gray matter labels after using segmentator
nii_2 = load("/path/to/S019_uni_cbs_gm_gramag_artifact_masked.nii.gz")

# -----------------------------------------------------------------------------
gt = gt.get_data()
nii_1 = nii_1.get_data()
nii_2 = nii_2.get_data()

print("Ground truth GM: %i voxels" % (np.sum(gt)))

gt_inv = -gt + 1
nii_1_inv = -nii_1 + 1
nii_2_inv = -nii_2 + 1

nr_hits_before = np.sum(gt*nii_1)
nr_hits_after = np.sum(gt*nii_2)
nr_hits_difference = nr_hits_before - nr_hits_after

nr_FP_before = np.sum(gt_inv*nii_1)
nr_FP_after = np.sum(gt_inv*nii_2)
nr_FP_difference = nr_FP_before - nr_FP_after

nr_FN_before = np.sum(gt * nii_1_inv)
nr_FN_after = np.sum(gt * nii_2_inv)

print("FP + FN before segmentator: %i voxels" % (nr_FP_before + nr_FN_before))

nr_hits_before / (nr_hits_before + nr_FP_before)
nr_of_voxels_benefit = nr_FP_difference - nr_hits_difference

# assumed nr of voxels per second on average that can be corrected manually by
# a human operator (eg. a poor phd student)
voxels_per_second = 1

# convert to human readable time
time_benefit = (nr_of_voxels_benefit * voxels_per_second) / 3600
print("Boost estimation: %i voxels" % nr_of_voxels_benefit)
print("Boost estimation: %i hours" % time_benefit)
