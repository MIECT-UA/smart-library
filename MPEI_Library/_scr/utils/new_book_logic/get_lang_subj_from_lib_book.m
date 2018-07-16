%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% get_lang_subj_from_lib_book
%
% (bookpath, library) -> [language, subject]
% 
% Returns the language and subject for a book inside the library. Returns
% empty language and subject strings ('') if the book is not found.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [language, subject] = get_lang_subj_from_lib_book(bookpath, library)

% get book's filename (the last part of the path, after the last '/')
bookname = strsplit(bookpath, '/');
bookname = bookname{length(bookname)};

languages = library('languages');
languages_num = length(languages);

% for each language in the library
for i=1:languages_num
    
    language = languages{i};
    language_map = library(language);
    subjects = language_map('subjects');
    subjects_num = length(subjects);
    
    % for each subject
    for j=1:subjects_num
        subject = subjects{j};
        subject_books = language_map(subject);
        
        % if the book belongs to that language and subject, return
        if any(strcmp(subject_books, bookname))
            return;
        end
    end
end

% return empty values for language and subject if book was not found
language = '';
subject = '';