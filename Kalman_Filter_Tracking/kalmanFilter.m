function [ predictx, predicty, state, param ] = kalmanFilter( t, x, y, state, param, previous_t )
%UNTITLED Summary of this function goes here
%   Four dimensional state: position_x, position_y, velocity_x, velocity_y
    %% Place parameters like covarainces, etc. here:
    % P = eye(4)
    % R = eye(2)
    dt = 0.33;
    
    A = [1,0,dt,0;
         0,1,0,dt;
         0,0,1,0;
         0,0,0,1];
    C = [1,0,0,0;
         0,1,0,0];
    

    % Check if the first time running this function
    if previous_t<0
        state = [x, y, 0, 0];
        param.R = [0.5 * dt^2, 0, 0, 0
                   0, 0.5 * dt^2, 0, 0
                   0, 0, 1, 0
                   0, 0, 0, 1]^2;
        param.Q = [0.1,0;
                   0, 0.1]';
        param.sigma = zeros(4,4);
        predictx = x;
        predicty = y;
        return;
    end

    %% TODO: Add Kalman filter updates
    % Begin update states
    avg_miu = A * state';
    avg_sigma = A * param.sigma * A' + param.R;
    k = avg_sigma * C' * (C * avg_sigma * C' + param.Q)^-1;
    miu = avg_miu + k * ([x, y]' - C * avg_miu);
    param.sigma = (eye(4) - k * C) * avg_sigma;
    
    state = miu';
    predictx = miu(1);
    predicty = miu(2);
    
    
%     % As an example, here is a Naive estimate without a Kalman filter
%     % You should replace this code
%     vx = (x - state(1)) / (t - previous_t);
%     vy = (y - state(2)) / (t - previous_t);
%     % Predict 330ms into the future
%     predictx = x + vx * 0.330;
%     predicty = y + vy * 0.330;
%     % State is a four dimensional element
%     state = [x, y, vx, vy];
end
