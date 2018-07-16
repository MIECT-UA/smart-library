%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% get_random_top_word
% 
% (language, ref_count_bf, library) -> [word]
%
% Returns the most common word of a randomly chosen file for the given
% language.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function word = get_random_top_word(language, ref_count_bf, library)

% get a random subject
language_map = library(language);
subjects = language_map('subjects');
subjects_num = length(subjects);
subject = subjects{randi([1 subjects_num],1)};

% choose a random book from the randomly chosen subject
books = language_map(subject);
books_num = length(books);
book_index = randi([1 books_num],1);

% get the file's top word
language_count_bf = ref_count_bf(language);
subject_count_bf = language_count_bf(subject);
book_words = subject_count_bf(:, book_index);
word = book_words{1};