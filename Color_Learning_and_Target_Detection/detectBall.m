% Robotics: Estimation and Learning 
% WEEK 1
% 
% Complete this function following the instruction. 
function [segI, loc] = detectBall(I)
% function [segI, loc] = detectBall(I)
%
% INPUT
% I       120x160x3 numerial array 
%
% OUTPUT
% segI    120x160 numeric array
% loc     1x2 or 2x1 numeric array 



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hard code your learned model parameters here
%
 segI = zeros(120,160);
 mu = [1.453197908286404e+02;1.405534995977474e+02;65.737731295253430]
 sig = [2.537686107366177e+02,1.486166403136729e+02,-2.391635142315879e+02;1.486166403136729e+02,1.358778698927986e+02,-1.650973927040503e+02;-2.391635142315879e+02,-1.650973927040503e+02,3.600132746598995e+02]
 thre = 4e-06;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Find ball-color pixels using your model
% 

[sizeR,sizeC,sizeX] = size(I);
for i=1:sizeR
    for j=1:sizeC
    P = [double(I(i,j,1));double(I(i,j,2));double(I(i,j,3))];
    p = mvnpdf(P, mu, sig);
        if p > thre
            segI(i,j) = 255;
        end
    end
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do more processing to segment out the right cluster of pixels.
% You may use the following functions.
%   bwconncomp
%   regionprops
% Please see example_bw.m if you need an example code.
% create new empty binary image

bw_biggest = false(size(segI));

% http://www.mathworks.com/help/images/ref/bwconncomp.html
CC = bwconncomp(segI);
numPixels = cellfun(@numel,CC.PixelIdxList);
[biggest,idx] = max(numPixels);
bw_biggest(CC.PixelIdxList{idx}) = true; 


% show the centroid
% http://www.mathworks.com/help/images/ref/regionprops.html
S = regionprops(CC,'Centroid');
loc = S(idx).Centroid;
figure,
imshow(bw_biggest); hold on;
plot(loc(1), loc(2),'r+');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute the location of the ball center
%

% segI = 
% loc = [0;0;0];
% 
% Note: In this assigment, the center of the segmented ball area will be considered for grading. 
% (You don't need to consider the whole ball shape if the ball is occluded.)

end
