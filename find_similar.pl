% Database with sentences and their synonyms
sentence("That is a sunny day").
sentence("That is a happy dog").
sentence("That is a very cheerful person").

% Define synonyms
synonym(happy, cheerful).

% Calculate the similarity between two sentences considering synonyms
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
    findall(Similarity-Sentence,
        (sentence(Sentence), similarity(InputSentence, Sentence, Similarity)),
        Similarities),
    keysort(Similarities, SortedSimilarities),
    reverse(SortedSimilarities, ReversedSimilarities),
    [MostSimilarity-MostSimilarSentence|_] = ReversedSimilarities.

% Modify the input sentence to include synonyms
modify_input_sentence(InputSentence, ModifiedSentence) :-
    tokenize_atom(InputSentence, Tokens),
    findall(Synonym, (member(Token, Tokens), synonym(Token, Synonym)), Synonyms),
    append(Tokens, Synonyms, ModifiedTokens),
    atomic_list_concat(ModifiedTokens, ' ', ModifiedSentence).

% Query with the modified input sentence
%?- modify_input_sentence("That is a happy person", ModifiedInput),
 %  most_similar(ModifiedInput, MostSimilar).
