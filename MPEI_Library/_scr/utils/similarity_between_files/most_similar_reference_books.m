%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% most_similar_reference_books
%
% (cmp_book, reference_books, library) -> [sim_books]
% 
% Returns the most similar book to the given book,from the given cell array
% reference_books.
% Specialized variant of most_similar_books.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [sim_books] = most_similar_reference_books(cmp_book, reference_books, library)

fprintf('\nReference book: %s\n\n', cmp_book);
max_sim = 0;

% for every book in reference_books,
for k=1:length(reference_books)
    book = reference_books{k};

    % compare it with the given ref_book
    if (strcmp(cmp_book, book))
        sim_books = cmp_book;
        return;
    end
    possible_max = minhash(cmp_book, book, 50, 50);

    fprintf('Similarity with %s: \t\t%.4f', book, possible_max);
    
    % if the similarity is bigger than the previous maximum, update it
    if(possible_max > max_sim)
            fprintf(' - new maximum!');
            max_sim = possible_max;
            sim_books = book;
    end
    fprintf('\n');
end
