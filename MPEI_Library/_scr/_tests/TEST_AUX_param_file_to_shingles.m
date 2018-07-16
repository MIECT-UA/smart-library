%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% TEST_AUX_file_to_shingles
%
% (path) -> [shingles]
% 
% Given the path to a file, reads that file and converts it into a sequence
% of shingle_size-character shingles, with a distance of shingle_jump_size
% between them.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [shingles] = TEST_AUX_param_file_to_shingles(path, shingle_size, shingle_jump_size)

SHINGLE_SIZE = shingle_size;
JUMP_SIZE = shingle_jump_size;

file = fopen(path);
if (file == -1) 
    shingles = [];
    return;
end

index = 0;

while (~feof(file) && index < 18500)
    fseek(file, index, 'bof');
    
    [data,count] = fscanf(file, '%c', [1 SHINGLE_SIZE]);
    
    if (count == SHINGLE_SIZE)
        shingles(index+1, :) = data;
    else
        break;
    end
    
    index = index + JUMP_SIZE ;
 end
 
fclose(file);

end