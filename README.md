[![DOI](https://zenodo.org/badge/104360271.svg)](https://zenodo.org/badge/latestdoi/104360271)

# segmentator_processing_scripts

This repository hosts code for the analysis of the following paper:

[A scalable method to improve gray matter segmentation at ultra high field MRI](https://www.biorxiv.org/content/early/2018/01/10/245738)


## Core dependencies
**[Python 2.7](https://www.python.org/download/releases/2.7/)**

| Package                                   | Tested version |
|-------------------------------------------|----------------|
| [NumPy](http://www.numpy.org/)            | 1.13.1         |
| [Scipy](https://www.scipy.org/)           | 0.19.1         |
| [NiBabel](http://nipy.org/nibabel/)       | 2.1.0          |
| [matplotlib](https://matplotlib.org/)     | 1.5.3          |
| [scikit-image](http://scikit-image.org)   | 0.13.1         |


## Analysis steps
Follow the following steps for the analysis

### Set up the environment

Note1: If the analysis is performed for the first time, first create the virtual environment by following the steps in the sections below before activating it.

Note2: In order to reproduce the SPM segmentation pipeline, unfortunately MATLAB and SPM currently still need to be installed. This might be replaced by a docker image in the future. We used MATLAB R2015b in combination with [SPM 12 r6472](http://www.fil.ion.ucl.ac.uk/spm/download/restricted/utopia/dev/spm12_r6472_Linux_R2015a.zip).

**activate virtual environment**
```
source activate env_segm_paper
```

**set parent path and evalseg path**
```
segm_path="/home/user/segmentator"
export segm_path
evalseg_path="/home/usr/EvaluateSegmentation/EvaluateSegmentation"
export evalseg_path
```

**create temporary alias for MATLAB**
```
alias MATLAB="/usr/local/MATLAB/R2015b/bin/glnxa64/MATLAB"
```

**set path to SPM tissue class file**
```
tissue_path="/home/usr/spm12/tpm/TPM.nii"
export tissue_path
```

### First time use: Set up folders and virtual environment for segmentator

**create folders for code, data and analysis**
```
mkdir -p ${segm_path}/code
mkdir -p ${segm_path}/data
mkdir -p ${segm_path}/analysis
```

**create conda environment**
```
conda create --name env_segm_paper python=2.7
source activate env_segm_paper
```

**clone and install segmentator software**
```
cd ${segm_path}/code
git clone https://github.com/ofgulban/segmentator.git
cd segmentator/
git fetch
git checkout paper
conda install pip
pip install -r requirements.txt
python setup.py install
```

**install special scikit-image dependency for n-cut functionality**
```
wget -P ${segm_path}/code/ "https://github.com/ofgulban/scikit-image/archive/segmentator_dependency.zip"
unzip ${segm_path}/code/segmentator_dependency.zip -d ${segm_path}/code/
rm -rf ${segm_path}/code/segmentator_dependency.zip
cd ${segm_path}/code/scikit-image-segmentator_dependency
pip install -r requirements.txt
python setup.py install
```

**install compoda package**
```
pip install compoda==0.3.0
```

**install python packages for tables and data frames**
```
conda install -c conda-forge xmltodict=0.11.0
conda install -c anaconda pandas=0.22.0
conda install -c conda-forge tabulate=0.8.2
 ```

### Download code and data
The data is provided in BIDS format. Code and data can be downloaded by running:

**download code and data**
```
wget -P ${segm_path}/code/ "https://github.com/MSchnei/segmentator_processing_scripts/archive/master.zip"
wget -P ${segm_path}/data/ "https://zenodo.org/record/1206163/files/shared_data.zip"
```

**unzip the downloaded folders**
```
unzip ${segm_path}/code/master.zip -d ${segm_path}/code/
unzip ${segm_path}/data/shared_data.zip -d ${segm_path}/data/
```

**remove zipped folders**
```
rm -rf ${segm_path}/code/master.zip
rm -rf ${segm_path}/data/shared_data.zip
```

**remove in-between folders**
```
mv ${segm_path}/code/segmentator_processing_scripts-master/* ${segm_path}/code/
rm -rf ${segm_path}/code/segmentator_processing_scripts-master/
```

### Create folder structure for analysis
To run the analysis, a particular directory tree is assumed.
The directory tree can be obtained by running the following two commands for the
MPRAGE and MP2RAGE data analysis, respectively:
```
bash ${segm_path}/code/MPRAGE/b_00a_create_directory_tree.sh
bash ${segm_path}/code/MP2RAGE/b_00a_create_directory_tree.sh
```
### Remap from BIDS format to analysis folder structure
Files can be transferred from BIDS format to the assumed structure by
```
bash ${segm_path}/code/MPRAGE/b_00b_map_BIDS_to_analysis.sh
bash ${segm_path}/code/MP2RAGE/b_00b_map_BIDS_to_analysis.sh
```

## Notes
The following folder tree is necessary for the MPRAGE analysis:
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
│   │   │   ├── fast
│   │   │   └── fast_restored_gramag
│   │   ├── 04_composition
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
