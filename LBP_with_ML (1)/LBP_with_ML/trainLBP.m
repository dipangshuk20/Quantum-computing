clc;
clear all;
close all;
digitDatasetPath = fullfile("D:\My Files\Tezpur University\Sem 8\Project Stage-2\lbp\train_sub_5images");
imds = imageDatastore(digitDatasetPath, 'IncludeSubfolders',true, 'LabelSource','foldernames');
tbl = countEachLabel(imds);
%labels = unique(imds.Labels,'stable');
figure
montage(imds.Files(1:6:end))

%prepare training image sets
[trainSet, validSet] = splitEachLabel(imds, 0.6, 'randomize');

%feature extraction
extractorFcn = @localBinary;
bag = bagOfFeatures(trainSet,'CustomExtractor',extractorFcn);

img = readimage(imds, 1);
featureVector = encode(bag,img);

figure
bar(featureVector)
%opts = templateSVM('BoxConstraint',1.1,'KernelFunction','gaussian');
%categoryClassifier = trainImageCategoryClassifier(trainSet, bag,'LearnerOptions',opts);
categoryClassifier = trainImageCategoryClassifier(trainSet, bag);

%evaluate performance
confMatrix = evaluate(categoryClassifier, trainSet);

confMatrix = evaluate(categoryClassifier, validSet);

mean(diag(confMatrix));

%Testing
img = fullfile("D:\My Files\Tezpur University\Sem 8\Project Stage-2\lbp\test");
data = imageDatastore(img, 'IncludeSubfolders',true, 'LabelSource','foldernames');
correct = 0;
for i = 1:1:9   
    %figure
    %montage(data.Files(i))
    image = imread(data.Files{i});
    [labelIdx, scores] = predict(categoryClassifier, image);
    prediction = categoryClassifier.Labels(labelIdx);
    %disp(prediction);
    if prediction == 'subject_0'+string(i)
        correct = correct + 1;
    end
end

fprintf("Total no. of Test Images = 9\n");
fprintf("No. of Correct Predictions = %d\n", correct);
fprintf("Test Accuracy = %f\n", correct/9);