% Figure 5

%creating quadrent lines to help deliniate regions of the plot
x_lineatzero  = [-40:0.5:40];
y_xlineatzero = zeros(1,length(x_lineatzero));
y_lineatzero  = [-40:0.5:40];
x_ylineatzero = zeros(1,length(y_lineatzero));
x_linezeros   = [-40:0.5:40];
y_apone       = ones(1,length(x_linezeros));

%Needed for plotting lines of the hypothesized data
xdisporder =  [-12:3:12];
xrectorder =  [-4:1:4];

% plotting styles
color_01 = [0, 0.4470, 0.7410];         %blue 
color_06 = [0.9290, 0.6940, 0.1250];    %yellow
color_03 = [0.4660, 0.6740, 0.1880];    %green 

linewidth_er = 0.7;
linewidth_2 = 2.5;
MarkerSize_2 = 100;
MarkerSizeP_2 = MarkerSize_2.*0.2;
fontsize_2 = 15;

%Calculate CI for plots below
SlantU_CI = 1.96.*std(mean(slantPercievedFlatU(:,indexorder_9,:),1),0,3)./sqrt(size(slantPercievedFlatU,3));
SlantH_CI = 1.96.*std(mean(slantPercievedFlatH(:,indexorder_9,:),1),0,3)./sqrt(size(slantPercievedFlatH,3));
SlantV_CI = 1.96.*std(mean(slantPercievedFlatV(:,indexorder_9,:),1),0,3)./sqrt(size(slantPercievedFlatV,3));

ShapeU_CI = 1.96.*std(mean(RectRatioRightOverLeftU(:,indexorder_9,:),1),0,3)./sqrt(size(RectRatioRightOverLeftU,3));
ShapeH_CI = 1.96.*std(mean(RectRatioRightOverLeftH(:,indexorder_9,:),1),0,3)./sqrt(size(RectRatioRightOverLeftH,3));
ShapeV_CI = 1.96.*std(mean(RectRatioRightOverLeftV(:,indexorder_9,:),1),0,3)./sqrt(size(RectRatioRightOverLeftV,3));


% HORIZONTAL AND VERTICAL MAGNIFICATION SLANT AND SHAPE ILLUSION
f1 = figure; hold on; 
f1.Position = [100 100 900 800];

