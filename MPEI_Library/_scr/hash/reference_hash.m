%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% reference_hash
% 
% (X, hashes_num) -> [Y]
%
% Returns a matrix Y, with 'hashes_num' times the number of lines of X,
% with each corresponding element hashed 'hashes_num' times, using a map
% for each shingle, to prevent hashing the same shingle more than
% 'hashes_num' times.
% 
% Note: see TEST_hash_function for a justification for the choice of
% hash_function's sel parameter
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function shinglemap = reference_hash(X, hashes_num)


% Load map if it already exists in memory
if exist('shinglemap.mat', 'file')
    load shinglemap
else
    shinglemap = containers.Map;
end

% Populate map with given shingles
for i=1:size(X, 1)
    if (~isKey(shinglemap, X(i,:)))
        shinglemap(X(i,:)) = xor_hashes(X(i,:), hashes_num);
    end
end

% Save map
save shinglemap shinglemap