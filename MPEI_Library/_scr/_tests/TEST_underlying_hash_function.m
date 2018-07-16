%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% TEST_underlying_hash_function
% 
% Compares hashing results from string2hash and DataHash (concretely the 
% number of colisions) in order to determine the best (underlying) hash 
% function.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; close all;

% generate test shingles with words from English, Portuguese, French and
% German (between 200 and 300 words from each language)
test_shingles = file_to_shingles('random_words.txt');

% test string2hash
fprintf('---------------------------------------------------string2hash\n')

tic
[Y_s2h] = TEST_AUX_underlying_hash_function(test_shingles, 0);
toc

fprintf('Percentage of colisions using string2hash: %3.3f%%\n\n', (size(unique(Y_s2h), 1)/size(Y_s2h, 1))*100)



% test DataHash
fprintf('------------------------------------------------------datahash\n')

tic
[Y_dh] = TEST_AUX_underlying_hash_function(test_shingles, 1);
toc

fprintf('Percentage of colisions using datahash: %3.3f%%\n\n', (size(unique(Y_dh), 1)/size(Y_dh, 1))*100)
%fprintf('----------------------------------------------\n')

fprintf('--------------------------------------13 first datahash digits\n')
[Y_d13h] = Y_dh(:, 1:13);

fprintf('Percentage of colisions using datahash: %3.3f%%\n', (size(unique(Y_d13h), 1)/size(Y_d13h, 1))*100)