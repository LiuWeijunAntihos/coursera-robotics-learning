clear;
close all;

load('Sample_RGB.mat');


Samples = [];

for i=1:5
    % Load image
    image_RGB = [];
    image_RGB(:,:,1)=SamplesPoint{i}{1}{1};
    image_RGB(:,:,2)=SamplesPoint{i}{2}{1};
    image_RGB(:,:,3)=SamplesPoint{i}{3}{1};
    
    I = rgb2hsv(image_RGB);
    
    % You may consider other color space than RGB
    H = I(:,:,1);
    S = I(:,:,2);
    V = I(:,:,3);
    
    Samples = [Samples; [H S V]];
    
%     imshow(I);
%     pause;
    
end

figure, 
scatter3(Samples(:,1),Samples(:,2),Samples(:,3),'.');
title('Pixel Color Distribubtion');
xlabel('H');
ylabel('S');
zlabel('V');
