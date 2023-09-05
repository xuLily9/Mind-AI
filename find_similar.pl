% Define similarity rules based on Jaccard similarity.
jaccard_similarity(S1, S2, Similarity) :-
    atomic_list_concat(Words1, ' ', S1),
    atomic_list_concat(Words2, ' ', S2),
    intersection(Words1, Words2, Intersection),
    union(Words1, Words2, Union),
    length(Intersection, IntLen),
    length(Union, UnionLen),
    Similarity is IntLen / UnionLen.

% Database of sentences.
sentence('I adore sunny weather').
sentence('I hate rainy days').
sentence('Sunny days make me happy').

% Find the most similar sentence.
find_most_similar(Input, MostSimilar) :-
    sentence(MostSimilar),  % Initialize MostSimilar with the first sentence.
    jaccard_similarity(Input, MostSimilar, MaxSimilarity),
    find_most_similar(Input, MostSimilar, MaxSimilarity).

find_most_similar(_, _, _).
find_most_similar(Input, CurrentMostSimilar, MaxSimilarity) :-
    sentence(NextSentence),
    jaccard_similarity(Input, NextSentence, Similarity),
    Similarity > MaxSimilarity,
    find_most_similar(Input, NextSentence, Similarity).

find_most_similar(Input, CurrentMostSimilar, MaxSimilarity) :-
    sentence(NextSentence),
    jaccard_similarity(Input, NextSentence, Similarity),
    Similarity =< MaxSimilarity,
    find_most_similar(Input, CurrentMostSimilar, MaxSimilarity).
