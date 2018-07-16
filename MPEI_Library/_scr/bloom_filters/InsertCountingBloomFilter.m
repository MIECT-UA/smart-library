%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% InsertCountingBloomFilter
% 
% Adds a key to the Counting Bloom Filter
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ BloomFilter ] = InsertCountingBloomFilter (BloomFilter, key, k)
    m = length(BloomFilter);

    % Using xor_hashes 
    % (about 12.8 seconds to create the bloom filter for text random_words.txt)
    % h = rem(hex2dec(xor_hashes(key,  k)), m) + 1;

    % Using string2hash 
    % (much faster, since string2hash is optimized for strings with variable size
    % about 0.6 seconds to create the bloom filter for text random_words.txt)
    h = rem(n_independent_hashes(key, k), m) + 1;
    
    BloomFilter(h) = BloomFilter(h) + 1;
end