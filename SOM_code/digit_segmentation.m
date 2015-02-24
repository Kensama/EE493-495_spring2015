%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	Name: 	Eng. Turky Abdulaziz Abdulhafiz Saderaldin
%	ID:		1300388
%	Homwork #3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc          % Clear Screen  
clear all    % Clear all variables
close all    % Close all opened figures


I=imread('digits1.jpg');  % read an image file into a matrix
figure('Name','Original');imshow(I)     % show the image in a new figure

Ib=im2bw(I);       % convert image to black and white (binary matrix)
figure('Name','Black and White');imshow(Ib)  % show the converted image
Ibmirror=~Ib;      % convert image to it's nigative
figure('Name','Nigative');imshow(Ibmirror)   % show the image nigative


% Segmentation
Hsum=sum(Ibmirror,2);  % calculate horizontal sum to distinguish rows  
figure('Name','Rows');plot(Hsum);     % plot horizontal sum vector
q1=find(Hsum>10);      % find the valid image content in the whole image row by row
q2=find(diff(q1)>1);   % find the end point of the first row of the image

Ibmirror1=Ibmirror(q1(1):q1(q2),:);       % first row matrix
Ibmirror2=Ibmirror(q1(q2+1):q1(end),:);   % second row matrix
figure('Name','First Row');imshow(Ibmirror1)     % show the first row
figure('Name','Second Row');imshow(Ibmirror2)    % show the second row

clear q1 q2

Vsum1=sum(Ibmirror1,1);  % calculate vertical sum to distinguish columns for first row
Vsum2=sum(Ibmirror2,1);  % calculate vertical sum to distinguish columns for second row
figure('Name','Columns of First Row');plot(Vsum1);       % plot virtical sum vector for first row
figure('Name','Columns of Second Row');plot(Vsum2);      % plot virtical sum vector for second row
q1=find(Vsum1>0);        % find the valid image content in the first row of the image column by column
q2=find(diff(q1)>1);     % find the end point of the first column of first row of the image 
vind1=q1(q2);            % index of end point of each column
vind2=q1(q2+1);          % index of starting point of each column exept the first column


%%% extract each number from the first row
%%%% resize the image matrix to the size of [30 30}
%%%%% reshape the matrix into the form of [900 1]
N0=reshape(imresize(Ibmirror1(:,q1(1):vind1(1)),[30 30]),900,1);
N1=reshape(imresize(Ibmirror1(:,vind2(1):vind1(2)),[30 30]),900,1);
N2=reshape(imresize(Ibmirror1(:,vind2(2):vind1(3)),[30 30]),900,1);
N3=reshape(imresize(Ibmirror1(:,vind2(3):vind1(4)),[30 30]),900,1);
N4=reshape(imresize(Ibmirror1(:,vind2(4):q1(end)),[30 30]),900,1);

%%% Show extracted numbers from the image
figure('Name','Number 0');imshow(Ibmirror1(:,q1(1):vind1(1)))
figure('Name','Number 1');imshow(Ibmirror1(:,vind2(1):vind1(2)))
figure('Name','Number 2');imshow(Ibmirror1(:,vind2(2):vind1(3)))
figure('Name','Number 3');imshow(Ibmirror1(:,vind2(3):vind1(4)))
figure('Name','Number 4');imshow(Ibmirror1(:,vind2(4):q1(end)))

clear q1 q2 vind1 vind2

q1=find(Vsum2>0);        % find the valid image content in the first row of the image column by column
q2=find(diff(q1)>1);     % find the end point of the first column of first row of the image 
vind1=q1(q2);            % index of end point of each column
vind2=q1(q2+1);          % index of starting point of each column exept the first column


%%% extract each number from the second row
%%%% resize the image matrix to the size of [30 30}
%%%%% reshape the matrix into the form of [900 1]
N5=reshape(imresize(Ibmirror2(:,q1(1):vind1(1)),[30 30]),900,1);
N6=reshape(imresize(Ibmirror2(:,vind2(1):vind1(2)),[30 30]),900,1);
N7=reshape(imresize(Ibmirror2(:,vind2(2):vind1(3)),[30 30]),900,1);
N8=reshape(imresize(Ibmirror2(:,vind2(3):vind1(4)),[30 30]),900,1);
N9=reshape(imresize(Ibmirror2(:,vind2(4):q1(end)),[30 30]),900,1);

%%% Show extracted numbers from the image
figure('Name','Number 5');imshow(Ibmirror2(:,q1(1):vind1(1)))
figure('Name','Number 6');imshow(Ibmirror2(:,vind2(1):vind1(2)))
figure('Name','Number 7');imshow(Ibmirror2(:,vind2(2):vind1(3)))
figure('Name','Number 8');imshow(Ibmirror2(:,vind2(3):vind1(4)))
figure('Name','Number 9');imshow(Ibmirror2(:,vind2(4):q1(end)))

save SOM_datafile N0 N1 N2 N3 N4 N5 N6 N7 N8 N9
