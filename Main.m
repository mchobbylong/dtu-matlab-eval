function Main(datasetName)
    dataPath='D:\dtu_matlab_eval\dtu_matlab_eval';
    plyPath=['D:\dtu_matlab_eval\' datasetName '\points'];
    resultsPath=['D:\dtu_matlab_eval\' datasetName '\results\'];
    
    BaseEvalMain_web(dataPath, plyPath, resultsPath);
    ComputeStat_web(resultsPath);
end
