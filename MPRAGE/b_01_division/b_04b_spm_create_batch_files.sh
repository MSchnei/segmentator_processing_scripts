#!/bin/bash

#### Description: Create *.m files for spm segmentation
#### To be set:
####    -path to parent directory,
####    -path to spm tissue types,
####    -subject names
#### Input:
####    -none, this is just preparation
#### Output:
####    -none yet, this is just preparation
#### Written by: Marian Schneider - marian.schneider@maastrichtuniversity.nl

# set parent path
parentpath="/home/marian/gdrive/temp_segmentator_paper_data/MPRAGE"
tissuepath="/home/marian/Documents/spm12/tpm/TPM.nii"

# list all subject names
declare -a app=(
				"S02"
        "S03"
        "S05"
        "S06"
        "S07"
                )

# create *.m files for spm segmentation for all subjects
subjLen=${#app[@]}
for (( i=0; i<${subjLen}; i++ )); do
  subj=${app[i]}
  pathTextFile="${parentpath}/${subj}/derived/03_division/spm/spm_div.m"
  input="${parentpath}/${subj}/derived/03_division/spm/${subj}_T1wDivPD.nii"

  # check whether text file exists already
  if [ -e ${pathTextFile} ]; then
    echo "File ${pathTextFile} already exists!"
  # if it doesnt exist yet, create it
  else
    echo "create ${pathTextFile}"
    touch ${pathTextFile}

    echo "% Initialise jobs configuration
spm_jobman('initcfg')

% clear old batches
clear matlabbatch

% define content of the batch
% channels
matlabbatch{1}.spm.spatial.preproc.channel.vols = {'${input},1'};
matlabbatch{1}.spm.spatial.preproc.channel.biasreg = 0.001;
matlabbatch{1}.spm.spatial.preproc.channel.biasfwhm = 60;
matlabbatch{1}.spm.spatial.preproc.channel.write = [0 1];

% tissues
matlabbatch{1}.spm.spatial.preproc.tissue(1).tpm = {'${tissuepath},1'};
matlabbatch{1}.spm.spatial.preproc.tissue(1).ngaus = 3;
matlabbatch{1}.spm.spatial.preproc.tissue(1).native = [1 0];
matlabbatch{1}.spm.spatial.preproc.tissue(1).warped = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(2).tpm = {'${tissuepath},2'};
matlabbatch{1}.spm.spatial.preproc.tissue(2).ngaus = 2;
matlabbatch{1}.spm.spatial.preproc.tissue(2).native = [1 0];
matlabbatch{1}.spm.spatial.preproc.tissue(2).warped = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(3).tpm = {'${tissuepath},3'};
matlabbatch{1}.spm.spatial.preproc.tissue(3).ngaus = 2;
matlabbatch{1}.spm.spatial.preproc.tissue(3).native = [1 0];
matlabbatch{1}.spm.spatial.preproc.tissue(3).warped = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(4).tpm = {'${tissuepath},4'};
matlabbatch{1}.spm.spatial.preproc.tissue(4).ngaus = 3;
matlabbatch{1}.spm.spatial.preproc.tissue(4).native = [1 0];
matlabbatch{1}.spm.spatial.preproc.tissue(4).warped = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(5).tpm = {'${tissuepath},5'};
matlabbatch{1}.spm.spatial.preproc.tissue(5).ngaus = 4;
matlabbatch{1}.spm.spatial.preproc.tissue(5).native = [1 0];
matlabbatch{1}.spm.spatial.preproc.tissue(5).warped = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(6).tpm = {'${tissuepath},6'};
matlabbatch{1}.spm.spatial.preproc.tissue(6).ngaus = 2;
matlabbatch{1}.spm.spatial.preproc.tissue(6).native = [1 0];
matlabbatch{1}.spm.spatial.preproc.tissue(6).warped = [0 0];
% warping
matlabbatch{1}.spm.spatial.preproc.warp.mrf = 1;
matlabbatch{1}.spm.spatial.preproc.warp.cleanup = 1;
matlabbatch{1}.spm.spatial.preproc.warp.reg = [0 0.001 0.5 0.05 0.2];
matlabbatch{1}.spm.spatial.preproc.warp.affreg = 'mni';
matlabbatch{1}.spm.spatial.preproc.warp.fwhm = 0;
matlabbatch{1}.spm.spatial.preproc.warp.samp = 3;
matlabbatch{1}.spm.spatial.preproc.warp.write = [0 0];


% run batch operations defined above
spm_jobman('run', matlabbatch);

disp('done');

exit;" >> ${pathTextFile}

  fi

done
