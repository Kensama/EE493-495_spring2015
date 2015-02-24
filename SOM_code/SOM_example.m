%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	Name: 	Eng. Turky Abdulaziz Abdulhafiz Saderaldin
%	ID:		1300388
%	Homwork #3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%//Matlab script 
%//-- 10 x 10 map 

run('digit_segmentation')   % Preparing Data

clear all 
%close all
load SOM_datafile;

data = [N0,N1,N2,N3,N4,N5,N6,N7,N8,N9];
data = double(data); 
%// total number of nodes 
totalW = 100; 
%//initialization of weights 
w = rand(900, totalW); 
%// the initial learning rate 
eta0 = 0.1; 
%// the current learning rate (updated every epoch) 
etaN = eta0; 
%// the constant for calculating learning rate 
tau2 = 1000; 
  
%//map index 
[I,J] = ind2sub([10, 10], 1:100); 
  
N = size(data,2); 
  
alpha = 0.5; 
%// the size of neighbor 
sig0 = 200; 
  
sigN = sig0; 
%// tau 1 for updateing sigma 
tau1 = 1000/log(sigN); 
  
%i is number of epoch 
for i=1:2000 
    %// j is index of each image. 
    %// it should iterate through data in a random order rewrite!! 
    for j=1:N 
        x = data(:,j); 
        dist = sum( sqrt((w - repmat(x,1,totalW)).^2),1); 
  
        %// find the winner 
        [v ind] = min(dist); 
        %// the 2-D index 
        ri = [I(ind), J(ind)]; 
  
        %// distance between this node and the winner node. 
        dist = 1/(sqrt(2*pi)*sigN).*exp( sum(( ([I( : ), J( : )] - repmat(ri, totalW,1)) .^2) ,2)/(-2*sigN)) * etaN; 
  
        %// updating weights 
        for rr = 1:100 
            w(:,rr) = w(:,rr) + dist(rr).*( x - w(:,rr)); 
        end 
    end 
  
    %// update learning rate 
    etaN = eta0 * exp(-i/tau2); 
    %// update sigma 
    %sigN = sigN/2; 
    sigN = sig0*exp(-i/tau1); 
  
    %//show the weights every 100 epoch 
    if mod(i,200) == 1 
        figure; 
        axis off; 
        hold on; 
        for l = 1:100 
            [lr lc] = ind2sub([10, 10], l); 
            subplot(10,10,l); 
            axis off; 
            imagesc(reshape(w(:,l),30,30)); 
            axis off; 
        end 
        hold off; 
    end 
end
