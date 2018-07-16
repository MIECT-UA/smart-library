%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% add_book_bf
% 
% (filepath, BloomFIlter) -> is_in_library (0 : false, 1: true) 
% Updates the bloom filter representative of the library
% contents by adding the file in filepath
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [BloomFilter] = add_book_bf(filepath, BloomFilter, k)
    % Compute hash for the file
    % Not using insertVanillaBloomFilter function since it's
    % using datahash for the whole file and not String2Hash for each word
    % since two files can have the same words and not be the same file
    m = length(BloomFilter);
    h = rem(file_xor_hashes(filepath, k), m) + 1;

    BloomFilter(h) = 1;

end