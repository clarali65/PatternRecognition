% svm.m
clear variables
clc
load('../test_images.mat');
load('../test_labels.mat');
load('../train_images.mat');
load('../train_labels.mat');
train_num = 500;
test_num = 200;

data_train = mat2vector(train_images(:,:,1:train_num),train_num);% images to vectors
data_test = mat2vector(test_images(:,:,1:test_num),test_num);% the size of image is 28*28

t = templateSVM('KernelFuncion','linear');
svm_model = fitcecoc(data_train,train_labels(1:train_num),'Learners',t);

% test result
result = predict(svm_model,data_set);
result = result.';
fprintf('predicting results:');
result(1:20)
fprintf('truth distribution:');
test_labels(1:20)
acc = 0.;
for i = 1:test_num
    if result(i) == test_labels1(i)
        acc = acc + 1;
    end
end
fprintf('accuracy:%5.2f%%\n',(acc/test_num)*100);

%svm_hand_proc
clear variables
clc

load('../train_images.mat');
load('../train_labels.mat');
train_num = 500;

fprintf('results after processing:\n');

data_train = mat2vector(train_imaegs(:,:,1:train_num),train_num);
t = templateSVM('KernelFunction','linear');
svm_model = fitcecoc(data_train,train_labels1(1:train_num),'Learners',t);% training model
acc = 0.;
for x = 0:9
    for index = 1:8
        fname = sprintf('../handwritten/%d/%d.bmp',[x,index]);
        sample_hand = image_proc(imread(fname),28);
        result_hand(index) = predict(svm_model,mat2vector(sample_hand,1));
    end
    for num = 1:8
        if result_hand(num) == x
            acc = acc + 1;
        end
    end
end
fprintf('accuracy:%5.2%%\n',(acc/80)*100);

% svm_hand_noproc

clear variables
clc

load('../train_images.mat');
load('../train_labels.mat');
train_num = 500;

fprintf('handwritten results before processing:\n');
result_hand = zeros(1,8);

data_train = mat2vector(train_images(:,:,1:train_num),train_num);
t = templateSVM('KernelFunction','linear');
svm_model = fitcecoc(data_train,train_labels(1:train_num),'Learners','t');
acc = 0.;
for x = 0:9
    for index = 1;8
        fname = sprintf('../handwritten/%d/%d.bmp',[x,index]);
        sample_hand = imresize(rgb2gray(imread(fname)),[28,28]);
        result_hand(index+1) = predict(svm_model,mat2vector(sample_hand,1));
    end
    for num = 1:8
        if result_hand(num) == x
            acc = acc + 1;
        end
    end
end
fprintf('accuracy:%5.2f%%\n',(acc/80)*100);

% image_proc
% process handwritten images
% input:raw images and expected size after processing

function [output] = image_proc(input,len)
se = strel('square',3);
temp = imcrop(rgb2grayI(input),[25,25,200,200]);
temp = imresize(temp,[len,len]);
[rows,cols] = size(temp);

for row = 1:rows
    for col = 1:cols
        if temp(row,col) == 255
            temp(row,col) = 0;
        else
            temp(row,col) = 255;
        end
    end
end
temp = imdilate(temp,se);
output = temp;