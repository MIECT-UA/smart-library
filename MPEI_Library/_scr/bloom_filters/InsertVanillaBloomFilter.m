%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% InsertVanillaBloomFilter
% 
% Adds a key to the Bloom Filter
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ BloomFilter ] = InsertVanillaBloomFilter (BloomFilter, key, k)
    m = length(BloomFilter);
    
    % Using string2hash 
    % which is faster according to tests done to counting bloom filter
    h = rem(n_independent_hashes(key, k), m) + 1;
    
    BloomFilter(h) = 1;
end