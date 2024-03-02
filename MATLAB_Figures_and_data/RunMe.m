%Loads in the data and runs scripts to make figures
clear all; close all;

% set paths
current_path = pwd;

if ismac
    addpath(strcat(current_path, '/data'));
    addpath(strcat(current_path, '/subtightplot'));
else
    addpath(strcat(current_path, '\data'));
    addpath(strcat(current_path, '\subtightplot'));
end


%% EXPERIMENT USING REAL-WORLD OBJECTS

% square ratio (right side/left side) for each subject
load('SR_cont_square'); %control square
load('SR_exp_phone'); % experimental phone
load('SR_exp_square'); % experimental square
load('SR_cont_phone'); % control phone

% participants who saw a slant (yes=1 no=0) for each subject
load('SL_cont_phone');
load('SL_cont_square');
load('SL_exp_phone');
load('SL_exp_square');

% slant direction percieved (0=no slant, 1=right back, 2=left back) for each subject
load('SD_cont_phone');
load('SD_cont_square');
load('SD_exp_phone');
load('SD_exp_square');

% plot data shown in Figures 1 and 3
Figure_1;
Figure_3;

% estimate of predicted shape ratio given in the legend of Figure 1
Expected_shaperatio_based_on_phone_distance;


%% EXPERIMENT USING SIMULATED OBJECTS

% slant that was percieved to be fronto-parallel
load('slantPercievedFlatH');
load('slantPercievedFlatV');
load('slantPercievedFlatU');
% row = trial, col=condition, 3rd dim =subject
% the columns/conditions represent the different magnification levels and
% if that magnification was worn over the left (L) or right (R) eye. The
% eye for these conditions is below.
% Key for horizontal and vertical mag:
%    NaN (no data), 3R, 3L, 6R, 6L, 9R, 9L, 12R, 12L 
% Key for uniform mag:
%    0, 3R, 3L, 6R, 6L, 9R, 9L, 12R, 12L

% shape that was perceived to be square
load('RectRatioRightOverLeftH');
load('RectRatioRightOverLeftV');
load('RectRatioRightOverLeftU');
% the conditions are in the same order as the slant conditions. 

%Expected Shape distortion based on slant measurements (prediction lines in Figure 5)
Expected_Shape_Distortion;

% plot data and prediction lines in Figure 5
Figure_5;

% convert mat data files to csv for statistical analysis
Mat_to_csv;


