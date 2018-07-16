%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% TEST_AUX_hash_function
% 
% (X, sel, hashes_num) -> [Y]
%
% Returns a matrix Y, with 'hashes_num' times the number of lines of X,
% with each corresponding element hashed 'hashes_num' times, either using
% n_independent_hashes (sel == 0), or xor_hashes (sel != 0).
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Y = TEST_AUX_hash_function(X, sel, hashes_num)

if (sel == 0)
    Y = n_independent_hashes(X, hashes_num);
else
    Y = xor_hashes(X, hashes_num);
end