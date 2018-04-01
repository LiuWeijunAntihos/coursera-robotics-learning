clear;
close all;

load('Sample_RGB.mat');

sigma = zeros(3,3);
p = 0;
R = [];
G = [];
B = [];
for i=1:5
    
    R = [R;double(SamplesPoint{i}{1}{1})];    
    G = [G;double(SamplesPoint{i}{2}{1})];
    B = [B;double(SamplesPoint{i}{3}{1})];
    
end

mu = [mean(R);mean(G);mean(B)];
[sizeR,tmpR] = size(R);
for i=1:sizeR
    P=[R(i);G(i);B(i)];
    tmp = ((P - mu) * (P - mu)') / sizeR;
    sigma=sigma + tmp;
end
for i=1:sizeR
    P=[R(i);G(i);B(i)];
    p = p + mvnpdf(P, mu, sigma); 
end

thre = p / sizeR;