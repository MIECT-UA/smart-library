%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% document_min_nth_hash
% 
% (shingles, hashmap, line) -> [min]
%
% Returns the minimum value of the line-th hash function (applied on every
% shingle) of a given document. Assumes shingles have already been hashed.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function min = document_min_nth_hash(shingles, hashmap, line)

not_cell_shingles = ~iscell(shingles);

% get the nth hash value of the first shingle to use as a baseline for the
% minimum value
if(not_cell_shingles)
    aux = hashmap(shingles(1,:));
else
    aux = hashmap(shingles{1});
end
min = hex2uint64(aux(line, :));

% for the remaining shingles, get their nth hash value and compare it with
% the minimum - and if their hash value is smaller, update the minimum
for i=2:length(shingles)

    if(not_cell_shingles)
        aux = hashmap(shingles(i,:));
    else
        aux = hashmap(shingles{i});
    end
    possible_min = hex2uint64(aux(line, :));
    
    if(possible_min < min)
        min = possible_min;
    end
end

