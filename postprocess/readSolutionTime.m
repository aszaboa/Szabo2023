function solutionTimes = readSolutionTime(fnameIn)

fID = fopen(fnameIn,'r');

while ~feof(fID)
    fl = fgetl(fID);
    if contains(fl,'Summary of Stages')
%         obj.readNLPSEstages(fID);


        fgetl(fID);
        fl = fgetl(fID); 
        nStage=0;

        while length(fl)>2

            fl = fl(22:end);
            fl(fl=='%') = [];
            singleStageData = str2num(fl);

            if nStage==0
                stageMat = zeros(0,length(singleStageData));
            end
            
            stageMat(end+1,:) = singleStageData;
            fl = fgetl(fID); 
        end

        solutionTimes = stageMat(:,1);
        break;


    end
end
fclose(fID);

end