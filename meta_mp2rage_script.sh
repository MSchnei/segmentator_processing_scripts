#!/bin/bash

#### Description: This is a meta script to run all  MP2RAGE pipeline scripts
#### Written by: Marian Schneider, Faruk Gulban

# run scripts for set-up
b_00a_create_directory_tree.sh
b_00b_map_BIDS_to_analysis.sh

# run gramag scripts
b_01a_copy_uni.sh
b_01b_copy_cbs_segm.sh
b_02_brain_sub_mask.sh
b_03_correct_hdrs.sh
b_04a_cbs_extractGM_maskGM.sh
b_04_fast.sh
b_05_cbs_copyGM.sh
b_05_fast_copyGM.sh
b_06a_fast_ncut_prepare.sh
b_06b_fast_ncut_GUI.sh
b_07_cbs_apply_gramag_mask.sh
b_07_fast_apply_gramag_mask.sh

# run coda scripts
b_01_copy_uni_inv2.sh
b_02a_correct_hdrs_uni.sh
b_02b_reorient_T2s.sh
b_03_submask.sh
b_04_fast.sh
b_05_fast_rgb_to_v1v2.sh
b_06_fast_ncut_prepare.sh
b_07_fast_ncut_GUI.sh
b_08_cbs_apply_simplex_mask.sh
b_08_fast_apply_simplex_mask.sh

# run scripts for evaluation
b_03a_find_gm_borders_segm.py
b_03b_find_gm_borders_gt.py
b_04_all_mask_for_artifacts.sh
b_05a_all_evalseg_ovl.sh
b_05b_all_evalseg_dst.sh
b_06a_all_evalseg_ovl_artifact.sh
b_06b_all_evalseg_dst_artifact.sh
b_07_all_evalute_segmentation.py
b_07_all_evalute_segmentation_sep.py
