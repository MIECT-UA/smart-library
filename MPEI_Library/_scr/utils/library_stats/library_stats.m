%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% library_stats
% 
% (library, ref_count_bf) -> [library_size, biggest_lang, top_words, top_subject]
%
% Returns the library's statistics:
%   - library_size : number of files in the library (number);
%   - biggest_lang : the most populated language in the library (string);
%   - top_subject  : the most populated subjects for each language (cell array);
%   - top_words    : the most common word of a randomly chosen file for each
%                     language (cell array).
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [library_size, biggest_lang, top_subject, top_words] = library_stats(library, ref_count_bf)

% setup variables
library_size = 0;

% get languages in library
languages = library('languages');
language_num = length(languages);

% setup remaining variables
top_words = cell(language_num, 1);
top_subject = cell(language_num, 1);
books_in_language = zeros(language_num, 1); % variable for the number of
                                            % books in each subject

% for each language
for i=1:language_num
    
    language = languages{i};
    
    % get subjects
    language_map = library(language);
    subjects = language_map('subjects');
    subjects_num = length(subjects);
    
    % variable for the number of books in each subject
    books_in_subject = zeros(subjects_num, 1);
    
    % for each subject
    for j=1:subjects_num
        
        subject = subjects{j};
        
        % get number of books in the subject
        books_num = length(language_map(subject));
        
        % update variables with subject's books number
        library_size = library_size + books_num;
        books_in_language(i, :) = books_in_language(i, :) + books_num;
        books_in_subject(j, :) = books_in_subject(j, :) + books_num;
    end
    
    [~, max_subject_index] = max(books_in_subject);
    top_subject{i} = subjects{max_subject_index};
    
    top_words{i} = get_random_top_word(language, ref_count_bf, library);
end

[~, max_lang_index] = max(books_in_language);
biggest_lang = languages{max_lang_index};

