[![DOI](https://zenodo.org/badge/104360271.svg)](https://zenodo.org/badge/latestdoi/104360271)

# segmentator_processing_scripts

This repository hosts the code used to process the data for the Segmentator paper.


## Analysis steps
Follow the following steps for the analysis

### Run meta script to set the environment paths


### Download the data
The data is provided in BIDS format. It can be downloaded by running
`wget  -O /home/user/segmentator/data "https://zenodo.org/record/1117859/files/segmentator_shared_data.zip"`

### Create folder structure for analysis

### Remap from BIDS fromat to analysis folder structure



## Notes
To run the analysis, a particular directory tree is assumed.
The directory tree can be obtained by running the following two commands for the
MPRAGE and MP2RAGE data analysis, respectively:

```
bash /home/user/segmentator/code/b_00_create_directory_tree_mprage.sh
bash /home/user/segmentator/code/b_00_create_directory_tree_mp2rage.sh
```

This should result in the following folder tree for the MPRAGE analysis:
 >/home/user/segmentator/analysis/MPRAGE/
├── S02
│   ├── derived
│   │   ├── 00_BV
│   │   ├── 01_ground_truth
│   │   ├── 02_masks
│   │   ├── 03_division
│   │   │   ├── fast
│   │   │   ├── spm
│   │   ├── 04_composition
│   │   │   ├── fast_T1_PD_T2s
│   │   │   └── spm_T1_PD_T2s
│   │   ├── 05_gm
│   │   ├── 06_gm_artifact_masked
│   │   ├── 07_evaluation
│   │   ├── 08_evaluation_artifact_masked
│   │   └── 09_ground_truth_check
│   └── source
├── S03
│   ├── derived
│   └── source
└── ...

And this folder tree for the MP2RAGE analysis:
>/home/user/segmentator/analysis/MP2RAGE/
├── S001
│   ├── derived
│   │   ├── 01_ground_truth
│   │   ├── 02_masks
│   │   ├── 03_uni
│   │   │   ├── cbs
│   │   │   │   └── exp-0000
│   │   │   ├── fast
│   │   │   └── fast_restored_gramag
│   │   ├── 04_composition
│   │   │   └── 00_compute_t2s
│   │   ├── 05_gm
│   │   ├── 06_gm_artifact_masked
│   │   ├── 07_evaluation
│   │   └── 08_evaluation_artifact_masked
│   └── source
│       └── corr
├── S013
│   ├── derived
│   └── source
└── ...
