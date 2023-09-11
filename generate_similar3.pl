% Define synonyms for words
%synonyms("I", ["I", "myself", "me"]).
synonyms("want", ["want", "desire", "wish"]).
synonyms("to", ["to", "towards", "for", "in the direction of"]).
synonyms("book", ["book", "reserve", "purchase", "get", "secure"]).
synonyms("a", ["a", "an"]).
synonyms("flight", ["flight", "airfare", "journey", "trip", "voyage"]).
synonyms("to", ["to", "towards", "for", "in the direction of"]).
synonyms("Paris", ["Paris", "the City of Light", "the French capital"]).


% Generate a sentence with replaced words
generate_similar_sentence(OriginalSentence, SimilarSentence) :-
    split_string(OriginalSentence, " ", " ", OriginalWords), % This splits the OriginalSentence into a list of words OriginalWords.
    maplist(replace_word_in_wordlist, OriginalWords, _Synonyms, SimilarWords), %This maps replace_word_in_wordlist over each word in OriginalWords to generate a list of SimilarWords with synonyms replaced.
    atomic_list_concat(SimilarWords, ' ', SimilarSentence).
 
% Replace a word in a list with a synonym， 
replace_word_in_wordlist(Word, Synonyms, Synonym) :-
    (synonyms(Word, Synonyms) ->
        random_member(Synonym, Synonyms) %This does the actual word replacement. It looks up the synonyms for the Word. If any are found, it randomly chooses one. Otherwise, it just keeps the original Word.
    ; % If no synonyms are available, keep the original word
        Synonym = Word
    ).

% Generate 20 similar sentences based on a seed sentence
generate_20_similar_sentences(SeedSentence, SimilarSentences) :-
    generate_20_similar_sentences_helper(SeedSentence, [], SimilarSentences). 

generate_20_similar_sentences_helper(_, SimilarSentences, SimilarSentences) :- length(SimilarSentences, 20).
generate_20_similar_sentences_helper(SeedSentence, Acc, SimilarSentences) :-
    generate_similar_sentence(SeedSentence, SimilarSentence),
    \+ member(SimilarSentence, Acc),  % Ensure no duplicates. This checks that the new sentence is not already in the accumulator list Acc.
    generate_20_similar_sentences_helper(SeedSentence, [SimilarSentence|Acc], SimilarSentences). %This recursively adding the new sentence to the accumulator.

% Pretty print a list of sentences
pretty_print_sentences([]).
pretty_print_sentences([Sentence|Rest]) :-
    format("~w~n", [Sentence]),
    pretty_print_sentences(Rest).

% Example usage:

%generate_20_similar_sentences("I want to book a flight to Paris", X),pretty_print_sentences(X).