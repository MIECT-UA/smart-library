%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% estimate_language
%
% (bookpath, library) -> [language]
% 
% Returns the estimated language of a given book.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [language] = estimate_language(bookpath, library)

reference_language_books = {'../English/Literature/EN_Literature_Ulysses.txt', ...
    %'../English/Mathematics/EN_Mathematics_A Course of Pure Mathematics.txt', ...
    '../French/Literature/FR_Literature_Le Tour Du Monde En Quatre-Vingts Jours de Jules Verne.txt', ...
    %'../French/Mathematics/FR_Mathematics_Sur les Principes Fondamentaux de la Théorie des Nombres et de la Géométrie.txt', ...
    '../German/Biology/DE_Biology_Die Zelle.txt', ...
    %'../German/Literature/DE_Literature_Alice''s Abenteuer Im Wunderland.txt', ...
    %'../Portuguese/Literature/PT_Literature_Viagens da Minha Terra.txt', ...
    '../Portuguese/Literature/PT_Literature_Frei Luís de Souza.txt' };

ref_book = strsplit(most_similar_reference_books(bookpath, reference_language_books, library), '/');

% return the language folder of the chosen reference file
language = char(ref_book(2));