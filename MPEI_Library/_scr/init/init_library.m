%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% init_library
% 
% (force_reset) -> [library]
%
% Creates a map for every file in the library, according to their language
% and subject. 'force_reset' forces the redoing of this map, even if a
% saved instance of it already exists.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function library = init_library(force_reset)


% Get languages in the library
languages = get_subfolders('../');

library = containers.Map;
    

% initialize library with existing files, if not already initialized
if (exist('library.mat', 'file') && ~force_reset)
    load library
else
    
    library('languages') = languages;

    for i=1:length(languages)
        
        language = char(languages{i});
        
        % get subjects 
        language_folder = strcat('../', language);
        subjects = get_subfolders(language_folder);

        % create sub-map for this language
        language_map = containers.Map;
        language_map('subjects') = subjects;

        % for each subject of the language
        for j=1:length(subjects)

            subject = char(subjects{j});

            % add books to subject
            books = get_dir_files(strcat(language_folder, '/', subject));

            % add subject to language
            language_map(subject) = books;
        end
        library(language) = language_map;
    end
    
    save library library
end