%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% n_independent_hashes
% 
% (X, hashes_num) -> [Y]
%
% Returns a matrix Y, with 'hashes_num' times the number of lines of X,
% with each corresponding element hashed 'hashes_num' times, using n
% independent hash functions.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Y = n_independent_hashes(X, hashes_num)

index = 0;

for i=1:size(X, 1)
    
    for j=1:hashes_num

        % create unique string
        unique_el = [ X(i,:) num2str(j^3) ];

        %Y((index + j), :) = underlying_hash_function(unique_el, 1);
        Y((index + j), :) = string2hash(unique_el); % more efficient
        
    end
    
    index = index + hashes_num;
    
end