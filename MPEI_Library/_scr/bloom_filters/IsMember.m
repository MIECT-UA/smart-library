%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% IsMember
% 
% Verify if a key belongs to the bloom filter
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ contains ] = IsMember (BloomFilter, key, k)
    m = length(BloomFilter);
    contains = 1;

    % Using string2hash 
    % which is faster according to tests done to counting bloom filter
    h = rem(n_independent_hashes(key, k), m) + 1;
    
    if BloomFilter(h) == 0
        contains = 0;
        return;
    end
end

