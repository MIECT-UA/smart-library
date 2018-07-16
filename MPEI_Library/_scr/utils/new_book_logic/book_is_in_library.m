%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% book_is_in_library
% 
% (filepath, BloomFIlter) -> is_in_library (0 : false, 1: true) 
% Verify if a file belongs to the bloom filter 
% representative of the library contents
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [is_in_library] = book_is_in_library(filepath, BloomFilter, k)
    % by definition belongs
    is_in_library = 1;

    % Verify if the bloom filter contains the file represented by its hash
    % Not using verify function since it's using datahash for the whole
    % file and not String2Hash for each word, since two files can have the
    % same words and not be the same file
    m = length(BloomFilter);
    h = rem(file_xor_hashes(filepath, k), m) + 1;

    if BloomFilter(h) == 0
        is_in_library = 0;
        return;

    end
end