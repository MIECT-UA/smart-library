%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% init_ref_count_bf
% 
% (library, hashes_num, force_reset) -> [ref_count_bf]
%
% Creates a counting bloom filter for every file in the library, using a
% map. 'force_reset' forces the redoing of this map, even if a saved
% instance of it already exists.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ref_count_bf = init_ref_count_bf(library, hashes_num, force_reset)


if (exist('ref_count_bf.mat', 'file') && ~force_reset)
    load ref_count_bf
else
    
    % get all languages in the library, and
    languages = library('languages');
    ref_count_bf = containers.Map;

    for i=1:length(languages)

        language = languages{i};
        language_map = library(language);
        subjects = language_map('subjects');
        subject_num = length(subjects);

        subject_count_bf = containers.Map;
        
        % for every book in the language, 
        for j=1:subject_num
            subject = subjects{j};
            books = language_map(subject);
            books_num = length(books);

            count_bf = cell (100, books_num);

            % get all books on the subject
            for k=1:books_num

                % create a counting bloom filter for each file
                book_path = strcat('../', language, '/', subject, '/', books{k});

                count_bf(:,k) = most_common_words_file(book_path);
                cell_reference_hash(count_bf(:,k), hashes_num);
            end
            subject_count_bf(subject) = count_bf;
        end
        ref_count_bf(language) = subject_count_bf;
    end
    
    save ref_count_bf ref_count_bf
end