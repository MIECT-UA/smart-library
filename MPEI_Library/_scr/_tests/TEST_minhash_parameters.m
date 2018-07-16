%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% TEST_minhash_parameters
%
% Tests how the similarity between two given files varies according to
% diferent shingle sizes and shingle distances. 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;  close all;

shingle_size = [4 5 6 7 8];
shingle_jump_size = [1 2 3];

similarity = zeros(length(shingle_size), length(shingle_jump_size));

tic
for i=1:length(shingle_size)
    for j=1:length(shingle_jump_size)
        similarity(i,j) = TEST_AUX_param_minhash('weather_1.txt', ...
            'ml_1.txt', ...
            10, 10, shingle_size(i), shingle_jump_size(j));
    end
end
toc
