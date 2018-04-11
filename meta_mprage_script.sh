#!/bin/bash

#### Description: This is a meta script to run all  MPRAGE pipeline scripts
#### Written by: Marian Schneider, Faruk Gulban

# run scripts for set-up
bash b_00a_create_directory_tree.sh
bash b_00b_map_BIDS_to_analysis.sh

# run gramag scripts
bash b_01_division.sh
bash b_02_fast_brainmask.sh
bash b_03_fast_submask.sh
bash b_04a_spm_gunzip.sh
bash b_04b_spm_create_batch_files.sh
bash b_04c_spm_run_batch_files.sh
python b_04d_spm_make_hard_labels.py
bash b_04e_spm_gzip_bias.sh
bash b_04_fast.sh
bash b_05a_spm_create_brainMask.sh
python b_05b_spm_open_brainMask.py
bash b_05c_spm_subtract_nosub_apply_brainMask.sh
bash b_05d_spm_copyGM_maskGM.sh
bash b_05_fast_copyGM.sh
bash b_06a_fast_ncut_prepare.sh
bash b_06a_spm_ncut_prepare.sh
bash b_06b_fast_ncut_GUI.sh
bash b_06b_spm_ncut_GUI.sh
bash b_07_fast_apply_gramag_mask.sh
bash b_07_spm_apply_gramag_mask.sh

# run coda scripts
bash b_01_submask.sh
bash b_02a_spm_gunzip.sh
python b_02b_spm_equalise_hdr.py
bash b_02c_spm_create_batch_files.sh
bash b_02d_spm_run_batch_files.sh
python b_02e_spm_make_hard_labels.py
bash b_02_fast.sh
bash b_02f_spm_gzip_bias.sh
bash b_03_fast_rgb_to_v1v2.sh
bash b_03_spm_rgb_to_v1v2.sh
bash b_04_fast_ncut_prepare.sh
bash b_04_spm_ncut_prepare.sh
bash b_05_fast_ncut_GUI.sh
bash b_05_spm_ncut_GUI.sh
bash b_06_fast_apply_simplex_mask.sh
bash b_06_spm_apply_simplex_mask.sh

# run scripts for evaluation
python b_03a_find_gm_borders_segm.py
python b_03b_find_gm_borders_gt.py
bash b_04_all_mask_for_artifacts.sh
bash b_05a_all_evalseg_ovl.sh
bash b_05b_all_evalseg_dst.sh
bash b_06a_all_evalseg_ovl_artifact.sh
bash b_06b_all_evalseg_dst_artifact.sh
python b_07_all_evalute_segmentation_sep.py
