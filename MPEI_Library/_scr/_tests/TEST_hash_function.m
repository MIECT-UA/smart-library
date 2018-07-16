%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% TEST_hash_function
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

%% TEST HASH FUNCTIONS ALGORITHMS
fprintf('HASH FUNCTIONS ALGORITHMS-------------------------------------\n')

% test n_independent_hashes
% (should take ~2.5 minutes for 50 hash functions, and ~33 minutes for 200
%  hash functions)
fprintf('------------------------------------------n_independent_hashes\n')

tic
[Y_nihf] = TEST_AUX_hash_function(test_shingles, 0, 50);
toc

fprintf('Percentage of colisions using n_independent_hashes: %3.3f%%\n\n', ...
            (size(unique(Y_nihf), 1)/size(Y_nihf, 1))*100)

% test xor_hashes
% (should take ~1.7 minutes for 50 hash functions, and ~18 minutes for 200
%  hash functions)
fprintf('----------------------------------------------------xor_hashes\n')

tic
[Y_xhf] = TEST_AUX_hash_function(test_shingles, 1, 50);
toc

fprintf('Percentage of colisions using xor_hashes: %3.3f%%\n\n', ...
            (size(unique(Y_xhf), 1)/size(Y_xhf, 1))*100)


% test reference_hashing
% (should take ~1.7 minutes for 50 hash functions, and ~18 minutes for 200
%  hash functions)
fprintf('---------------------------------------------reference_hashing\n')

tic
[Y_refh] = reference_hash(test_shingles, 50);
toc

disp(Y_refh)


%%  TEST NUMBER OF HASH FUNCTIONS
hash_num_values = [10,  ... % ~0.3  minutes,
                   20,  ... % ~0.5  minutes,
                   35,  ... % ~1.0  minutes,
                   50,  ... % ~1.7  minutes,
                   100, ... % ~3.0  minutes,
                   150, ... % ~10.3 minutes,
                   200];    % ~17.5 minutes.

fprintf('\nNUMBER OF HASH FUNCTIONS--------------------------------------\n\n')
for i=1:length(hash_num_values)

    fprintf('--------------------------------------------%3d hash functions\n', ...
                hash_num_values(i))
            
    tic
    Y_nhf = TEST_AUX_hash_function(test_shingles, 1, hash_num_values(i));
    toc

    fprintf('Percentage of colisions using %d hash functions: %3.3f%%\n\n', ...
                hash_num_values(i), (size(unique(Y_nhf), 1)/size(Y_nhf, 1))*100)
end