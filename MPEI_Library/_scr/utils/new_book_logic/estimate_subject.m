%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% estimate_subject
%
% (new_book_path, language, hashes_num, ref_count_bf, library) -> [subject]
% 
% Returns the estimated subject of a given book.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function subject = estimate_subject(new_book_path, language, hashes_num, ref_count_bf, library)

% find the most common words of the new book
new_book_count_bf = most_common_words_file(new_book_path);
hashmap = cell_reference_hash(new_book_count_bf, hashes_num);

% get all subjects of the language, and their counting bloom filters
subjects_map = library(language);
subjects = subjects_map('subjects');
subject_num = length(subjects);

subjects_count_bf = ref_count_bf(language);

% for each subject of the language, find the most similar
for j=1:subject_num
    subject = subjects{j};
    book_num = length(subjects_map(subject));
    
    count_bf = subjects_count_bf(subject);
    sim_subjects(j, :) = shingle_minhash(count_bf(:,1), new_book_count_bf, hashmap, hashes_num, hashes_num);
    
    % get max similarity the subject
    % (this for loop can be removed without consequence, and makes the code
    % approximately 4 times faster, but including it allows more precision)
%     for k=2:book_num
%         possible_max_sim = shingle_minhash(count_bf(:,k), new_book_count_bf, hashmap, hashes_num, hashes_num);
%         if (possible_max_sim > sim_subjects(j, :))
%             sim_subjects(j, :) = possible_max_sim;
%         end
%     end
end

[~, max_ind] = max(sim_subjects);
subject = char(subjects{max_ind});