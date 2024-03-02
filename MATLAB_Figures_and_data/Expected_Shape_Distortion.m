%CALCULATE THE EXPECTED SHAPE DISTORTION BASED ON SLANT PERCIEVED
%I am estimating the aspect ratio based on the reported slants
%that people percieved in the experiment. We take into account inferences
%from disparity and the retinal image shape. 

%order the slants so that the shape estimation is ready to plot after this calculation
%the positions of the numbers in order of desired position to %12L 9L 6L 3L 3R 6R 9R 12R needed to plot line
indexorder_9 = [9 7 5 3 1 2 4 6 8]; 

%Format and average the data so that we can calculate the expected shape distortion from the slant distortion.
slantPercievedFlatU_eachsubj = mean(slantPercievedFlatU(:,indexorder_9,:)); %average across trials
slantPercievedFlatU_all = mean(mean(slantPercievedFlatU(:,indexorder_9,:)),3); %average across trials and subjects

% the horizontal mag data does not have the 0% data included so I am going to add it to the data
slantH          = slantPercievedFlatH;
slantH(:,1,:)   = slantPercievedFlatU(:,1,:);

% now format and average
slantH_eachsubj = mean(slantH(:,indexorder_9,:));
slantH_all      = mean(mean(slantH(:,indexorder_9,:)),3);

%adding the 0% data point to the vertical mag and taking the average 
slantV          = slantPercievedFlatV;
slantV(:,1,:)   = slantPercievedFlatU(:,1,:);
slantV_eachsubj = mean(slantV(:,indexorder_9,:));
slantV_all      = mean(mean(slantV(:,indexorder_9,:)),3);

%shape ratio variables
RatioAdU=[];RatioPerU=[];RatioAdH=[];RatioPerH=[];RatioAdV=[];RatioPerV=[];

% Calculate the expected shape distortion for a vector of slants. This
% loop performs the calculation for each subject as well as for the average
% across participants.
SubjNum = 20;
for subj = 1:SubjNum + 1 %add one for the average across participants for plotting

    for merd = 1:3 %loop through the meridian conditions (uniform, horizontal, vertical)

        slant = [];

        if merd == 1 

            if subj == SubjNum + 1 %send through the grand average
                slant = slantPercievedFlatU_all;
            else
                slant = slantPercievedFlatU_eachsubj(:,:,subj); 
            end
        
        elseif merd == 2

            if subj == SubjNum + 1 %send through the grand average
                slant = slantH_all;
            else
                 slant = slantH_eachsubj(:,:,subj); 
            end


        elseif merd == 3

            if subj == SubjNum + 1 %send through the grand average
                slant = slantV_all;
            else
                 slant = slantV_eachsubj(:,:,subj); 
            end
        end

        %calculate the expected shape distortion
        [ratioPercieved,ratioAdjusted] = Calc_Shape_Distortion(slant,'quad');

        %store ratio adjusted and ratio pericieved. The ratio adjusted is what
        %we expect people's responses to be once the effect was nulled in the
        % task and the ratio percieved is the ratio we think people actually
        % percieved while doing the task.
        %All these calculations are done in ratios of the right to the left side

        if merd == 1 %uniform magnification
            if subj == numel(SR_cont_square) + 1 %grand average
                RatioAdU_avg = ratioAdjusted;
                RatioPerU_avg = ratioPercieved;
            else
                RatioAdU(1,:,subj) = ratioAdjusted;
                RatioPerU(1,:,subj) = ratioPercieved;
            end

        elseif merd == 2 %horizontal magnification
            if subj == numel(SR_cont_square) + 1 %grand average
                RatioAdH_avg = ratioAdjusted;
                RatioPerH_avg = ratioPercieved;
            else
                RatioAdH(1,:,subj) = ratioAdjusted;
                RatioPerH(1,:,subj) = ratioPercieved;
            end

        elseif merd == 3 %vertical magnification
            if subj == numel(SR_cont_square) + 1 %grand average
                RatioAdV_avg = ratioAdjusted;
                RatioPerV_avg = ratioPercieved;
            else
                RatioAdV(1,:,subj) = ratioAdjusted;
                RatioPerV(1,:,subj) = ratioPercieved;
            end

        end

    end
end %subj loop

%% Fit a third order polynomial to the estimates 

%Above we generated the shape estimates based on the slant results. Now we
% can fit the shape estimates with a third order polynomial. This way we can
% generate some shape estimates for the magnification values that were not
% evaluated in the slant task. 

%FIT THE *INDIVIDUAL* SHAPE ESTIMATES TO A THIRD ORDER POLYNOMIAL 
%do this for each subject 
shape_estU = []; shape_estV=[]; shape_estH =[];
shape_estU_avg=[]; shape_estH_avg=[]; shape_estV_avg=[];

for subj = 1:SubjNum

    % FIT THE SHAPE ESTIMATES TO A THIRD ORDER POLYNOMIAL
    % p(x) = p1x^3 + p2x^2 + p3x + p4
    % we constrain the y intercept to go through 1 which means that we
    % constrain the no magnification condition to have a side ratio of 1.
    ft = fittype("(p1.*(x.^3)) + (p2.*(x.^2)) + (p3.*x) + 1");
    fu = fit([-12,-9,-6,-3,0,3,6,9,12]',RatioAdU(:,:,subj)',ft); %uniform
    fh = fit([-12,-9,-6,-3,0,3,6,9,12]',RatioAdH(:,:,subj)',ft); %horizontal
    fv = fit([-12,-9,-6,-3,0,3,6,9,12]',RatioAdV(:,:,subj)',ft); %vertical

    %Solve for estimates at the magnification levels for the shape task (-4,-3,-2,-1,0,1,2,3,4)
    counter = 0;
    for xval = -4:4
        counter = counter + 1;
        shape_estU(1,counter,subj) = (fu.p1.*(xval.^3)) + (fu.p2.*(xval.^2)) + (fu.p3*xval) + 1;
        shape_estH(1,counter,subj) = (fh.p1.*(xval.^3)) + (fh.p2.*(xval.^2)) + (fh.p3*xval) + 1;
        shape_estV(1,counter,subj) = (fv.p1.*(xval.^3)) + (fv.p2.*(xval.^2)) + (fv.p3*xval) + 1;
    end
end


% FIT THE *average* SHAPE ESTIMATES TO A THIRD ORDER POLYNOMIAL
% p(x) = p1x^3 + p2x^2 + p3x + p4 
fu = fit([-12,-9,-6,-3,0,3,6,9,12]',RatioAdU_avg',ft); %uniform
fh = fit([-12,-9,-6,-3,0,3,6,9,12]',RatioAdH_avg',ft); %horizontal
fv = fit([-12,-9,-6,-3,0,3,6,9,12]',RatioAdV_avg',ft); %vertical

%Solve for estimates at the magnification levels for the shape task (-4,-3,-2,-1,0,1,2,3,4)
%this will be the data plotted in the manuscript figures. 
counter = 0;
for xval = -4:4
    counter = counter + 1;
    shape_estU_avg(1,counter) = (fu.p1.*(xval.^3)) + (fu.p2.*(xval.^2)) + (fu.p3*xval) + 1;
    shape_estH_avg(1,counter) = (fh.p1.*(xval.^3)) + (fh.p2.*(xval.^2)) + (fh.p3*xval) + 1;
    shape_estV_avg(1,counter) = (fv.p1.*(xval.^3)) + (fv.p2.*(xval.^2)) + (fv.p3*xval) + 1;
end


