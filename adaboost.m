%Adaboost.m
clear variables
clc

load ('../test_images.mat');
load ('../test_labels.mat');
load ('../train_images.mat');
load ('../train_labels.mat');
train_num = 2000;
test_num = 200;
data_train = mat2vector(train_images(:,:,1:train_num),train_num);%images to vectors
data_test = mat2vector(test_images(:,:,1:test_num),test_num);
 
% choose decision tree as base classifier for better comparison with random forest
% split upper bound is 10 in each node
t = templateTree('MaxNumSplits',10);
mod = fitcensemble(data_train,train_labels1(1:train_num),'Method','AdaBoostM2','Learners',t);
result = predict(mod,data_test);
acc = 0.;
for i = 1:test_num
    if result(i)==test_labels1(i)
        acc = acc+1;
    end
end
fprintf('accuracy: %5.2f%%\n',(acc/test_num)*100);