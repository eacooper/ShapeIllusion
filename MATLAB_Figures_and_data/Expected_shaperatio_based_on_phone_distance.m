%Calculate the expected shape ratio given the estimated distance that
%people were holding thier phone. 


dist_cm = 35;    %distance from eyes to phone
mag     = 1.038; %monocular magnification
IPD_cm  = 6.3; 

EstSlantPercieved = atand( ( (mag-1)./(mag+1) ) .* ((2*dist_cm)./IPD_cm) );


[ratioPercieved,Ratio_Adjusted] = Calc_Shape_Distortion(EstSlantPercieved,'phone')