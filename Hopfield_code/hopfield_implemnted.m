%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	Name: 	Eng. Turky Abdulaziz Abdulhafiz Saderaldin
%	ID:		1300388
%	Homwork #4 (resubmitted)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
close all
clear all

% % % %  Training
N=10;                           % nummber of images
M=60;                           % size of image MxM
data=zeros(M^2,M^2);
image_threshold=[];
for i=1:N
    name = sprintf('mark%d.jpg',i);
    I=imread(name);
    image_bw=im2bw(I);          % Convert the image to binary
    Hsum1=sum(image_bw,2);      % find the valid features in the image on X-axis
    Vsum1=sum(image_bw,1);      % find the valid features in the image on Y-axis
    h1=find(Hsum1>0);           % find the face on hrizontal axis
    h2=find(diff(h1)>1);        % find the edge on X-axis
    v1=find(Vsum1>0);           % find the face on vertical axis
    v2=find(Vsum1(v1)>1);       % find the edge on Y-axis
    face_image=image_bw(h1,v1); % extract the features
    image_resized=imresize(face_image,[M M]);       % resize the B/W image to prepare data for Hopfield NN
    image_vector=reshape(image_resized,M^2,1);      % reshape n*n matrix to be n^2*1 column
    image_threshold=[image_threshold image_vector]; % save image vector for threshold calculation
    image_data=2*double(image_vector)-1;     % mapping from [0 1] to [-1 1]
    tmp_data=image_data*image_data';
    data=data+tmp_data;                             % save data vector in a column in matrix (data)
end
tmp_w=data;         % calculate wieght for every image data
I=~eye(M^2);        % calculate inverse of Identity Matrix
tmp_w=tmp_w.*I;     % remove diagonal
W=tmp_w/(M^2);      % divide by the number of neurons

% % % % Testing
clear h1 h2 v1 v2
TestImage_original=imread('mark11.jpg');   % Read the image
TestImage_bw=im2bw(TestImage_original);         % Convert the image to binary
figure('Name','Testing Image Original');        % Draw a figure
imshow(TestImage_original);                     % Show the original image
Hsum2=sum(TestImage_bw,2);                      % find the valid features in the image on X-axis
Vsum2=sum(TestImage_bw,1);                      % find the valid features in the image on Y-axis
h1=find(Hsum2>0);                               % find the face on hrizontal axis
h2=find(diff(h1)>1);                            % find the edge on X-axis
v1=find(Vsum2>0);                               % find the face on vertical axis
v2=find(Vsum2(v1)>1);                           % find the edge on Y-axis
tmp_image=TestImage_bw(h1,v1);                  % use a copy of the image
tmp_image_resized=imresize(tmp_image,[M M]);    % resize the B/W image to prepare data for Hopfield NN
tmp_image_reshaped=reshape(tmp_image_resized,M^2,1);    % reshape n*n matrix to be n^2*1 column
x=2*double(tmp_image_reshaped)-1;               % mapping from [0 1] to [-1 1]
images_threshold_vector=sum(image_threshold,1); 
y=zeros(size(x));                               % initialize output
con=1;                                          % initialize convergence indecator
iteration=1;
while con
    for i=1:length(W)
        yin(i)=x(i)+y'*W(:,i);                  % test input data x element by element
        if yin(i)>0                             % check if the input close to the real data
            y(i)=1;                             % set output
        end
    end
    c=abs(sum(y)-images_threshold_vector);
    for j=1:N
        %%% check if the difference between the output and the real data is
        %%% within the threshold the convergence loop reaches the maximum
        %%% iteration of 50
        if c(j)<120
            con=0;                              % if this is the case stop the convergence loop
            Ynew=reshape(y,M,M);                            % Restore column to a matrix in order to display it
            figure('Name','Hopfield Testing Image ');       % Draw a figure
            reversed_size2=imresize(Ynew,size(tmp_image));  % Scale the out put image
            imshow(reversed_size2);                         % show the Hopfield image.
            break;
        end
    end
    if iteration == 100
        con=0;
    end
    iteration=iteration+1;
end

if (iteration-1)==100
    disp('Could not recognize the image');
else
    [r,m]=min(c);
    disp('recognized image is ');
    disp(m);
    disp('number of iteration ');
    disp(iteration-1);
end
