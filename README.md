[![DOI](https://zenodo.org/badge/104360271.svg)](https://zenodo.org/badge/latestdoi/104360271)

# segmentator_processing_scripts

This repository hosts the code used to process the data for the Segmentator paper.


## Analysis steps
Follow the following steps for the analysis

### Set up the environment
```
# set parent path
parent_path="/home/user/segmentator/"
export parent_path

# create folders for code, data and analysis
mkdir -p ${parent_path}/code
mkdir -p ${parent_path}/data
mkdir -p ${parent_path}/analysis

# create aliases for MATLAB and evalseg

```

If this needs to be repeated at a later stage, run 


### Download code and data
The data is provided in BIDS format.
Code and data can be downloaded by running:
```
wget -P ${parent_path}/code/ "https://github.com/MSchnei/segmentator_processing_scripts/archive/master.zip"
wget -P ${parent_path}/data/ "https://zenodo.org/record/1117859/files/segmentator_shared_data.zip"
```
### Create folder structure for analysis

### Remap from BIDS fromat to analysis folder structure



## Notes
To run the analysis, a particular directory tree is assumed.
The directory tree can be obtained by running the following two commands for the
MPRAGE and MP2RAGE data analysis, respectively:

```
bash ${parent_path}/code/b_00_create_directory_tree_mprage.sh
bash ${parent_path}/code/b_00_create_directory_tree_mp2rage.sh
```

This should result in the following folder tree for the MPRAGE analysis:
```
/home/user/segmentator/analysis/MPRAGE/
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
```

And this folder tree for the MP2RAGE analysis:
```
/home/user/segmentator/analysis/MP2RAGE/
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
```
