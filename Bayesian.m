% data_proc.m
% input: row vector data and labels
% output: data after delete and col index which have been delete
function [output,position] = data_proc(data,label)
position = cell(1,10); % store delete index in each class
for i = 0:9
    temp = [];
    pos = [];
    for rows = 1:size(data,1)
        if label(rows) == i
            temp = [temp;data(rows,:)];
        end
    end
    for cols = 1:size(data,1)
        var_data = var(temp(:,cols));
        if var_data == 0
            pos = [pos,cols];
        end
    end
    position{i+1} = pos;
    data(:,pos) = [];
end
output = data;
end

% Bayesian.m
clear
clc
load('../test_images.mat');
load('../test_labels.mat');
load('../train_images.mat');
load('../train_labels.mat');
train_num = 2000;
test_num = 200;
data_train = mat2vector(train_images(:,:,1:train_num),train_num);
data_test = mat2vector(test_images(:,:,1:test_num),test_num);
[data_train,position] = data_proc(data_train,train_labels1(1:train_num)');
for rows = 1:10
    data_test(:,position{1,rows}) = [];
end

nb_model = fitcnb(data_train,train_labels1(1:train_num));
result = predict(nb_model,data_test);
result = result';
fprintf('predicted result:');
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