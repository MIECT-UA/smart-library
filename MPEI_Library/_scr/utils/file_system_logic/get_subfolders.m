%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% get_subfolders
% 
% (dir_path) -> [subfolder]
%
% Returns a cell array with the subfolders of a a given directory. Excludes
% the subfolders '.', '..', and '_scr'.
%
% This function was created by yuk.
% See https://stackoverflow.com/questions/8748976/list-the-subfolders-in-a-folder-matlab-only-subfolders-not-files
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function subfolder = get_subfolders(dir_path)

d = dir(dir_path);
isub = [d(:).isdir];
subfolder = {d(isub).name}';

subfolder(ismember(subfolder,{'.','..','_scr'})) = [];