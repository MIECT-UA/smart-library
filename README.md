# Smart Library

A 2-person group project done for a class on Probabilistic Methods, where we decided to implement an intelligent library. That is, a system which can automatically detect a text's language, and sort it into one of several categories according to its subject. If a given file is not already in the library, it's added to it, in its corresponding language and subject. To this end, MinHashes, a vanilla bloom filter (used to check whether the file already existed in the library), and a counting bloom filter (designed to supplement the 'choice' of a given text's subject) were used.

This project was done in MATLAB. It was also heavily test-driven.

Contributors: Beatriz Borges R (@obiwit), Pedro Teixeira (@pedrovt)
