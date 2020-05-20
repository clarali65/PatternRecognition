% mat2vector.m
% input:image data(matrix), numbers of sample
% output:numbers of sample*numbers of pixel in each picture dimensional
% matrix

function [data_] = mat2vector(data,num)
[row,col,~]=size(data);
data_=zeros(num,row * col);
for page = 1:num
    for rows = 1:row
        for cols = 1:col
            data_(page,((rows-1)*col)+cols) = im2double(data(rows,cols,page));
        end
    end
end

% Template_hand.m
clear all
clc
% load template
image = cell(1,10); % 10 templates
for i = 0:9
    filename = sprintf('../handwritten/%d/2.bmp',i);
    image{1,i+1} = mat2vector(imresize(imread(filename),[28,28]),1);
end

correct_num = 0;
for index = 0:9 % each test sample
    distance = zeros(1,10);
    fname = sprintf('../handwritten/%d/4.bmp',index);
    sample = mat2vector(imresize(imread(fname),[28,28]),1);
    for j = 1:10 % for each template
        distance(j) = pdist2(sample,image{1,j},'euclidean');
    end
    [m,p] = min(distance);
    if p-1 == index
        correct_num = correct_num + 1;
    end
    fprintf('the minimum distance of number %d to template is %d, matched template is: %d\n',[index,m,p-1]);
end
fprintf('10 tested samples, the number of correctable matched template is %d',[correct_num]);