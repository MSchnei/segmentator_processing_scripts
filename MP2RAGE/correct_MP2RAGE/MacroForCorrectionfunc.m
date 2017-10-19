function [MP2RAGEcorr,T1wrongcorr] = MacroForCorrectionfunc(b1map_input, mp2rage_input,subdir)

%% Ask for file location
%disp('Pick your Sa2RAGE B1 map')
%[B1map,PathName] = uigetfile({'*.nii';'*.nii.gz'},'Select the nifti file');

[B1map] = b1map_input;
cd(subdir)

%disp('Pick your MP2RAGE UNI')
%[UNI,PathName] = uigetfile({'*.nii';'*.nii.gz'},'Select the nifti file');

[UNI] = mp2rage_input;

%% loads the Sa2RAGE (from 8/4/2015 on)
    Sa2RAGE.TR=2.4;
    Sa2RAGE.TRFLASH=2.2e-3;
    Sa2RAGE.TIs=[58e-3 1800e-3];
    Sa2RAGE.NZslices=[18.67 29.33] % 128 * [0.75-0.5  0.5]/3+[24/2 24/2]*(1-1/3 )
    Sa2RAGE.FlipDegrees=[4 10];
    Sa2RAGE.averageT1=1.5;
    Sa2RAGE.B1filename=B1map;
    B1=load_untouch_nii(Sa2RAGE.B1filename)
    
    
%% loads the MP2RAGE dataset 
    
    MP2RAGE.B0=7;
    MP2RAGE.TR=5;
    MP2RAGE.TRFLASH=6.9e-3;
    MP2RAGE.TIs=[900e-3 2750e-3];
    MP2RAGE.NZslices=[120 120];% Slices Per Slab * [PartialFourierInSlice-0.5  0.5]
    MP2RAGE.FlipDegrees=[5 3];
    MP2RAGE.averageB1=1;
    MP2RAGE.filename=UNI;
    MP2RAGEimg=load_untouch_nii(MP2RAGE.filename);
    
    
    
%% performing the correction    
    [ B1corr T1wrongcorr MP2RAGEcorr] = T1B1correctpackage( [],B1,Sa2RAGE,MP2RAGEimg,[],MP2RAGE,[],0.96)
    %% saving the data
    save_untouch_nii(MP2RAGEcorr, 'uni_corr.nii')
    save_untouch_nii(T1wrongcorr, 't1_corr.nii')
    save('b1_corr.mat', 'B1corr')  

    