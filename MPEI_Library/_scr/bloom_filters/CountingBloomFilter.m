%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% countingBloomFilter
% 
% (filePath) -> [CountingBloomFilter, k]
%
% Returns CountingBloomFilter, a counting bloom filter counting the words
% in the file @filepath
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [CountingBloomFilter, k] = CountingBloomFilter(filepath) 
    fprintf('\nCreating Bloom Filter for words in file %s...\n', filepath);
    
    % Open file
    file = fopen(filepath);
    
    % Returns "null" if file doesn't exist
    if (file == -1)
        CountingBloomFilter = [];
        return;
    end
    
    % Gets the file contents in the file
    fileContents = fscanf(file, '%c', inf);
    wordsFile = strsplit(fileContents);
    wordsFile(ismember(wordsFile,{''})) = [];
    clear fileContents;
    m = length(wordsFile);
    
    % knowing false positive probability p = (1 - exp^(-km/n))^k [TP16, pag 15] 
    % defining p = 1e-6 and using 
    n = ceil((m * log(1e-6)) / log(1.0 / 2^log(2)));
    
    % Number of ideal hash functions (formula TP16, pag 13)
    k = round((n/m) * log(2));
    
    % Initializes a Bloom Filter
    CountingBloomFilter = zeros(1,  n, 'uint8');     
    
    % Add words to the bloom Filter
    %fprintf('Adding Words in file %s...\n', filepath);
    %bar = waitbar(0,'Creating Bloom Filter for words...');            % wait bar
    for i = 1: m
        CountingBloomFilter = InsertCountingBloomFilter (CountingBloomFilter, wordsFile{i}, k);
        %valueBar =  i / n;
        %waitbar(valueBar, bar, sprintf('\nCreating Bloom Filter for words in file...\n%.2f%% done.', valueBar * 100))
    end
    
    clear wordsFile;
        
    fclose(file);
end