for task = 1:2 %loop through the tasks to set up the plots
    
    subplot(1,2,task); hold on;
    
    %draw quadrent line
    zeroy = plot(x_ylineatzero,y_lineatzero,'k');hold on;%draw x=0  
    
    %Slant task
    if task == 1
        
        %draw quadrent line
        zerox = plot(x_lineatzero,y_xlineatzero,'k');hold on;%draw line at zero
        
        %Slant - plot average horizontal, uniform, and vertical results
        subplot(1,2,1);
        title('Slant Task');
        H  = scatter(xdisporder, mean(mean(slantPercievedFlatH(:,indexorder_9,:),1),3),[MarkerSize_2],'o','MarkerFaceColor',color_01,'MarkerEdgeColor',color_01); %horizontal
        Er = errorbar(xdisporder,mean(mean(slantPercievedFlatH(:,indexorder_9,:),1),3),(SlantH_CI),SlantH_CI);Er.Color=[0 0 0]; Er.LineStyle = "none"; Er.LineWidth = linewidth_er;
        
        V  = scatter(xdisporder, mean(mean(slantPercievedFlatV(:,indexorder_9,:),1),3),[MarkerSize_2],'o','MarkerFaceColor',color_06,'MarkerEdgeColor',color_06); %vertical
        Er = errorbar(xdisporder,mean(mean(slantPercievedFlatV(:,indexorder_9,:),1),3),(SlantV_CI),SlantV_CI);Er.Color=[0 0 0]; Er.LineStyle = "none"; Er.LineWidth = linewidth_er;

        %No Magnification - central point is black 
        NoMag = scatter(0,mean(mean(slantPercievedFlatU(:,1,:)),3),[MarkerSize_2],'o','MarkerFaceColor',[0.5,0.5,0.5],'MarkerEdgeColor',[0.5,0.5,0.5]); %no magnification
        Er    = errorbar(0,mean(mean(slantPercievedFlatU(:,1,:)),3),(SlantU_CI(5)),SlantU_CI(5));Er.Color=[0 0 0]; Er.LineStyle = "none"; Er.LineWidth = linewidth_er;
        
        %axis variables
        xlim([-15,15]);
        ylim([-32,32]);
        ylabel('Slant perceived flat (deg)');
        xticks(-12:3:12); xticklabels({'12','9','6','3','0','3','6','9','12'});
   
    else %Shape task
        
        %draw quadrent line
        one_ap = plot(x_linezeros,y_apone,'k'); hold on;%axis lines

        %Expected Shape based on actual slant reported in the experiment -
        %these values are results from fitting the estimates with a third order polynomial. 
        RadH = plot([-4:4],shape_estH_avg,'-','color',color_01);RadH(1).MarkerSize=10; RadH(1).LineWidth = linewidth_2;
        RadV = plot([-4:4],shape_estV_avg,'-','color',color_06);RadV(1).MarkerSize=10; RadV(1).LineWidth = linewidth_2;
        
        %Shape
        subplot(1,2,2);
        title('Shape Task');
        scatter(xrectorder, mean(mean(RectRatioRightOverLeftH(:,indexorder_9,:),1),3),[MarkerSize_2],'o','MarkerFaceColor',color_01,'MarkerEdgeColor',color_01); %horizontal
        Er = errorbar(xrectorder,mean(mean(RectRatioRightOverLeftH(:,indexorder_9,:),1),3),-(ShapeH_CI),ShapeH_CI);Er.Color=[0 0 0]; Er.LineStyle = "none"; Er.LineWidth = linewidth_er;
        
        scatter(xrectorder, mean(mean(RectRatioRightOverLeftV(:,indexorder_9,:),1),3),[MarkerSize_2],'o','MarkerFaceColor',color_06,'MarkerEdgeColor',color_06); %vertical
        Er = errorbar(xrectorder,mean(mean(RectRatioRightOverLeftV(:,indexorder_9,:),1),3),-(ShapeV_CI),ShapeV_CI);Er.Color=[0 0 0]; Er.LineStyle = "none"; Er.LineWidth = linewidth_er;

        %No Magnification - central point is gray
        NoMag = scatter(0,mean(mean(RectRatioRightOverLeftU(:,1,:)),3),[MarkerSize_2],'o','MarkerFaceColor',[0.5,0.5,0.5],'MarkerEdgeColor',[0.5,0.5,0.5]); %no magnification
        Er    = errorbar(0,mean(mean(RectRatioRightOverLeftU(:,1,:)),3),-(ShapeU_CI(5)),ShapeU_CI(5));Er.Color=[0 0 0]; Er.LineStyle = "none"; Er.LineWidth = linewidth_er;
        
        %axis variables
        xlim([-5,5]);
        ylim([0.95,1.055]);
        xticks(-4:1:4); xticklabels({'4','3','2','1','0','1','2','3','4'});
        yticks([0.95, 0.975, 1.00, 1.025, 1.050]); yticklabels({'0.950', '0.975', '1.000', '1.025', '1.050'});
        ylabel('Shape Ratio (right / left)');
    end
    
    %axis variables
    xlabel('Left Eye Right Eye');
    set(gca,'plotboxaspectratio',[1 1 1],'box','on','FontSize',fontsize_2);
end

legend([RadH,RadV],'Shape predicted from geometric effect','Shape predicted from induced effect');
hold off; 


%UNIFORM MAGNIFICATION

%plotting variables
linewidth_model = 3.5;
linewidth_2     = 2.5;
linewidth_er    = 0.7;
MarkerSize_2    = 100;
MarkerSizeP_2   = MarkerSize_2.*0.2;
fontsize_2      = 15;
alpha_models    = 0.6;

f1          = figure; hold on; 
f1.Position = [100 100 900 800];

