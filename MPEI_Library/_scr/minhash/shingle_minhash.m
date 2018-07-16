%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% shingle_minhash
%
% (file_1_shingles, file_2_shingles, hashmap, N, hashes_num) -> [similarity]
% 
% Returns the similarity (aproximately 1 - Jaccard Distance) between two
% given sets of shingles, through the minash algorithm, using N of
% hashes_num independent hash functions. Assumes all shingles are hashed.
% Variant of minhash.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function similarity = shingle_minhash(file_1_shingles, file_2_shingles, hashmap, N, hashes_num)

% generate n entries out of the available hashes_num hash functions
entries = randperm(hashes_num, N);

equal_lines = 0;

% for n entries
for i=1:length(entries)

    % for each shingle in the document, for n-th hash fuction get
    % document-level minimum
    file_1_min = document_min_nth_hash(file_1_shingles, hashmap, entries(i));
    
    
    % do the same for a second file
    file_2_min = document_min_nth_hash(file_2_shingles, hashmap, entries(i));
    
    if (file_1_min == file_2_min)   
        equal_lines = equal_lines + 1;
    end
end

similarity = equal_lines/N;


