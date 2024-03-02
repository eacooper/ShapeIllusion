%Figure 3

%Calculations needed for plotting 

%Percent of participants who said object apeared slanted
SL_cont_square_percent = sum(SL_cont_square)./SubjNum*100;
SL_exp_square_percent  = sum(SL_exp_square)./SubjNum*100;
SL_cont_phone_percent  = sum(SL_cont_phone)./SubjNum*100;
SL_exp_phone_percent   = sum(SL_exp_phone)./SubjNum*100;

%binomial error bars
[phat,fitconf]           = binofit(sum(SL_cont_square),SubjNum); 
SL_cont_square_fitconf   = (fitconf.*100) - SL_cont_square_percent; %convert into percentages
[phat,fitconf]           = binofit(sum(SL_exp_square),SubjNum); 
SL_exp_square_fitconf    = (fitconf.*100) - SL_exp_square_percent; 
[phat,fitconf]           = binofit(sum(SL_cont_phone),SubjNum); 
SL_cont_phone_fitconf    = (fitconf.*100) - SL_cont_phone_percent; 
[phat,fitconf]           = binofit(sum(SL_exp_phone),SubjNum); 
SL_exp_phone_fitconf     = (fitconf.*100) - SL_exp_phone_percent;

% Percent of participants who said it looked slanted right side back
% (expected direction when wearing a horizontal magnifier.)
SLr_cont_square_percent = numel(find(SD_cont_square == 1))./ SubjNum * 100; 
SLr_exp_square_percent  = numel(find(SD_exp_square == 1)) ./ SubjNum * 100;
SLr_cont_phone_percent  = numel(find(SD_cont_phone == 1)) ./ SubjNum * 100;
SLr_exp_phone_percent   = numel(find(SD_exp_phone == 1))  ./ SubjNum * 100;

%Binomial error bars
[phat,fitconf]           = binofit(numel(find(SD_cont_square == 1)),SubjNum); 
SLr_cont_square_fitconf  = (fitconf.*100) - SLr_cont_square_percent; 
[phat,fitconf]           = binofit(numel(find(SD_exp_square == 1)),SubjNum); 
SLr_exp_square_fitconf   = (fitconf.*100) - SLr_exp_square_percent; 
[phat,fitconf]           = binofit(numel(find(SD_cont_phone == 1)),SubjNum); 
SLr_cont_phone_fitconf   = (fitconf.*100) - SLr_cont_phone_percent; 
[phat,fitconf]           = binofit(numel(find(SD_exp_phone == 1)),SubjNum); 
SLr_exp_phone_fitconf    = (fitconf.*100) - SLr_exp_phone_percent; 

% Percent of participants who said it looked slanted left back
SLl_cont_square_percent = numel(find(SD_cont_square == 2))./ SubjNum .* 100; 
SLl_exp_square_percent  = numel(find(SD_exp_square == 2)) ./ SubjNum .* 100;
SLl_cont_phone_percent  = numel(find(SD_cont_phone == 2)) ./ SubjNum .* 100;
SLl_exp_phone_percent   = numel(find(SD_exp_phone == 2))  ./ SubjNum .* 100;

%Binomial error bars
[phat,fitconf]           = binofit(numel(find(SD_cont_square == 2)),SubjNum); 
SLl_cont_square_fitconf  = (fitconf.*100) - SLl_cont_square_percent;
[phat,fitconf]           = binofit(numel(find(SD_exp_square == 2)),SubjNum); 
SLl_exp_square_fitconf   = (fitconf.*100) - SLl_exp_square_percent;
[phat,fitconf]           = binofit(numel(find(SD_cont_phone == 2)),SubjNum); 
SLl_cont_phone_fitconf   = (fitconf.*100) - SLl_cont_phone_percent;
[phat,fitconf]           = binofit(numel(find(SD_exp_phone == 2)),SubjNum); 
SLl_exp_phone_fitconf    = (fitconf.*100) - SLl_exp_phone_percent; 


%Plotting

%Percent percieved slant (Y/N)
figure,
newsubplot(2,1,1); hold on;

%Phone
bar(1, SL_exp_phone_percent,'FaceColor',exp_color);
Er = errorbar(1, SL_exp_phone_percent,SL_exp_phone_fitconf(1),SL_exp_phone_fitconf(2)); Er.Color=[0 0 0]; Er.LineStyle = "none"; Er.LineWidth = linewidth_er;
bar(2,SL_cont_phone_percent,'FaceColor',cont_color);
Er = errorbar(2,SL_cont_phone_percent,SL_cont_phone_fitconf(1),SL_cont_phone_fitconf(2)); Er.Color=[0 0 0]; Er.LineStyle = "none"; Er.LineWidth = linewidth_er;

%square
bar(4,SL_exp_square_percent,'FaceColor',exp_color);
Er = errorbar(4,SL_exp_square_percent,SL_exp_square_fitconf(1),SL_exp_square_fitconf(2)); Er.Color=[0 0 0]; Er.LineStyle = "none"; Er.LineWidth = linewidth_er;
bar(5,SL_cont_square_percent,'FaceColor',cont_color);
Er = errorbar(5,SL_cont_square_percent,SL_cont_square_fitconf(1),SL_cont_square_fitconf(2)); Er.Color=[0 0 0]; Er.LineStyle = "none"; Er.LineWidth = linewidth_er;

ylabel('Participants who perceived a slant (%)');
xlim([0,6]);
ylim([0,100]);
xticks([1.5,4.5]);
set(gca,'box','on');
xticklabels({'Phone','Black Square'});


% Percent who saw slant in a specific direction in the experimental
% condition.
newsubplot(2,1,2); hold on;

%phone
bar(1,SLr_exp_phone_percent,'FaceColor',exp_color);  % right side back
Er = errorbar(1,SLr_exp_phone_percent,SLr_exp_phone_fitconf(1),SLr_exp_phone_fitconf(2)); Er.Color=[0 0 0]; Er.LineStyle = "none"; Er.LineWidth = linewidth_er;
bar(2,SLl_exp_phone_percent,'FaceColor',exp_color); %left side back
Er = errorbar(2,SLl_exp_phone_percent,SLl_exp_phone_fitconf(1),SLl_exp_phone_fitconf(2)); Er.Color=[0 0 0]; Er.LineStyle = "none"; Er.LineWidth = linewidth_er;

%square
exp = bar(4,SLr_exp_square_percent,'FaceColor',exp_color); % right side back
Er = errorbar(4,SLr_exp_square_percent,SLr_exp_square_fitconf(1),SLr_exp_square_fitconf(2)); Er.Color=[0 0 0]; Er.LineStyle = "none"; Er.LineWidth = linewidth_er;
bar(5,SLl_exp_square_percent,'FaceColor',exp_color); %left side back
Er = errorbar(5,SLl_exp_square_percent,SLl_exp_square_fitconf(1),SLl_exp_square_fitconf(2)); Er.Color=[0 0 0]; Er.LineStyle = "none"; Er.LineWidth = linewidth_er;

xticks([1,2,4,5]);
xticklabels({'/','\','/','\'});
ylim([0,100]);
xlim([0,6]);
ylabel('Direction of perceived slant (%)')
text(1,50,'Phone');
text(4.3,50,'Black Square');
set(gca,'box','on');
