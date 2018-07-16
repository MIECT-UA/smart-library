%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% xor_hashes
% 
% (X, hashes_num) -> [Y]
%
% Returns a matrix Y, with 'hashes_num' times the number of lines of X,
% with each corresponding element hashed 'hashes_num' times, using one hash
% function (DataHash) and bitwise exclusive ORs.
% 
% Note: see TEST_underlying_hash_function for a justification for the
% choice of DataHash over string2hash
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function Y = xor_hashes(X, hashes_num)

% generate randomly distributed numbers
rng(1)
rand_num = ceil(rand(hashes_num, 1)*2353786531954283);
xor_numbers = dec2base(rand_num, 16);

% get hashes of all lines of X
hash = enhanced_datahash(X); % more efficient than underlying_hash_function
split_hash = hash(:, 1:13);

% for each line of X, generate hashes_num-1 new hashes
index = 1;
for i=1:size(X, 1)
    
    Y(index, :) = split_hash(i, :);
        
    for j=1:hashes_num-1   
        data =  dec2hex(bitor(hex2uint64(xor_numbers(j, :)), hex2uint64(split_hash(i, :)), 'uint64'));
        while (size(data, 2) < 13)
            data = [0 data];
        end
        Y(index+j,:) = data;
    end
    
    index = index + hashes_num;
end

% for reference, variables' size
% size(rand_num)        %       hashes_num      x 1
% size(xor_numbers)     % size(X, 1)*hashes_num x 13
% size(hash)            %      size(X, 1)       x 32
% size(split_hash)      %      size(X, 1)       x 13