%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% TEST_bloom_filters
%
% Tests for the Bloom Filters
% Temporal and precision tests (isDebug = 1 to see precision tests)
% Test Reference: containers.Map from MATLAB
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;

%% Testing Counting Bloom Filter ============================================
isDebug = 1;  % change to 1 to print the results
fprintf('\n------------------------\nTesting Counting Bloom Filter\n');
filepath = '../../English/Biology/EN_Biology_On the Origin of Species.txt';
filepath = 'random_words.txt';

% Get words in file
file = fopen(filepath);
fileContents = fscanf(file, '%c', inf);
wordsFile = strsplit(fileContents);
wordsFile(ismember(wordsFile,{''})) = [];
fclose(file);
n = length(wordsFile);

% Create Bloom Filter
tic
[CountingBloomFilter, k] = CountingBloomFilter(filepath);
toc

% ==========================
% Test Using Maps
tic
fprintf('\nCreating Map for words in file %s...\n', filepath);
Map = containers.Map;
for i = 1 : n
    if (isKey(Map, wordsFile{i})) Map(wordsFile{i}) = Map(wordsFile{i}) + 1;
    else  Map(wordsFile{i}) = 1;
    end
end
toc

% Print word occurrences  ================================================
if isDebug
    wordsFile = sort(unique(wordsFile));     % remove repeated words
    n = length(wordsFile);

    % according to Bloom Filter
    tic
    fprintf('\n------------------------\nUsing Counting Bloom Filter\n');
    for i = 1: n
        word = wordsFile{i};
        fprintf('\t%s -> %d\n', word, Count(CountingBloomFilter, word, k));
    end
    toc

    % according to the map
    tic
    fprintf('\n------------------------\nUsing Map\n');
    for i = 1: n
        word = wordsFile{i};
        value = Map(word);
        fprintf('\t%s -> %d\n', word, value);
    end
    toc
end
clear;

%% Testing Vanilla Bloom Filter ==============================================
isDebug = 1;  % change to 1 to print the results
fprintf('\n------------------------\nTesting Vanilla Bloom Filter\n');
filepath = '../../English/Biology/EN_Biology_On the Origin of Species.txt';
filepath = 'random_words.txt';

% Get words in file
file = fopen(filepath);
fileContents = fscanf(file, '%c', inf);
wordsFile = strsplit(fileContents);
n = length(wordsFile);

% Create Bloom Filter
tic
[VanillaBloomFilter, k] = VanillaBloomFilter(filepath);
toc

% ==========================
% Test Using Maps
tic
fprintf('\nCreating Map for words in file %s...\n', filepath);
Map = containers.Map;
for i = 1 : n
    if (~isKey(Map, wordsFile{i})) Map(wordsFile{i}) = 1;   % 1 means contains
    end
end
toc

% Prints words belonging to the file ==========================================
if isDebug
    % Print occurrences 
    wordsFile = sort(unique(wordsFile));     % remove repeated words
    n = length(wordsFile);

    % according to Bloom Filter
    tic
    fprintf('\n------------------------\nUsing Vanilla Bloom Filter\n');
    for i = 1: n
        word = wordsFile{i};
        fprintf('\t%s -> %d\n', word, IsMember(VanillaBloomFilter, word, k));
    end
    toc

    % according to the map
    tic
    fprintf('\n------------------------\nUsing Map (1:: Belongs, 0:: Does not belong\n');
    for i = 1: n
        word = wordsFile{i};
        fprintf('\t%s -> %d\n', word, isKey(Map, word));
    end
    toc
end
clear;
