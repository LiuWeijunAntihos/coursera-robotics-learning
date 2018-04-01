% for i=1:3
%     x=0:0.1:255;
%     y=normpdf(x,mu(i),sqrt(sig(i)));
%     figure,
%     plot(x,y)
% end


X = [1;1;1]; 
p = mvnpdf(P, mu, sigma); 
