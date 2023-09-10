% creating a simple "database" of sentences to use for testing similarity.
sentence("That is a sunny day").
sentence("That is a happy dog").
sentence("That is a very cheerful person").

% Define synonyms
synonym(happy, cheerful).

% Calculate the similarity between two sentences considering synonyms
similarity(Sentence1, Sentence2, Similarity) :-
    tokenize_atom(Sentence1, Tokens1), % splits each sentence into a list of word tokens.
    tokenize_atom(Sentence2, Tokens2), 
    intersection(Tokens1, Tokens2, CommonTokens), % finds the tokens that are in common between the two sentences.
    length(CommonTokens, CommonTokenCount),
    length(Tokens1, TokenCount1), % the count of the common tokens.
    length(Tokens2, TokenCount2),
    Similarity is CommonTokenCount / max(TokenCount1, TokenCount2).

% Find the database sentence that is most similar to the input sentence
% Compare input sentence to each database sentence
% Calculate similarity scores
% Sort scores descending
% Return the top matching sentence
most_similar(InputSentence, MostSimilarSentence) :-
    findall(Similarity-Sentence,
        (sentence(Sentence), similarity(InputSentence, Sentence, Similarity)),
        Similarities),
    keysort(Similarities, SortedSimilarities),
    reverse(SortedSimilarities, ReversedSimilarities),
    [MostSimilarSentence|_] = ReversedSimilarities.


% Modify the input sentence to include synonyms
modify_input_sentence(Input, Modified) :-
    tokenize_atom(Input, Tokens), % split the input sentence into a list of word tokens
    findall(Synonym, (member(Token, Tokens), synonym(Token, Synonym)), Synonyms),
    append(Tokens, Synonyms, ModifiedTokens),
    atomic_list_concat(ModifiedTokens, ' ', Modified). % joins the concatenated token list back into a single string/sentence with spaces between each word

find_similar(Input,MostSimilar):-
    modify_input_sentence(Input, Modified),
    most_similar(Modified, MostSimilar).

% Query with the modified input sentence
%?- find_similar("That is a happy person", Output).
