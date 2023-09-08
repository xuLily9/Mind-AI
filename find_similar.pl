% database
sentence("That is a sunny day").
sentence("That is a happy dog").
sentence("That is a very happy person").

% Calculate the similarity (number of identical words) between two sentences
similarity(Sentence1, Sentence2, Similarity) :-
    tokenize_atom(Sentence1, Tokens1),
    tokenize_atom(Sentence2, Tokens2),
    intersection(Tokens1, Tokens2, CommonTokens),
    length(CommonTokens, CommonTokenCount),
    length(Tokens1, TokenCount1),
    length(Tokens2, TokenCount2),
    Similarity is CommonTokenCount / max(TokenCount1, TokenCount2).

% Find the database sentence that is most similar to the input sentence
most_similar(InputSentence, MostSimilarSentence) :-
    findall(Similarity-Sentence, (sentence(Sentence), similarity(InputSentence, Sentence, Similarity)), Similarities),
    keysort(Similarities, SortedSimilarities),
    reverse(SortedSimilarities, ReversedSimilarities),
    [MostSimilarity-MostSimilarSentence|_] = ReversedSimilarities.
