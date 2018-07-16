%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% VanillaBloomFilter
% 
% (filePath) -> VanillaBloomFilter
%
% Returns VanillaBloomFilter, a normal (vanilla) bloom filter indicating the word belongin to the file @filepath
%  
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [VanillaBloomFilter, k] = VanillaBloomFilter(filepath) 
    fprintf('\nCreating Bloom Filter for words in file %s...\n', filepath);
    
    % Open file
    file = fopen(filepath);
    
    % Returns "null" if file doesn't exist
    if (file == -1)
        VanillaBloomFilter = [];
        return;
    end
    
    % Gets the file contents in the file
    fileContents = fscanf(file, '%c', inf);
    wordsFile = strsplit(fileContents);
    clear fileContents;
    m = length(wordsFile);
    
    % knowing false positive probability p = (1 - exp^(-km/n))^k [TP16, pag 15] 
    % defining p = 1e-6 and using 
    n = ceil((m * log(1e-6)) / log(1.0 / 2^log(2)));
    
    % Number of ideal hash functions (formula TP16, pag 13)
    k = round((n/m) * log(2));
    
    % Initializes a Bloom Filter
    VanillaBloomFilter = zeros(1,  n, 'uint8');   
    
    % Add words to the bloom Filter
    for i = 1: m
        VanillaBloomFilter = InsertVanillaBloomFilter (VanillaBloomFilter, wordsFile{i}, k);
    end
    
    clear wordsFile;
        
    fclose(file);
end
