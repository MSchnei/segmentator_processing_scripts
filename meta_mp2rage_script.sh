#!/bin/bash

#### Description: This is a meta script to run all  MP2RAGE pipeline scripts
#### Written by: Marian Schneider, Faruk Gulban

# run scripts for set-up
bash b_00a_create_directory_tree.sh
bash b_00b_map_BIDS_to_analysis.sh

# run gramag scripts
bash b_01a_copy_uni.sh
bash b_01b_copy_cbs_segm.sh
bash b_02_brain_sub_mask.sh
bash b_03_correct_hdrs.sh
bash b_04a_cbs_extractGM_maskGM.sh
bash b_04_fast.sh
bash b_05_cbs_copyGM.sh
bash b_05_fast_copyGM.sh
bash b_06a_fast_ncut_prepare.sh
bash b_06b_fast_ncut_GUI.sh
bash b_07_cbs_apply_gramag_mask.sh
bash b_07_fast_apply_gramag_mask.sh

# run coda scripts
bash b_01_copy_uni_inv2.sh
bash b_02a_correct_hdrs_uni.sh
bash b_02b_reorient_T2s.sh
bash b_03_submask.sh
bash b_04_fast.sh
bash b_05_fast_rgb_to_v1v2.sh
bash b_06_fast_ncut_prepare.sh
bash b_07_fast_ncut_GUI.sh
bash b_08_cbs_apply_simplex_mask.sh
bash b_08_fast_apply_simplex_mask.sh

# run scripts for evaluation
python b_03a_find_gm_borders_segm.py
python b_03b_find_gm_borders_gt.py
bash b_04_all_mask_for_artifacts.sh
bash b_05a_all_evalseg_ovl.sh
bash b_05b_all_evalseg_dst.sh
bash b_06a_all_evalseg_ovl_artifact.sh
bash b_06b_all_evalseg_dst_artifact.sh
python b_07_all_evalute_segmentation.py
python b_07_all_evalute_segmentation_sep.py
