function [ratioPercieved,ratioAdjusted] = Calc_Shape_Distortion(slant,flag)
%
%Determine the shape of a rectangle in the retinal image when the rectangle is slanted a given
%amount. This will allow us to predict the expected shape distortion for a
%given change in binocular disparity.

%This function calculates the positions of four corners of a rectangle after it has
%been slanted a given amount. Then it calculates the ratio of the two sides of
%the rectangle.

% if flag == phone, calculate for the real phones used in the real-world
% object experimemt
% if flag == quad, calculate for the simulated quadrilateral in the
% simulated objects experiment

%NOTE: y coordinate in the world won't change but the height changes after
%perspective projection of the rectangle

switch flag

    case 'phone'

        %define typical distance from cyclopian eye to the phone
        dist_m = 0.35;

        % define typical size of phone
        RectHalfW_m = 0.04;
        RectHalfH_m = 0.08;

    case 'quad'
        %define distance from cyclopian eye to the rectangle.
        dist_m = 0.293;

        %Define size of rectangle
        RectH_dg    = 16;
        RectW_dg    = 16;
        RectHalfW_m = (2*(dist_m )).*tand((RectW_dg./2)./2);
        RectHalfH_m = (2*(dist_m )).*tand((RectW_dg./2)./2);
end

%Define four corners of the rectangle
%order: bottomleft , topleft, topright, bottomright
x = [-RectHalfW_m,-RectHalfW_m,RectHalfW_m,RectHalfW_m];
y = [-RectHalfH_m,RectHalfH_m,RectHalfH_m,-RectHalfH_m];
z = [dist_m,dist_m ,dist_m ,dist_m];


%THINGS YOU NEED TO SPECIFY A PLANE
% to specify a plane you need a point on that plane and a surface normal
% vector. To adjust the slant of the plane, we will adjust the surface
% normal vector. These will be used to specify the texture and disparity planes.

% point on plane
x0 = 0;
y0 = 0;
z0 = dist_m; %negative distance

% frontoparallel plane normal (surface normal vector)
a0 = 0;
b0 = 0;
c0 = 1; %specifies the direction the vector is pointing. this must remain 1 for the calculations


for ind = 1:length(slant) %loop through the slants

    %disp(['Slant = ', num2str(slant(ind)), ' deg']);

    %CALCULATE PLANE FOR A GIVEN SLANT
    % adjust surface normal to specified slant (this changes the surface normal vector)
    %a and c are the new x and z coordinates for the surface normal vector a the new slant
    a = a0*cosd(slant(ind)) - c0*sind(slant(ind)); %x coordinate for surfance normal vector
    b = b0; % y coordinate doesn't change because we are rotating around a vertical axis
    c = a0*sind(slant(ind)) + c0*cosd(slant(ind)); %z coordinate for surface normal vector

    % Equation for a plane
    % solve for d (https://mathworld.wolfram.com/Plane.html)
    d = -a*x0 - b*y0 - c*z0;

    %Identify the X POSITION OF THE DOTS
    % before solving for z, we need to correct the x coordinates as appropriate
    % for the slant angle that specifies slant. The x values must
    x_slanted = x*cosd(slant(ind));

    % solve for z position of the dots
    z_slanted= (-d - a.*x_slanted - b.*y)./c; %all the z coordinates of texture specified slanted plane

    %PLOT USING PERSPECTIVE PROJECTION
    %manually calculate perspective projection of original grid and adjusted
    %grid.
    f = 1;
    xo = f*x(:)./z(:);
    yo = f*y(:)./z(:);

    xs = f*x_slanted(:)./z_slanted(:);
    ys = f*y(:)./z_slanted(:);

    if(0)
        figure(51); hold on;
        plot(xo,yo,'-ko'); %original
        plot(xs,ys,'-ro'); %slanted
        axis equal;
    end

    %Identfiy the ratio of the right height to left height of the shape
    %this is the calculation we do in the paper to measure the shape distortion

    %After calculating perspective projection the y values have changed
    ratioPercieved(ind) = ys(4)./ ys(1); %half height of right side divided by the left side

    % ratio required to undo the perspective distortion
    ratioAdjusted(ind) = ys(1) ./ ys(4);

end