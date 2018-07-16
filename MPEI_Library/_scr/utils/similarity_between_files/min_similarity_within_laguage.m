%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% min_similarity_within_laguage
%
% (ref_book, language, library) -> [min_sim, min_book]
% 
% Returns the minimum similarity (aproximately 1 - Jaccard Distance) between
% a given reference file and all files of the given language, through the
% minash algorithm, using N of hashes_num independent hash functions. 
% Counter-part of most_similar_books_within_language.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [min_sim, min_book] = min_similarity_within_laguage(ref_book, language, library)

min_sim = 1; % max similairty possible value
min_book = ref_book;

% get language's subjects
language_map = library(language);
subjects = language_map('subjects');

fprintf('\nReference book: %s\n\n', ref_book);
        
% for every book in the language, 
for j=1:length(subjects)
    subject = subjects{j};
    books = language_map(subject);

    for k=1:length(books)
        book = books{k};
        bookpath = strcat('../', language, '/', subject, '/', book);
        
        % compare it with the given ref_book
        possible_min = minhash(ref_book, bookpath, 50, 50);
        
        fprintf('Similarity with %s: \t\t%.4f', book, possible_min);
        
        % if the similarity is less than the previous minimum, update it
        if(possible_min < min_sim)
            fprintf(' - new minimum!');
            min_sim = possible_min;
            min_book = book;
        end
        fprintf('\n');
    end
end
