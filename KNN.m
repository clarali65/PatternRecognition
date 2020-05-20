% KNN.m
clc
clear variables
load('../test_images.mat');
load('../test_labels.mat');
load('../train_images.mat');
load('../train_labels.mat');
train_num = 2000;
test_num = 200;
data_train = mat2vector(train_images(:,:,1:train_num),train_num);
data_test = mat2vector(test_images(:,:,1:test_num),test_num);
knn_model = fitcknn(data_train,train_labels1(1:train_num),'NumNeighbors',20);
result = predict(knn_model,data_test);
acc = 0.;
for i = 1:test_num
    if result(i) == test_labels1(i)
        acc = acc + 1;
    end
end
fprintf('accuracy:%5.2f%%\n',(acc/test_num)*100);