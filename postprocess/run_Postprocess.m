clear
close all
clc


%% initial variables 

resDir = '../results';
baseName = {'directSolver','iterSolver'};

npVec = [60 80 100 120 160 200 240 280 320 360 400 440 480].';
npVec_P3 = [38 50 63 75 100 125 150 175 200 225 250 275 300].';

nDOF = 5*npVec+3;
nDOF_P3 = 8*npVec_P3+3;

nCase = 5;
Re0 = 400;

Ni = length(baseName);
Nj = length(npVec);


%% reading the solution time 

TimeMat = zeros(Ni,Nj,nCase,4);
TimeMat_P3= zeros(Ni,Nj,nCase,4);
for i = 1:Ni
    for j = 1:Nj
        for k = 1:nCase
            TimeMat(i,j,k,:) = readSolutionTime([resDir,'/',baseName{i},'_',num2str(j-1),'_',num2str(k-1),'.out']);
            TimeMat_P3(i,j,k,:) = readSolutionTime([resDir,'/',baseName{i},'_',num2str(j-1),'_',num2str(k-1),'_P3.out']);
        end
    end
end

% Main(rest), RHS, Matrix, LinEq -> reversed 
TimeMat = TimeMat(:,:,:,4:-1:1);
TimeMat_P3 = TimeMat_P3(:,:,:,4:-1:1);

% averaging 
TimeMat_Mean = squeeze(mean(TimeMat,3));
TimeMat_Mean_P3 = squeeze(mean(TimeMat_P3,3));


%% plotting the results 

MarkerCell = {'s','o','^','v','d','>','<'};
ColorMat = [...
    0 0.4470 0.7410; ...
    0.8500 0.3250 0.0980; ...
    0.9290 0.6940 0.1250; ...
    0.4940 0.1840 0.5560; ...
    0.4660 0.6740 0.1880; ...
    0.3010 0.7450 0.9330; ...
    0.6350 0.0780 0.1840 ...
    ];

lw = 0.9; 
PaperUnits = 'centimeter';
fs = 8;
px = 7.5; 
py = 5.0;

figure;
plot(nDOF,squeeze(TimeMat_Mean(1,:,1)),'LineStyle','-','Marker',MarkerCell{1},'Color',ColorMat(1,:),'LineWidth',lw);
hold on;
plot(nDOF,squeeze(TimeMat_Mean(2,:,1)),'LineStyle','-','Marker',MarkerCell{2},'Color',ColorMat(2,:),'LineWidth',lw);

plot(nDOF_P3,squeeze(TimeMat_Mean_P3(1,:,1)),'LineStyle','--','Marker',MarkerCell{1},'Color',ColorMat(1,:),'LineWidth',lw);
plot(nDOF_P3,squeeze(TimeMat_Mean_P3(2,:,1)),'LineStyle','--','Marker',MarkerCell{2},'Color',ColorMat(2,:),'LineWidth',lw);

ah.FontSize = fs;
xlabel('$\mathrm{nDOF}$','Interpreter','latex','FontSize',fs)
ylabel('$\mathrm{t}~(\mathrm{s})$','Interpreter','latex','FontSize',fs)
legend({'LU','LUPC'},'Location','northwest','Orientation','horizontal','FontSize',fs)

set(gcf,'units',PaperUnits)
set(gcf,'Position',[0 0 px py]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', PaperUnits);
set(gcf, 'PaperPosition', [0 0 px py]);
set(gcf, 'PaperSize', [px py]);
print(gcf,'PSE2D_meshScaling','-dpng','-r600');

