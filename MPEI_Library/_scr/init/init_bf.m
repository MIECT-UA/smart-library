%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% init_bf
% 
% (library, force_reset) -> [lib_bf]
%
% Creates a Vanilla Bloom Filter for every file in the library.
% 'force_reset' forces the redoing of this map, even if a saved instance of
% it already exists.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [lib_bf] = init_bf (library, force_reset)

if (exist('lib_bf.mat', 'file') && ~force_reset)
    load lib_bf
else
    % Initialize Bloom Filter
    % dataset has 50 files; assuming in the lifetime of this program, 
    % we won't add more than 10, 20 files, 80 is a fair assumption for the
    % size of the dataset. for more than 80 files, the bloom filter
    % needs to be resized
    m = 80; 
    
    % knowing false positive probability p = (1 - exp^(-km/n))^k [TP16, pag 15] 
    % defining p = 1e-6 and using 
    n = ceil((m * log(1e-6)) / log(1.0 / 2^log(2)));
    
    % Number of ideal hash functions (formula TP16, pag 13)
    k = round((n/m) * log(2));
    
    % Initializes a Bloom Filter
    lib_bf = zeros(1,  n, 'uint8');   
    
    % Add files already in the library
    languages = library('languages');
    for i=1: length(languages)
        
        language = char(languages{i});
        language_map = library(language);
        
        fprintf('%s\n', language);
        
        % get subjects 
        subjects = language_map('subjects');
        
        for j=1:length(subjects)
        
            subject = subjects{j};
            books = language_map(subject);
            
            fprintf('\t%s\n', subject);
            
            % Get books
            for k=1:length(books)
                book = books{k};       
                fprintf('\t\tAdding %s to the bloom filter...\n', book);
                
                bookpath = strcat('../', language, '/', subject, '/', book);
                lib_bf = add_book_bf(bookpath, lib_bf, k);
            end
            fprintf('\n');
        end
            fprintf('\n\n');
    end
    fprintf('All files added!\n');
    
    save lib_bf lib_bf
end