for task = 1:2 %loop through the tasks to set up the plots
    
    subplot(1,2,task); hold on;
    
    %draw quadrent line
    zeroy = plot(x_ylineatzero,y_lineatzero,'k');hold on;%draw x=0  
    
    %Slant task
    if task == 1

        %draw quadrent line
        zerox = plot(x_lineatzero,y_xlineatzero,'k');hold on;%draw line at zero

        title('Slant Task');

        %Slant - plot average
        U = scatter(xdisporder, mean(mean(slantPercievedFlatU(:,indexorder_9,:),1),3),[MarkerSize_2],'o','MarkerFaceColor',color_03,'MarkerEdgeColor',color_03); 
        Er = errorbar(xdisporder,mean(mean(slantPercievedFlatU(:,indexorder_9,:),1),3),(SlantU_CI),SlantU_CI);Er.Color=[0 0 0]; Er.LineStyle = "none"; Er.LineWidth = linewidth_er;

        %No Magnification - central point is black
        NoMag = scatter(0,mean(mean(slantPercievedFlatU(:,1,:)),3),[MarkerSize_2],'o','MarkerFaceColor',[0.5,0.5,0.5],'MarkerEdgeColor',[0.5,0.5,0.5]); 
        Er = errorbar(0,mean(mean(slantPercievedFlatU(:,1,:)),3),(SlantU_CI(5)),SlantU_CI(5));Er.Color=[0 0 0]; Er.LineStyle = "none"; Er.LineWidth = linewidth_er;

        %axis variables
        xlim([-15,15]);
        ylim([-32,32]);
        ylabel('Slant perceived frontoparallel (deg)');
        xticks(-12:3:12); xticklabels({'12','9','6','3','0','3','6','9','12'});

    else %Shape task

        %draw quadrent line
        one_ap = plot(x_linezeros,y_apone,'k'); hold on;%axis lines

        %Expected Shape based on actual slant reported in the experiment -
        %these values are results from fitting the estimates witha third
        %order polynomial. 
        RadU = plot([-4:4],shape_estU_avg,'-','color',color_03);RadU(1).MarkerSize=10; RadU(1).LineWidth = linewidth_2;
        
        %Shape
        subplot(1,2,2);
        title('Shape Task');
        scatter(xrectorder, mean(mean(RectRatioRightOverLeftU(:,indexorder_9,:),1),3),[MarkerSize_2],'o','MarkerFaceColor',color_03,'MarkerEdgeColor',color_03); 
        Er = errorbar(xrectorder,mean(mean(RectRatioRightOverLeftU(:,indexorder_9,:),1),3),...
            (ShapeU_CI),ShapeU_CI);Er.Color=[0 0 0]; Er.LineStyle = "none"; Er.LineWidth = linewidth_er;

        %No Magnification - central point is gray
        NoMag = scatter(0,mean(mean(RectRatioRightOverLeftU(:,1,:)),3),[MarkerSize_2],'o','MarkerFaceColor',[0.5,0.5,0.5],'MarkerEdgeColor',[0.5,0.5,0.5]);
        Er = errorbar(0,mean(mean(RectRatioRightOverLeftU(:,1,:)),3),(ShapeU_CI(5)),ShapeU_CI(5));Er.Color=[0 0 0]; Er.LineStyle = "none"; Er.LineWidth = linewidth_er;
        
        %axis variables
        xlim([-5,5]);
        ylim([0.95,1.055]);
        xticks(-4:1:4); xticklabels({'4','3','2','1','0','1','2','3','4'});
        yticks([0.95, 0.975, 1.00, 1.025, 1.050]); yticklabels({'0.950', '0.975', '1.000', '1.025', '1.050'});
        ylabel('Shape Ratio (right / left)');
    end
    
    %axis variables
    xlabel('Left Eye Right Eye');
    set(gca,'plotboxaspectratio',[1 1 1],'box','on','FontSize',fontsize_2);
end

legend([RadU],'Shape predicted from measured slant effect');
hold off; 