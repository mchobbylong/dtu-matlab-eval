clear all
close all
format compact
clc

% script to calculate the statistics for each scan given this will currently only run if distances have been measured
% for all included scans (UsedSets)

% modify the path to evaluate your models
resultsPath='D:\models\dtu_matlab_eval\caspl_pfused_1280x960\results\';

MaxDist=20; %outlier thresshold of 20 mm

time=clock;

method_string='';
representation_string='Points'; %mvs representation 'Points' or 'Surfaces'

switch representation_string
    case 'Points'
        eval_string='_Eval_'; %results naming
        settings_string='';
end

% get sets used in evaluation
UsedSets=[1 4 9 10 11 12 13 15 23 24 29 32 33 34 48 49 62 75 77 110 114 118];

nStat=length(UsedSets);

nStl=zeros(1,nStat);
nData=zeros(1,nStat);
MeanStl=zeros(1,nStat);
MeanData=zeros(1,nStat);
VarStl=zeros(1,nStat);
VarData=zeros(1,nStat);
MedStl=zeros(1,nStat);
MedData=zeros(1,nStat);

parfor cStat=1:length(UsedSets) %Data set number
    
    currentSet=UsedSets(cStat);
    
    %input results name
    EvalName=[resultsPath method_string eval_string num2str(currentSet) '.mat'];
    
    disp(EvalName);
    BaseEval=ParLoad(EvalName);
    
    Dstl=BaseEval.Dstl(BaseEval.StlAbovePlane); %use only points that are above the plane 
    Dstl=Dstl(Dstl<MaxDist); % discard outliers
    
    Ddata=BaseEval.Ddata(BaseEval.DataInMask); %use only points that within mask
    Ddata=Ddata(Ddata<MaxDist); % discard outliers
    
    nStl(cStat)=length(Dstl);
    nData(cStat)=length(Ddata);
    
    MeanStl(cStat)=mean(Dstl);
    MeanData(cStat)=mean(Ddata);
    
    VarStl(cStat)=var(Dstl);
    VarData(cStat)=var(Ddata);
    
    MedStl(cStat)=median(Dstl);
    MedData(cStat)=median(Ddata);
    
    disp("acc");
    disp(mean(Ddata));
    disp("comp");
    disp(mean(Dstl));
    time=clock;
end

BaseStat.nStl=nStl;
BaseStat.nData=nData;
BaseStat.MeanStl=MeanStl;
BaseStat.MeanData=MeanData;
BaseStat.VarStl=VarStl;
BaseStat.VarData=VarData;
BaseStat.MedStl=MedStl;
BaseStat.MedData=MedData;

disp(BaseStat);
disp("mean acc")
disp(mean(MeanData));
disp("mean comp")
disp(mean(MeanStl));

totalStatName=[resultsPath 'TotalStat_' method_string eval_string '.mat']
save(totalStatName,'BaseStat','time','MaxDist');



