%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Count
%
% Returns the (minimum) number of occurrences of a key in the bloom filter
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ value ] = Count (BloomFilter, key, k)
    m = length(BloomFilter);
    
    % Using xor_hashes
    % h = rem(hex2dec(xor_hashes(key , k)), m) + 1;
    
    % Using string2hash
    h = rem(n_independent_hashes(key, k), m) + 1;
    
    values = BloomFilter(h);
    value = min(values);
end

