%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% TEST_AUX_underlying_hash_function
%
% (X, sel) -> [Y]
% 
% Returns a matrix Y, with the same number of lines as X, with each
% corresponding element hashed, either using string2hash (sel == 0) or
% using DataHash (sel != 0).
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Y] = TEST_AUX_underlying_hash_function(X, sel)

if (length(X) > 1)
    for i=1:size(X, 1)
        
        if (sel == 0)
            Y(i, :) = string2hash(X(i, :));
        else
            Y(i, :) = DataHash(X(i, :));
        end
        
    end
else
    if (sel == 0)
        Y = string2hash(X);
    else
        Y = DataHash(X);
    end
end