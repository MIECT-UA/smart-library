%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% minhash
%
% (file_1_path, file_2_path, N, hashes_num) -> [similarity]
% 
% Returns the similarity (aproximately 1 - Jaccard Distance) between two
% given files, through the minash algorithm, using N of hashes_num
% independent hash functions. 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function similarity = minhash(file_1_path, file_2_path, N, hashes_num)

% garantee all shingles are hashed
file_1_shingles = file_to_shingles(file_1_path);
reference_hash(file_1_shingles, hashes_num);
file_2_shingles = file_to_shingles(file_2_path);
hashmap = reference_hash(file_2_shingles, hashes_num);

% get similarity between the two files
similarity = shingle_minhash(file_1_shingles, file_2_shingles, hashmap, N, hashes_num);


