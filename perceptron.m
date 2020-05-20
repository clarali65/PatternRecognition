% perceptron.m
clear variables
clc
% load data
load('../test_images.mat');
load('../test_labels.mat');

% setting
train_num = 1000;
test_num = 200;
j = 1;
lr = 0.01; % learning rate
epoch = 10;
number = [8,4];

for i = 1:10000
    if test_labels1(i) == number(1)||test_labels1(i) == number(2)
        data(:,:,j) = test_images(:,:,i);
        label(j) = test_labels1(i);
        j = j + 1;
    if j > train_num + test_num
        break;
    end
    end
end

% transformation of labels

for k = 1:train_num+test_num
    if label(k) == number(1)
        label(k) = -1;
    end
    if label(k) == number(2)
        label(k) = 1;
    end
end

data_ = mat2vector(data,train_num+test_num);
test_data = [data_(train_num+1:train_num+test_num,:),ones(test_num,1)];
w = perceptionLearn(data_(1:train_num,:),label(1:train_num),lr,epoch);

% test
for k = 1:test_num
    if test_data(k,:)*w' > 0
        result(k) = 1
    else
        result(k) = -1;
    end
end

% accuracy
acc = 0;
for sample = 1:test_num
    if result(sample) == label(train_num+sample)
        acc = acc + 1
    end
end
fprintf('accuracy is: %5.2f%%\n',(acc / test_num) * 100);

% perceptionLearn.m
% input:data, label, learning rate, epoch
% output:weight
% training method:fixed learning rate, single sample correction

function [w] = perceptionLearn(x,y,learningRate,maxEpoch)
[rows,cols] = size(x);
x = [x,ones(rows,1)];
w = zeros(1,cols+1);
for epoch = 1:maxEpoch
    flag = true;
    for sample = 1:rows
        if sign(x(sample,:)*w') ~= y(sample)
            flag = false
            w = w + learningRate * y(sample) * x(sample,:)'
        end
    end
    if flag == true
        break
    end
end
end