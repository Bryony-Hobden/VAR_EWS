% close figures currently open
close all
clear all

%% Folders
Dfolder = '../Data/';
Ffolder = '../Figures/';

fname.n='default';

%% define data to read
fno=0;

fno=fno+1;
fnames(fno)=fname;
fnames(fno).n='SingHopf_slowramp';

fno=fno+1;
fnames(fno)=fname;
fnames(fno).n='Hopf_slowramp';

fno=fno+1;
fnames(fno)=fname;
fnames(fno).n='Fold_slowramp';


%% X, EVS
for i=1:fno
    tic 
    file_name = [Dfolder fnames(i).n];
    load([file_name '.mat'])

    figure();
    clf;

    %Construct analysis fig
    f1=make_analysis_fig(var, par);
 
    savefig([Ffolder fnames(i).n '.fig']);
    exportgraphics(f1,[Ffolder fnames(i).n '.png']);
    toc
end


