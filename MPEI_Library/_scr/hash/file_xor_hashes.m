%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% file_xor_hashes
% 
% (file_path, hashes_num) -> [Y]
%
% Returns a matrix Y, with 'hashes_num' lines, using DataHash and bitwise
% exclusive ORs.
% Variant of xor_hashes.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function Y = file_xor_hashes(file_path, hashes_num)

% get randomly distributed numbers
rng(1)
rand_num = ceil(rand(hashes_num, 1)*2353786531954283);
xor_numbers = dec2base(rand_num, 16);

% get file's hash
Opt.Input = 'File';
hash = DataHash(file_path, Opt);
split_hash = hash(:, 1:13);
    
% generate hashes_num-1 new hashes from the original
index = 1;
Y(index, :) = split_hash(index, :);

for j=1:hashes_num-1   
    data =  dec2hex(bitor(hex2uint64(xor_numbers(j, :)), hex2uint64(split_hash(index, :)), 'uint64'));
    while (size(data, 2) < 13)
        data = [0 data];
    end
    Y(index+j,:) = data;
end

index = index + hashes_num;