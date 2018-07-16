%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% get_dir_files
% 
% (dir_path) -> [dirfiles]
%
% Returns a cell array with the files inside of a a given directory.
%
% This function was based on get_subfolders, a function created by yuk.
% See https://stackoverflow.com/questions/8748976/list-the-subfolders-in-a-folder-matlab-only-subfolders-not-files
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function dirfiles = get_dir_files(dir_path)

d = dir(dir_path);
files = logical(1 - [d(:).isdir]);
dirfiles = {d(files).name}';

dirfiles(ismember(dirfiles,{'.DS_Store'})) = [];