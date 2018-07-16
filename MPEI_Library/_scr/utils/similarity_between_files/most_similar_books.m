%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% most_similar_books
%
% (ref_book, sim_books_num, library) -> [sim_books]
% 
% Returns the sim_books_num most similar books to the given book,
% considering all books from all languages. The returned books will be
% ordered by their similarity, ie. sim_books(1, :) will be the most similar
% book, and sim_books(sim_books_num, :) the least similar of all returned.
% For the sim_books_num most similar books, see instead the specialized
% variant most_similar_books_within_language.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [sim_books] = most_similar_books(ref_book, sim_books_num, library)

% for each language
languages = library('languages');
max_sim = zeros(sim_books_num, 1);
sim_books = cell(sim_books_num);

fprintf('\nReference book: %s\n\n', ref_book);

for i=1:length(languages)
    
    % get language's subjects
    language = languages{i};
    language_map = library(language);
    subjects = language_map('subjects');

    % for every book in the language, 
    for j=1:length(subjects)
        subject = subjects{j};
        books = language_map(subject);

        for k=1:length(books)
            book = books{k};
            bookpath = strcat('../', language, '/', subject, '/', book);

            % compare it with the given ref_book
            if (strcmp(ref_book, bookpath))
                continue;
            end
            possible_max = minhash(ref_book, bookpath, 50, 50);

            fprintf('Similarity with %s: \t\t%.4f', book, possible_max);
            
            % and if it's one of the top sim_books_num most similar books,
            % add to sim_books
            for l=1:sim_books_num
                if(possible_max > max_sim(l, :))
                        fprintf(' - new maximum!');
                    if (l == sim_books_num)
                        max_sim(l, :) = possible_max;
                        sim_books{l} = book;
                    else
                        % add similarity
                        max_sim(l+1:sim_books_num, :) = max_sim(l:sim_books_num-1, :);
                        max_sim(l, :) = possible_max;

                        % add book
                        temp = cell(sim_books_num,1) ;
                        temp(1:l-1) = sim_books(1:l-1);
                        temp(l+1:sim_books_num) = sim_books(l:sim_books_num-1);
                        sim_books = temp;
                        sim_books{l} = book;
                        break; % don't count the same book more than once
                    end
                end
            end
            fprintf('\n');
        end
    end
end
