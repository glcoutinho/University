clc
close all

%%dataset management
matlabroot = 'C:\Users\Guilherme\Desktop\CNN\photos\'; % directory

DatasetPath = fullfile(matlabroot, 'Dataset'); % builds a full file specification from the specified folder and its images

Data = imageDatastore(DatasetPath,'IncludeSubfolders', true, 'LabelSource','foldernames'); % manage a collection of the images

valFiles = 4;
[Train] = splitEachLabel(Data,valFiles,'randomize'); % randomly assigns the specified proportion of files from each label to the new datastores.

%Diplaying Training Images
for i = 1:4
    a = readimage(Train,i);
    figure (1),
    subplot (2,2,i)
    imshow(a)
    title('Training Images')
end

%%Define The Network Layers
%CNN layers, architecture.

layers1 = [imageInputLayer([300 150 3])      % returns an image input layer and specifies the InputSize

        convolution2dLayer(5,20)             % applies sliding convolutional filters to the input 
        reluLayer                            % Rectified Linear Unit (ReLu) sets threshold and minimizes small input to 0
        maxPooling2dLayer(2,'Stride',2)      % Down-sampling by dividing the input into rectangular pooling regions

        convolution2dLayer(5,20)
        reluLayer
        maxPooling2dLayer(2,'Stride',2)
        
        dropoutLayer                         % Prevents overfitting on the training data

        convolution2dLayer(5,20)        
        reluLayer        
        maxPooling2dLayer(2,'Stride',2)
        
        dropoutLayer

        fullyConnectedLayer(100)            % Multiplies the input by a weight matrix
        
        reluLayer
        
        fullyConnectedLayer(3)              % outputsize
        
        softmaxLayer                        % multi-class classification      
        classificationLayer()];
    
option = trainingOptions('adam','MaxEpochs',40, ...         % Monitors Deep Learning Training Progress
    'InitialLearnRate',0.0001,'Plots','training-progress');

% training
convnet = trainNetwork(Data,layers1,option);        %ADAM optimizer

%%Classify the Images in Test Data and Compute Accuracy
%testing

allclass=[];

valFiles = 2;
[imdsValidation] = splitEachLabel(Data,valFiles,'randomize');

%loading of the validation images
inp1=imread('C:\Users\Guilherme\Desktop\CNN\photos\VALDIATION_IMG\CONTROL.jpg');
figure,imshow(inp1);     %plot the images

out=classify(convnet,inp1); %classification

labelW = predict(convnet,inp1); %compute accuracy



msgbox(char(out)) %plot the sleep stages classification
