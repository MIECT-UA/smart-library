%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% most_common_words_file
%
% (filepath) -> [most_common_words]
% 
% Returns a cell array with the 100 most common words (ie most ocurring
% words) in the file specified by the filepath.
% The number of common words is customizable by changing the value of  
% 'number'.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [most_common_words] = most_common_words_file(filepath)
    tic
    number = 100;

    % Open File
    file = fopen(filepath);
    fileContents = fscanf(file, '%c', inf);
    wordsFile = strsplit(fileContents);
    wordsFile(ismember(wordsFile,{''})) = [];
    fclose(file);
    n = length(wordsFile);
    
    % If there are less than number words, wordsFile 
    % is the set of most common words
    if (n <= number) 
        most_common_words = wordsFile;
        return
    end
    
    % Create Bloom Filter
    [BloomFilter, k] = CountingBloomFilter(filepath);
    m = length(BloomFilter);

    % Get Unique words
    wordsFile = sort(unique(wordsFile));
    n = length(wordsFile);

    % Solution tried (didn't work for all words)
    % Get indexes for max values in the bloom filter (ie indexs for the
    % hash values of the most common words)
    %[temp, originalpos] = sort(BloomFilter, 'descend');
    %maxIndexes = originalpos(1:number);
       
    % Count words
    fprintf('\nCounting Words...\n');
    values = zeros(n, 1);
    for i = 1: n
        word = wordsFile{i};
        values(i) = Count(BloomFilter, word, k);

        % Solution tried : continuation 
        % compute hashs using string2hash
        %h = rem(n_independent_hashes(word, k), m) + 1;

        % if it's one of the max indexes (with more counts)
        % if (length(intersect(maxIndexs,h))~=0)
            % it's a common word :: add to the cell array of most common
            % words
            % most_common_words{index} = word;
            % values(index) = Count(BloomFilter, word, k);
            % index = index + 1;
        % end
        
    end
    fprintf('\nDone\nCreating table...\n');
     
    % Creates table wordsFile -> values
    wordsFile = wordsFile';             % since wordsFile is going to be a column of the table
    t = table(wordsFile, values);
    
    % Sorts table
    t = sortrows(t, 2, 'descend');
    
    % Gets first number words
    t = t(1:number, 1);
    most_common_words = table2cell(t);
   
    clear t;
    
    fprintf('\nDone\n');
    toc

end