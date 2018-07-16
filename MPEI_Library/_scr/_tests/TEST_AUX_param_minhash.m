%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% TEST_AUX_param_minhash
%
% (file_1_path, file_2_path, N, hashes_num, shingle_size, 
%                                        shingle_jump_size) -> [similarity]
% 
% Returns the similarity (aproximately 1 - Jaccard Distance) between two
% given files. 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function similarity = TEST_AUX_param_minhash(file_1_path, file_2_path, N, hashes_num, shingle_size, shingle_jump_size)

% garantee all shingles are hashed
file_1_shingles = TEST_AUX_param_file_to_shingles(file_1_path, shingle_size, shingle_jump_size);
reference_hash(file_1_shingles, hashes_num);
file_2_shingles = TEST_AUX_param_file_to_shingles(file_2_path, shingle_size, shingle_jump_size);
hashmap = reference_hash(file_2_shingles, hashes_num);


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


