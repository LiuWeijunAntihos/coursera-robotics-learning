% Robotics: Estimation and Learning 
% WEEK 3
% 
% Complete this function following the instruction. 
function myMap = occGridMapping(ranges, scanAngles, pose, param)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Parameters 
% 
% the number of grids for 1 meter.
myResol = param.resol;
% the initial map size in pixels
myMap = zeros(param.size);
% the origin of the map in pixels
myorigin = param.origin; 

% 4. Log-odd parameters 
lo_occ = param.lo_occ;
lo_free = param.lo_free; 
lo_max = param.lo_max;
lo_min = param.lo_min;
N = size(pose,2);
for j = 1:N % for each time,

    i_x_ori = ceil(myResol * pose(1, j)) + myorigin(1, 1);
    i_y_ori = ceil(myResol * pose(2, j)) + myorigin(2, 1);

    NScan_angle = size(scanAngles, 1);
    for k = 1:NScan_angle
        x_occ = ranges(k, j) * cos(pose(3, j) + scanAngles(k, 1)) + pose(1, j);
        y_occ = -ranges(k, j) * sin(pose(3, j) + scanAngles(k, 1)) + pose(2, j);
        i_x_occ = ceil(myResol * x_occ) + myorigin(1, 1);
        i_y_occ = ceil(myResol * y_occ) + myorigin(2, 1);
        [freex, freey] = bresenham(i_x_ori,i_y_ori,i_x_occ,i_y_occ);  
        myMap(i_y_occ, i_x_occ) = myMap(i_y_occ, i_x_occ) + lo_occ;                   
        if lo_max > myMap(i_y_occ, i_x_occ)
                myMap(i_y_occ, i_x_occ) = lo_max;
        end
        if size(freex, 1) ~= 1
            for l = 1:size(freex, 1)
                myMap(freey(l, 1), freex(l, 1)) = myMap(freey(l, 1), freex(l, 1)) - lo_free;
                if lo_min < myMap(freey(l, 1), freex(l, 1))
                    lo_min = myMap(freey(l, 1), freex(l, 1));
                end
            end
        else
            myMap(freey, freex) = myMap(freey, freex) - lo_free;
                if lo_min < myMap(freey, freex)
                    lo_min = myMap(freey, freex);
                end
        end
    end
%     figure(1),
%     imagesc(myMap); hold on;
%     plot(i_x_ori,i_y_ori,'rx','LineWidth',3); % indicate start point
%     axis equal;
  
    % Find grids hit by the rays (in the gird map coordinate)
    

    % Find occupied-measurement cells and free-measurement cells


    % Update the log-odds
  

    % Saturate the log-odd values
    

    % Visualize the map as needed
   

end
param.lo_max = lo_max;
param.lo_min = lo_min;
end





