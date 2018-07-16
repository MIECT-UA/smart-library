%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% init_shinglemap
% 
% (library, force_reset) -> [shinglemap]
%
% Creates a map for every shingle of every file in the library.
% 'force_reset' forces the redoing of this map, even if a saved instance of
% it already exists.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function shinglemap = init_shinglemap(library, force_reset)


if (exist('shinglemap.mat', 'file') && ~force_reset)
    load shinglemap
else
    
    shinglemap = containers.Map;
    languages = library('languages');
    
    for i=1:length(languages)
        
        language = char(languages{i});
        language_map = library(language);
        
        fprintf('%s\n', language);
        
        % get subjects 
        subjects = language_map('subjects');
        
        for j=1:length(subjects)
        
            subject = subjects{j};
            books = language_map(subject);
            
            fprintf('\t%s\n', subject);
            
            for k=1:length(books)
                book = books{k};       
                fprintf('\t\tAdding %s to the library...\n', book);
                
                bookpath = strcat('../', language, '/', subject, '/', book);
                shinglemap = reference_hash(file_to_shingles(bookpath), 50);
            end
            fprintf('\n');
        end
            fprintf('\n\n');
    end
    fprintf('All files added!\n');
    
    save shinglemap shinglemap
end