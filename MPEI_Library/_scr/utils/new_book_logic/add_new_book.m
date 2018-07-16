%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% add_new_book
%
% (bookpath, hashes_num, lib_bf, ref_count_bf, library) -> [language, subject, lib_bf]
% 
% Adds a new book to the library.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [language, subject, lib_bf] = add_new_book(bookpath, hashes_num, lib_bf, ref_count_bf, library)

b = msgbox('Adding book to the library...');

% Check if book is present in the library
if (book_is_in_library(bookpath, lib_bf, hashes_num))
    [language, subject] = get_lang_subj_from_lib_book(bookpath, library);
    
    if (language) 
        % only returns if this was not a false positive, otherwise, it
        % doesn't return and treats the book as a new book
        return;
    end
end

%% If book is not present in the library
% Estimate book's language
fprintf('Estimate book language');
tic
language = estimate_language(bookpath, library);
toc

% Estimate book's subject
fprintf('Estimate book subject');
tic
subject = estimate_subject(bookpath, language, hashes_num, ref_count_bf, library);
toc

% Add book to library's bloom filter
fprintf('Add book to bloom filter');
tic
lib_bf = add_book_bf(bookpath, lib_bf, hashes_num);
toc
save lib_bf lib_bf

% and to the 'library' itself
fprintf('Adding to the library');

% get book's filename (the last part of the path, after the last '/')
bookname = strsplit(bookpath, '/');
bookname = bookname{length(bookname)};

language_map = library(language);
subject_books = language_map(subject);
subject_books{length(subject_books)+1} = bookname;

language_map(subject) = subject_books;
library(language) = language_map;
save library library

% finally, copy to file to its new home
dest_folder = strcat('../', language, '/', subject, '/');
copyfile(bookpath, dest_folder);

close b