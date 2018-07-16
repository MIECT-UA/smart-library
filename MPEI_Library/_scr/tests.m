%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% tests
% 
% Runs the tests Library application.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;

%% Tests for hash functions
fprintf('\nTests for hash functions\nCompares hashing results in order to determine the best hash function and the best number of hash functions\n')
%TEST_hash_function                       %uncomment to run
TEST_underlying_hash_function

%% Tests for bloom filters
fprintf('\n=====================================================================\nTests for hash functions\nPrints the results of analyzing a file using a bloom filter, a counting bloom filter and a Map structure (with the theoretical values)\n')
TEST_bloom_filters

%% Tests for minhash
%fprintf('\nTests for minhahs parameters\nTests how the similarity between two given files varies according to diferent shingle sizes and shingle distances\n')
%TEST_minhash_parameters             %uncomment to run
