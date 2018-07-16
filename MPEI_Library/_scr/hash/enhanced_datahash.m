%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% enhanced_datahash
%
% (X) -> [Y]
% 
% Returns a matrix Y, with the same number of lines as X, with each
% corresponding element hashed using DataHash.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Y] = enhanced_datahash(X, sel)

for i=1:size(X, 1)
   Y(i, :) = DataHash(X(i, :));
end