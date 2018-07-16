%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% file_to_shingles
%
% (path) -> [shingles]
% 
% Given the path to a file, reads that file and converts it into a sequence
% of 10-character shingles.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [shingles] = file_to_shingles(path)

SHINGLE_SIZE = 4;%10;
JUMP_SIZE = 2;%1;

file = fopen(path);
if (file == -1) 
    shingles = [];
    return;
end

file_index = 0;
shingle_index = 1;

while (~feof(file) && file_index < 1850)%18500
    fseek(file, file_index, 'bof');
    
    [data,count] = fscanf(file, '%c', [1 SHINGLE_SIZE]);
    
    if (count == SHINGLE_SIZE)
        shingles(shingle_index, :) = data;
    else
        break;
    end
    shingle_index = shingle_index + 1;
    file_index = file_index + JUMP_SIZE;
 end
 
fclose(file);

end